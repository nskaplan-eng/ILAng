/// \file
/// Verilog Generator
#include <string>
#include "verilog-out/verilog_gen.h"

namespace ila {

#define toStr(x) (std::to_string(x))

VerilogGenerator::VerilogGenerator (const std::string &modName,const std::string &clk,const std::string &rst, const VlgGenConfig & config)
  : moduleName(modName)
  , clkName(clk)
  , rstName(rst)
  , idCounter(0)
  , cfg_(config)
{}

/// Check if a name is reserved (clk/rst/moduleName/decodeNames/ctrName)
bool VerilogGenerator::check_reserved_name(const vlg_name_t & n) const {
  if(n == moduleName || n == clkName || n == rstName || n == validName)
    return false;
  for(auto && sig : decodeNames) {
    if( sig.first == n ) 
      return false;
  }
  return true;
}

// Currently not used, can be added to enforce sanity check
#define CHECK_NAME(s) (ILA_ERROR_IF( !check_reserved_name(s) ) << "Name "<<(s) << " is reserved, which should not be used" );
#define EXISTS_NAME(n,w)  ( all_valid_names.find( { (n), (w) } ) != all_valid_names.end() )
#define ADD_NAME(n,w)  all_valid_names.insert( { (n), (w) } )

/// Get the width of an ExprPtr, must be supported sort, NOTE: function is not an exp
/// Do we really need it?
int VerilogGenerator::get_width(const ExprPtr &n) const {
  if( n->sort()->is_bool() )
    return 1;
  if( n->sort()->is_bv() )
    return n->sort()->bit_width();
  if( n->sort()->is_mem() )
    return n->sort()->data_width(); // NOTE : here we get the data width

  ILA_ASSERT(false)<<"Unable to get the width for sort "<< n->sort();
}
/// convert a widith to a verilog string
std::string VerilogGenerator::WidthToRange(int w) const {
  if(w>1)
    return std::string("[") + toStr(w-1) + ":0]";
  return "";
}
/// get a new id
vlg_name_t VerilogGenerator::new_id() {
  return "n" + toStr(idCounter++);
}
/// if the exprptr contains some meaning in its name, will try to incorporate that to the name;
vlg_name_t VerilogGenerator::new_id(const ExprPtr & e){ 
  if (!e)
    return new_id();

  auto name = e->name().str();
  auto pos = reference_name_set.find(name);
  if( pos == reference_name_set.end() ) // not registered to the refererence name set
    return new_id(); // just return the plain name
  return "n" + toStr(idCounter++) + "__" + pos.second;
}
//--------------------------------------------------------------------------

void VerilogGenerator::add_input(const vlg_name_t & n,int w)
{
  inputs.push_back(vlg_sig_t(n,w));
}
void VerilogGenerator::add_output(const vlg_name_t & n,int w)
{
  outputs.push_back(vlg_sig_t(n,w));
}
void VerilogGenerator::add_wire(const vlg_name_t & n,int w)
{
  wires.push_back(vlg_sig_t(n,w));
}
void VerilogGenerator::add_reg(const vlg_name_t & n,int w)
{
  regs.push_back(vlg_sig_t(n,w));
}
void VerilogGenerator::add_stmt(const vlg_stmt_t & s) // you need to put ';' but no need for \n
{
  statements.push_back(s);
}
void VerilogGenerator::add_assign_stmt(const vlg_name_t & l, const vlg_name_t & r)
{
  add_stmt( "assign " + l + " = " + r + " ;" );
}
void VerilogGenerator::add_always_stmt(const vlg_stmt_t & s)
{
  always_stmts.push_back(s);
}
void VerilogGenerator::add_init_stmt(const vlg_stmt_t & s)
{
  init_stmts.push_back(s);
}
void VerilogGenerator::add_ite_stmt(const vlg_stmt_t & cond, const vlg_stmt_t & tstmt, const vlg_stmt_t & fstmt)
{
  ite_stmts.push_back(std::make_tuple(cond,tstmt,fstmt));
}

// the mems to be created 
void VerilogGenerator::add_internal_mem(const vlg_name_t &mem_name, int addr_width,int data_width)
{
  mems_internal.insert( { mem_name , vlg_mem_t(mem_name,addr_width,data_width) } );
}
void VerilogGenerator::add_external_mem(const vlg_name_t &mem_name, int addr_width,int data_width)
{
  mems_external.insert( { mem_name , vlg_mem_t(mem_name,addr_width,data_width) } );
  /* NO, this should not be done
  vlg_name_t addr_name = mem_name + "_addr_" + new_id();
  vlg_name_t data_name = mem_name + "_data_" + new_id();
  mem_o.push_back( vlg_sig_t(addr_name, addr_width) );
  mem_i.push_back( vlg_sig_t(data_name, data_width) );
  */
}
//--------------------------------------------------------------------------
void VerilogGenerator::insertInput( const ExprPtr & input ) {
  ILA_ASSERT( input->is_var() );
  // we need to consider the case of an input memory
  if( input->is_mem() ) {
    ILA_ASSERT(false) << "NOT implemented"; //FIXME: add wires to read from external
    // when in expr parse, remember it is (EXTERNAL mem)
    add_external_mem( input->name().str(), // name
                      input->sort()->addr_width(), // addr_width
                      input->sort()->data_width() );
  }
  else{
    add_input( input->name().str() , get_width(input) );
    add_wire ( input->name().str() , get_width(input) );
  }
}

void VerilogGenerator::insertState( const ExprPtr & state ) {
  ILA_ASSERT( state->is_var() );
  if( state->is_mem() ) { // depends on configuration, we choose to put into mem_external/mem_internal
    if( cfg_.extMem ) {
      add_external_mem( input->name().str(), // name
                        input->sort()->addr_width(), // addr_width
                        input->sort()->data_width() );
    }
    else {
      add_internal_mem( input->name().str(), // name
                        input->sort()->addr_width(), // addr_width
                        input->sort()->data_width() );
    }
  }
  else if( state->is_bv() ) {
    add_reg( state->name().str(), state->sort()->bit_width() );
  }
  else if(state->is_bool()  ) {
    add_reg( state->name().str(), 1 );
  }
  
}

//
//  will export decode/start/...
//  reg [width-1:0] __COUNTER_start__id;  // 0 : WAIT TO START , 1 : First Cycle after decode is true
//  (init: __COUNTER__id )
//
//
//
//

void VerilogGenerator::addInternalCounter( vlg_name_t decode_sig_name , size_t width ) {
  counterName = "__COUNTER_start__" + new_id();
  auto max_val = std::pow(2,width)-1;
  auto inc_cond = "(" + counterName + " >= 1 ) && ( " + counterName + " < " + toStr(max_val) + " )";
  add_reg( counterName );
  add_init_stmt( counterName + " <= 0;"  );
  add_ite_stmt( /*Cond*/ decode_sig_name , /*True*/ counterName + " <= 1"  , "" );
  add_ite_stmt( /*Cond*/ inc_cond , /*True*/ counterName + " <= "+ counterName +" + 1"  , "" );
}

//--------------------------------------------------------------------------


void VerilogGenerator::parseArg(const ExprPtr & e) {
  for (size_t i = 0; i != e->arg_num() ; ++ i) {
    ParseNonMemUpdateExpr( e->arg(i) );
  }
}

void VerilogGenerator::getVlgFromExpr(const ExprPtr & e) {
  auto pos = nmap.find(e);
  ILA_ASSERT( pos != nmap.end() ) << "Expr:"<< (*e) << " has not been translated yet";
  return pos->second;
}
void VerilogGenerator::getArg(const ExprPtr & e, const size_t & i ) {
  auto arg_i = e->arg(i);
  return getVlgFromExpr(arg_i);
}



VerilogGenerator::vlg_name_t VerilogGenerator::translateApplyFunc( std::shared_ptr<ExprOpAppFunc> func_app_ptr_ )
{
    ILA_NOT_NULL(func_app_ptr_);
    int width = func_app_ptr_->sort()->is_bool() ? 1 : func_app_ptr_->sort()->bit_width();
    if ( func_app_ptr_->arg_num() == 0 ) { 
      // 0-arg should be treated as nondet (input) , this should be fine for both Yosys and JasperGold
      result_stmt = "nondet_" + func_app_ptr_->func()->name().str() + "_" + new_id();
      add_wire ( result_stmt, width);
      add_input( result_stmt, width);
    }
    else {
      func_ptr_set.insert( func_app_ptr_->func() ); // record that we have met this function, later may need to declare a module if internal
      if(cfg_.funcOpt == VlgGenConfig::funcOption::Internal) { 
        // here we create a module to do this
        result_stmt = new_id(func_app_ptr_);
        add_wire( result_stmt, width ); 
        vlg_stmt_t funcInstantiation = "fun_"+ func_app_ptr_->func()->name().str() + "  "+"applyFunc_"+new_id() + "(\n";
        size_t arity = func_app_ptr_->arg_num();
        for (int i = 0; i != arity; i++) {
            ILA_ASSERT( func_app_ptr_->arg(i)->is_bool() || func_app_ptr_->arg(i)->is_bv() ) << "unable to translate f(mem, ...)" ;
            funcInstantiation +=  "    .arg"+toStr(i)+"( " + getArg(func_app_ptr_, i) + " ),\n";
        }
        funcInstantiation += "    .result( " + result_stmt + " )\n" ;
        funcInstantiation += ");";
        add_stmt(funcInstantiation);
        // we need to remember that later we will need to put a module : 
        // fun_(funName) (arg0-argn, result)
      }
      else if (cfg_.funcOpt == VlgGenConfig::funcOption::External) {
        // here we need to generate the input/output
        vlg_name_t prefix =  "fun_" + func_app_ptr_->func()->name().str() + "_applyFunc_"+new_id();
        vlg_name_t resultName = prefix + "_result";
        add_input( resultName, width );
        add_wire ( resultName, width );
        result_stmt = resultName;

        size_t arity = func_app_ptr_->arg_num();
        for (size_t i = 0; i != arity; i++) {
            vlg_name_t argOutName = prefix + "_arg"+toStr(i);
            ILA_ASSERT( func_app_ptr_->arg(i)->is_bool() || func_app_ptr_->arg(i)->is_bv() ) << "unable to translate f(mem, ...)" ;
            int argWidth = get_width( func_app_ptr_->arg(i) );
            add_wire  (argOutName,argWidth);
            add_output(argOutName,argWidth);
            add_assign_stmt( argOutName, getArg(func_app_ptr_, i) );
        }
      }
      else ILA_ASSERT(false) << "Unsupported function export option";
    }
}

// will be used by ParseNonMemUpdateExpr, will not be directly called by ParseMemUpdateNode
// the later will call the former first
VerilogGenerator::vlg_name_t VerilogGenerator::translateBoolOp( const ExprOp & e ) {
  vlg_stmt_t result_stmt;
  std::string op_name = e->op_name();
  size_t arg_num = e->arg_num();

  if (op_name == "APP") { // Function application
    // deal with the case with a function
    std::shared_ptr<ExprOpAppFunc> func_app_ptr_ = std::dynamic_pointer_cast<ExprOpAppFunc>(e);
    translateApplyFunc(func_app_ptr_);
  }
  else if(arg_num == 1) {
    if( op_name == "NOT" )
      result_stmt = "~ ( " + getArg( e, 0 ) + " ) ";
    else
      ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";
  }
  else if(arg_num == 2) {
    auto arg1 = getArg(e, 0);
    auto arg2 = getArg(e, 1);
    if (op_name == "AND")
      result_stmt = " ( " + arg1 + " ) & (" + arg2 + " ) ";
    else if(op_name == "OR")
      result_stmt = " ( " + arg1 + " ) | ( " +  arg2 + " ) ";
    else if(op_name == "XOR")
      result_stmt = " ( " + arg1 + " ) ^ ( " +  arg2 + " ) ";
    else if(op_name == "EQ")
      result_stmt = " ( " + arg1 + " ) == ( " +  arg2 + " ) ";
    else if(op_name == "IMPLY")
      result_stmt = " ( ~ ( " + arg1 + " ) | ( " +  arg2 + " ) )"; // do we need to support boolean comparison?
    else if(op_name == "EQ")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) == ( " +  arg2 + " ) ";
    else if(op_name == "LT")
      result_stmt = vlg_stmt_t(" $signed( ") + arg1 + " ) < $signed( " +  arg2 + " ) ";
    else if(op_name == "GT")
      result_stmt = vlg_stmt_t(" $signed( ") + arg1 + " ) > $signed( " +  arg2 + " ) ";
    else if(op_name == "ULT")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) < ( " +  arg2 + " ) ";
    else if(op_name == "UGT")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) > ( " +  arg2 + " ) ";
    else
      ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";
  }
  else if(arg_num == 3) {
    auto arg1 = getArg(e, 0);
    auto arg2 = getArg(e, 1);
    auto arg3 = getArg(e, 2);
    if (op_name == "ITE")
      result_stmt = " ( "  + arg1 +" ) ? ( " + arg2 + " ) : ( " + arg3 + " ) ";
    else
      ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";
  }
  vlg_name_t result_var = new_id( e );
  add_wire(result_var , 1);
  add_assign_stmt( result_var, result_stmt );
  return result_var;
}

// will be used by ParseNonMemUpdateExpr, will not be directly called by ParseMemUpdateNode
// the later will call the former first
VerilogGenerator::vlg_name_t VerilogGenerator::translateBvOp( const ExprOp & e ) {
  vlg_stmt_t result_stmt;
  std::string op_name = e->op_name();
  size_t arg_num = e->arg_num();

  if (op_name == "APP") { // Function application
    // deal with the case with a function
    // deal with the case with a function
    std::shared_ptr<ExprOpAppFunc> func_app_ptr_ = std::dynamic_pointer_cast<ExprOpAppFunc>(e);
    translateApplyFunc(func_app_ptr_);
  }
  else if(arg_num == 1) {
    vlg_name_t arg0 = getArg(e, 0);
    if(op_name == "NEGATE") // negate : 2's complement
      result_stmt = vlg_stmt_t("( ~ ( ") + arg0 + " ) + 1'b1 )";
    else if(op_name == "COMPLEMENT") // 1's complement
      result_stmt = vlg_stmt_t("~ ( ") + arg0 + " )";
    else if(op_name == "EXTRACT") {
      int hi = e->param(0);
      int lo = e->param(1);
      result_stmt = arg0 + "[" + toStr(hi) +":"+toStr(lo) +"]";
    } else if(op_name == "ZERO_EXTEND") {
      int outw = e->param(0);
      int inw  = get_width(e);
      if( outw == inw) result_stmt = arg0;
      else result_stmt = vlg_stmt_t(" {") + toStr(outw - inw) +"'d0 , " + arg0 + "} ";
    } else if(op_name == "SIGN_EXTEND") {
      int outw = e->param(0);
      int inw  = get_width(e);
      if( outw == inw) result_stmt = arg0;
      else result_stmt = vlg_stmt_t(" { {") + toStr(outw - inw) +"{"+ arg0 +"["+ toStr(inw-1)  + "] }  }, " + arg0 + "} ";
    } else ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";
  } // else if(arg_num == 1)
  else if(arg_num == 2) {
    vlg_name_t arg1 = getArg(e, 0);
    vlg_name_t arg2 = getArg(e, 1);
    if(op_name == "AND")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) & ( " +  arg2 + " ) ";
    else if(op_name == "OR")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) | ( " +  arg2 + " ) ";
    else if(op_name == "XOR")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) ^ ( " +  arg2 + " ) ";
    else if(op_name == "SHL") // only shift, use 0 on the right
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) << ( " +  arg2 + " ) ";
    else if(op_name == "ASHR") // arithmetic shift right
      result_stmt = vlg_stmt_t(" ( $signed( ") + arg1 + " ) >>> ( " +  arg2 + " )) ";
    else if(op_name == "LSHR")
      result_stmt = vlg_stmt_t(" ( ( ") + arg1 + " ) >> ( " +  arg2 + " )) ";
    else if(op_name == "ADD")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) + ( " +  arg2 + " ) ";
    else if(op_name == "SUB")
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) - ( " +  arg2 + " ) ";
    else if(op_name == "CONCAT")
      result_stmt = vlg_stmt_t(" { ( ") + arg1 + " ) , ( " +  arg2 + " ) } ";
    else if(op_name == "LOAD") { 
      // arg1 should be the memvar // arg2 should be the address
      // in the future, we may need to avoid the leaves first traverse to account for 
      // the LOAD(STORE) LOAD(ITE)
      ILA_ASSERT( e->arg(0)->is_var() ) << "Implementation bug: unable to handle LOAD(STORE/ITE/MEMCONST) pattern";
      auto mem_var_name = e->arg(0)->name().str();
      auto pos = mems_external.find( mem_var_name );
      if( pos != mems_external.end() ) {
        // should generate signals (for mem_i/mem_o)
        int addr_width = std::get<1>(pos.second);
        int data_width = std::get<2>(pos.first);
        vlg_name_t addr_name = arg1 + "_addr_" + new_id();
        vlg_name_t data_name = arg1 + "_data_" + new_id();
        mem_o.push_back( vlg_sig_t(addr_name, addr_width) );
        mem_i.push_back( vlg_sig_t(data_name, data_width) );
        add_wire( addr_name, addr_width );
        add_wire( data_name, data_width );

        add_assign_stmt( addr_name, arg2 );
        
        result_stmt = data_name;
      } // if( pos != mems_external.end() ) 
      else
        result_stmt = vlg_stmt_t(" (  ") + mem_var_name + " [ " +  arg2 + " ] ) ";
    } // else if(op_name == "LOAD")
    else ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";
  } // else if(arg_num == 2)
  else if(arg_num == 3) {
    vlg_name_t arg1 = getArg(e, 0);
    vlg_name_t arg2 = getArg(e, 1);
    vlg_name_t arg3 = getArg(e, 2);
    if(op_name == "ITE") 
      result_stmt = vlg_stmt_t(" ( ") + arg1 + " ) ? ( " +  arg2 + " ) : ( " + arg3 + " )";
    else ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";
  } // else if(arg_num == 3)
  else ILA_ASSERT(false) << op_name << " is not supported by VerilogGenerator";

  vlg_name_t result_var = new_id( e );
  add_wire(result_var , get_width(e) ) ;
  add_assign_stmt( result_var, result_stmt );
  return result_var;

}


//--------------------------------------------------------------------------
// used in general for an expression (not the update of a memvar)
void VerilogGenerator::ParseNonMemUpdateExpr( const ExprPtr & e ) { // will be used in parsing state update of non mem and decode function
  // memorize
  if( nmap.find(e) != nmap.end() ) return;

  if( e->is_bool() ) {
    if( e->is_var() )
      nmap[e] = e->name().str(); // just use its name
    else if( e->is_op() ) { // bool op
      // leaves first,
      parseArg(e);
      std::shared_ptr<ExprOp> expr_op_ptr = std::dynamic_pointer_cast<ExprOp>( e );
      ILA_NOT_NULL(expr_op_ptr);
      nmap[e] = translateBoolOp(expr_op_ptr);
    }
    else if( e->is_const() ) { // bool const
      vlg_name_t bcnst = vlg_name_t("1'b") + ( std::dynamic_pointer_cast<ExprConst>(e)->val_bool()->val() ? "1" : "0" );
      nmap[e] = bcnst;
    }
    else
      ILA_ASSERT(false) << "Expr sort: "<< *( e->sort() ) << " is not supported." ;
  }
  else if( e->is_bv() ) {
    if( e->is_var() )
      nmap[e] = e->name().str(); // just use its name
    else if( e->is_op() ) {
      // leaves first
      std::shared_ptr<ExprOp> expr_op_ptr = std::dynamic_pointer_cast<ExprOp>( e );
      ILA_NOT_NULL(expr_op_ptr);

      parseArg(e); // FIXME: if not LOAD, leaf-first
      // BTW, you cannot cache the LOAD(STORE/ITE/MEMCONST) pattern
      nmap[e] = translateBvOp(expr_op_ptr);
    }
    else if( e->is_const() ) {
      int width = get_width( e );
      vlg_name_t bvcnst = toStr(width) + "'d" + ( std::dynamic_pointer_cast<ExprConst>(e)->val_bv()->str() );
    }
    else
      ILA_ASSERT(false) << "Expr sort: "<< *( e->sort() ) << " is not supported." ;

  }
  else if( e->is_mem() ) {
    // TODO: ? 
    if( e->is_var() )
      nmap[e] = e->name().str(); // should not be used
    else if(e->is_const() )
      nmap[e] = e->name().str(); // should not be used, currently unsupported
    else if( e->is_op() )
      ILA_ASSERT(false) << "Implementation bug, do not support mem_op ( LOAD(STORE/ITE/MEMCONST) pattern ) in non-mem-update expression";
    // NOTE: EVEN when we later implement the three LOAD(STORE/ITE/MEMCONST) pattern
    // it should not come to this point, because the load will do a root-first traversal
    // it should not come to this point first
    else ILA_ASSERT << "Expr sort: "<< *( e->sort() ) << " is not supported." ;
    // (Yes we may encounter the var case), just return its name (but I think it will not be used anyway)
    // (Yes we may encounter the memconst case), currently not handled, so just return its name is fine
  }
  else 
    ILA_ASSERT(false) << "Expr sort: "<< *( e->sort() ) << " is not supported." ;

}
// One more note: 
//    If you have the load(MemIte(var1,var2), addr)
//    please rewrite it as BvIte(load(var1,addr), load(var2,addr))
//    we always enforce the requirement that MemIte must talk about the same mem

// (for the update of a memvar)
// we support patterns like store(ite) ite(store) and their combination
// but we require that all must refer to the same mem_var (CheckMemUpdateNode will check AST)
// for the memconst, we can support by initial condition, like 
//     a) memvar == memstore(memstore(memstore))
//       - but memvar must be an internal memory*
//      M1: can be converted to : if(rst) { memvar[?] <= ... ; memvar[?] <=  } 
//        or
//      M2: we can try replace the 
//      * restriction may be lifted, if we create an internal mem, 
//        and use condition to say which to read (internal/external) where we read the 
//
//     b) memvar == memconst
//     this is more difficult as it has the default value requirement
//     
// currently, let's not worry about initialization
// as we are verify just one instruction
// for the child-abs, their initial condition should be set by the 
// parent instruction
bool VerilogGenerator::CheckMemUpdateNode( const ExprPtr & e , const std::string & mem_var_name ) {
  ILA_ASSERT( e->is_mem() ); // require it to be memory
  if( e->is_const() ) 
    return false;
  else if( e->is_var() ) {
    if(e->name().str() == mem_var_name) 
      return true;
    // else
    return false;
  } else if( e->is_op() ) {
    std::shared_ptr<ExprOp> expr_op_ptr = std::dynamic_pointer_cast<ExprOp> (e);
    ILA_NOT_NULL(expr_op_ptr);
    if(expr_op_ptr -> op_name() == "STORE" ) 
      return CheckMemUpdateNode(expr_op_ptr->arg(0), mem_var_name) ; // it depends if its subtree conforms to the pattern.
    if(expr_op_ptr -> op_name() == "ITE")
      return CheckMemUpdateNode(expr_op_ptr->arg(0), mem_var_name) && CheckMemUpdateNode(expr_op_ptr->arg(1), mem_var_name);
    return false;
  }  // ITE/STORE
  // else
  return false;
}

// Traverse this update expr
// root first
// collect writes and their conditions
void VerilogGenerator::VisitMemNodes( const ExprPtr & e,
  const ExprPtr & cond, mem_write_entry_list_stack_t& writesStack ) {
  //ILA_ASSERT( e->is_var() || e->is_op() ) 

  if( e->is_var() ) {
    // we reach the leaf, summary the conditions and writes so far and save them
    mem_write_entry_list_t writes = writesStack.back();
    mem_write_t mw = {cond, writes};
    current_writes.push_back(mw);
  }
  else {
    //ILA_ASSERT( e->is_op() );
    std::shared_ptr<ExprOp> expr_op_ptr = std::dynamic_pointer_cast<ExprOp>(e);
    ILA_NOT_NULL(expr_op_ptr);
    if(expr_op_ptr->op_name() == "ITE") {
      ExprPtr ctrue  = ExprFuse::And( cond, expr_op_ptr->arg(0) ); // the writes in the true-branch conforms to these conditions
      ExprPtr cfalse = ExprFuse::And( cond, ExprFuse::Not( expr_op_ptr->arg(0) )  );  // the writes in the false-branch conforms to these conditions

      mem_write_entry_list_t writes = writesStack.back();
      writesStack.push_back(writes); // make a copy of the top the stack and push it 
      VisitMemNodes(expr_op_ptr->arg(1), ctrue, writesStack);
      writesStack.pop_back();
      writesStack.push_back(writes); // recover the top of the stack to be the copy we have
      VisitMemNodes(expr_op_ptr->arg(2), cfalse, writesStack);
      writesStack.pop_back();
    }
    else {
      // ILA_ASSERT ( expr_op_ptr->op_name()== "STORE" )
      mem_write_entry_t mw = { memop->arg(1), memop->arg(2) };
      mem_write_entry_list_t & writes = writesStack.back();
      writes.push_back(mw);
      const nptr_t& mem(memop->arg(0));
      VisitMemNodes(mem.get(), cond, writesStack);
    }
  }
} // VerilogGenerator::VisitMemNodes

void VerilogGenerator::ExportFuncDefs() {
  // we don't have the option of verilog function here, becase we don't think this useful for verification
  if(cfg_.funcOpt == VlgGenConfig::funcOption::External)
    return; // if they are external we don't care how they will be implemented
  for (auto && func_ptr : func_ptr_set) {
    // because we don't add 0-arg func here, there is no need to worry about it
    auto func_name = func_ptr->name().str();
    vlg_stmt_t funcModDef = "module fun_" + func_name + " (\n";
    for( size_t argIdx = 0; argIdx < func_ptr->arg_num() ; ++ argIdx) {
      auto arg_sort_ptr = func_ptr->arg(argIdx);
      funcModDef += "    input " + WidthToRange( arg_sort_ptr->is_bool() ? 1 : arg_sort_ptr->bit_width() ) + " arg" + toStr(argIdx) + ",\n";
    }
    funcModDef += "    output " + WidthToRange(func_ptr->out()->is_bool() ? 1 : func_ptr->out()->bit_width() ) + " result\n";
    funcModDef += ");\n";
    funcModDef += "//TODO: Add the specific function HERE.\n";
    funcModDef += "endmodule\n";
    preheader += funcModDef;
  }
}

void VerilogGenerator::ExportCondWrites(const ExprPtr &mem_var, 
    const mem_write_list_t & writeList) 
{
    // count the maximum ports needed, that is for a single condition what's max size of mem_write_entry_list_t
    auto name = mem_var->name().str();
    auto addr_width = mem_var->sort()->addr_width;
    auto data_width = mem_var->sort()->data_width;

    unsigned max_port_no = 0;
    for (const auto & mw : writeList)
        if(max_port_no < mw.writes.size())
            max_port_no = mw.writes.size();
    for (unsigned portIdx = 0; portIdx < max_port_no; ++portIdx)
    {
        add_wire(name + "_addr" + toStr(portIdx),addr_width);
        add_wire(name + "_data" + toStr(portIdx),data_width);
        add_wire(name + "_wen"  + toStr(portIdx),1);
        if(cfg_.ExternalMem) {
            mem_o.push_back( vlg_sig_t(name + "_addr" + toStr(portIdx),addr_width) );
            mem_o.push_back( vlg_sig_t(name + "_data" + toStr(portIdx),data_width) );
            mem_o.push_back( vlg_sig_t(name + "_wen"  + toStr(portIdx),1) );
        }
    }
    std::vector<vlg_stmt_t> addrStmt(max_port_no,"0");
    std::vector<vlg_stmt_t> dataStmt(max_port_no,"'dx");
    std::vector<vlg_stmt_t> enabStmt(max_port_no,"1'b0"); 
    // Note the reverse here!
    for(auto mw_pos = writeList.rbegin() ; mw_pos != writeList.rend() ; ++mw_pos) {
      const auto & mw = *mw_pos;
      ParseNonMemUpdateExpr (w.cond);
      vlg_name_t cond = getVlgFromExpr (w.cond);
      int portIdx = 0;
      for (const auto &wr : mw.writes)
      {
        ParseNonMemUpdateExpr(wr.addr); vlg_name_t addr = getVlgFromExpr(wr.addr);
        ParseNonMemUpdateExpr(wr.data); vlg_name_t data = getVlgFromExpr(wr.data);
        addrStmt[portIdx] = cond + " ? (" + addr + ") : (" + addrStmt[portIdx] + ")";
        dataStmt[portIdx] = cond + " ? (" + data + ") : (" + dataStmt[portIdx] + ")";
        enabStmt[portIdx] = cond + " ? ( 1'b1 ) : ("       + enabStmt[portIdx] + ")";

        portIdx ++;
      } 
    } // accumulate the final expression, if it is external, then no need to anything here


    for (unsigned portIdx = 0; portIdx < max_port_no; ++portIdx)
    {
      // add statements
      vlg_name_t addrWireName = name + "_addr" + toStr(portIdx);
      vlg_name_t dataWireName = name + "_data" + toStr(portIdx);
      vlg_name_t enabWireName = name + "_wen"  + toStr(portIdx);
      add_assign_stmt( addrWireName, addrStmt[portIdx] );
      add_assign_stmt( dataWireName, dataStmt[portIdx] );
      add_assign_stmt( enabWireName, enabStmt[portIdx] );
      // add memory updates in the always block
      if(cfg_.ExternalMem) {
        // DO NOTHING
      }
      else {
        vlg_stmt_t assignment = name + " [ " + addrWireName + " ] " + "<= "  + dataWireName;
        vlg_stmt_t condition  = enabWireName;
        add_ite_stmt(condition, assignment, ""); // no else statement
      }
    }
} // VerilogGenerator::ExportCondWrites

// This function is used to parse a expr used as memvar's update
// will first collect the writes & conditions
// and then translate to verilog, the same idiom could be used to handle LOAD(STORE/ITE/MEMC)
void VerilogGenerator::ParseMemUpdateNode( const ExprPtr & e , const std::string & mem_var_name) { 
  ILA_ASSERT(CheckMemUpdateNode(e, mem_var_name)) << "Unsupported Expr structure";

  // no we prepare to start to traverse // build initial condition for that
  ExprPtr cond = ExprFuse::BoolConst(true);

  mem_write_entry_list_stack_t writesStack;
  mem_write_entry_list_t empty_write_entry_list;
  writesStack.push_back( empty_write_entry_list );

  for (const auto &w: current_writes)
    past_writes.push_back(w); // have a container to hold them so will not be garbarge collected before used

  current_writes.clear();
  VisitMemNodes(next, cond, writesStack);
  
  // Commented the line below, becasuse this function is not intended to really does the write 
  // ExportCondWrites(name,addr_width,data_width,current_writes); 
  // 
}

//--------------------------------------------------------------------------
void VerilogGenerator::ExportIla( const InstrLvlAbsPtr & ila_ptr_ )
{
  ILA_ASSERT(false) <<"NOT implemented yet.";
}



// here we will add all updates, those not touched will be update to itself
// add inputs / states / functions
// do remember to export its parents' state (hierarchically collect its parents)
// try to convert inits, if not add to assumptions
// add updates
// add guard of VALID signal to "else if"
// make sure to generate decode/valid signal output
// internal counter
void VerilogGenerator::ExportTopLevelInstr( const InstrPtr & instr_ptr_ )
{
  ILA_WARN( instr_ptr_->host()->parent() ) 
    << "This ExportTopLevelInstr does not put flatten states and instructions in child-ILA, please be aware.";
  ILA_WARN( instr_ptr_->host()->init_num() != 0 )
    << "For exporting a single instruction, the initial conditions are not exported, please be aware.";
  auto ila_ptr_ = instr_ptr_()->host();

  if (moduleName == "" )
    moduleName = ila_ptr_->name.str() + "__DOT__" + instr_ptr_->name.str();

  // add valid signal
  auto valid_ptr = ila_ptr_->valid();
  ParseNonMemUpdateExpr(valid_ptr);
  vlg_name_t valid_sig_name = getVlgFromExpr(valid_ptr);
  if (validName == "")
    validName = "__ILA_" + ila_ptr_->name().str() + "_valid__";
  add_wire  ( validName, 1 );
  add_output( validName, 1 );
  add_assign_stmt( validName, valid_sig_name );
  // decode conditions
  auto decode_ptr = instr_ptr_->decode();
  ParseNonMemUpdateExpr(decode_ptr);
  vlg_name_t decode_sig_name = getVlgFromExpr(decode_ptr);
  auto decodeName = "__ILA_" + ila_ptr_->name().str() + "_decode_of_" + ( instr_ptr_->name().str() ) + "__";
  decodeNames.push_back(decodeName);
  add_wire  ( decodeName, 1 );
  add_output( decodeName, 1 );
  add_assign_stmt( decodeName, decode_sig_name );

  // clk, rst
  add_wire(clkName, 1); add_input(clkName, 1);
  add_wire(rstName, 1); add_input(rstName, 1);

  addInternalCounter( decodeName ); // maybe no need (width = 8)

  // Inputs
  for (size_t idx = 0; idx != ila_ptr_->input_num(); ++idx)
    insertInput(ila_ptr_->input(idx));
  // States
  for (size_t idx = 0; idx != ila_ptr_->state_num(); ++idx)
    insertState(ila_ptr_->state(idx));
  // Func Defs
  ExportFuncDefs();

  // add updates
  for (size_t idx = 0; idx != ila_ptr_->state_num(); ++idx) { // could be merged with the loop above
    auto var = ila_ptr_->state(idx);
    auto update = instr_ptr_->update(var);
    if (!update)  update = var; // if not updated, make it to self
    if ( var->is_mem() ) {
      ParseMemUpdateNode(update);
      ExportCondWrites(var, current_writes);
    } else { // bv/bool
      ParseNonMemUpdateExpr(update);
      vlg_name_t result = getVlgFromExpr(update);
      add_always_stmt( var->name.str() + " <= " + result + " ;" );
    } // else
  } // for (size_t idx = 0;  ...
} // VerilogGenerator::ExportTopLevelInstr

void VerilogGenerator::DumpToFile(ostream & fout) const {
  if(preheader != "") {
    fout << "/* PREHEADER */\n";
    fout << preheader<<"\n";
    fout << "/* END OF PREHEADER */\n";
  }
  // no need to worry about mem_i/o , already in i/o

  fout << "module "<< moduleName<< "(\n";

  std::string separator; // input will not be empty of course, output won't either
  for(auto const &sig_pair : inputs)
    fout << sig_pair.first <<",\n"; // sig_pair.first is the name
  for(auto const &sig_pair : outputs) {
    fout << separator<< sig_pair.first ;  separator = ",\n"; }

  for(auto const &sig_pair : inputs)
    fout << "input "<<std::setw(10)<<WidthToRange(sig_pair.second)<<" "<<(sig_pair.first) << ";\n";
  for(auto const &sig_pair : outputs)
    fout << "output "<<std::setw(10)<<WidthToRange(sig_pair.second)<<" "<<(sig_pair.first) << ";\n";
  for(auto const &sig_pair : regs)
    fout << "reg " <<std::setw(10)<<WidthToRange(sig_pair.second)<<" "<<(sig_pair.first) << ";\n";
  for(auto const &sig_pair : wires)
    fout << "wire " <<std::setw(10)<<WidthToRange(sig_pair.second)<<" "<<(sig_pair.first) << ";\n";

  // now we deal w. the internal mems
  for(auto const & mem : mem_i) 
    fout << "reg "<<std::setw(10)<<WidthToRange( std::get<2>(mem) )<<" "<<( std::get<0>(mem) )<< WidthToRange(std::pow(2, std::get<1>(mem)))<<";\n";
  // we require that the statements must have ";" ending itself
  for(auto const &stmt : statements)
    fout << stmt <<"\n";

  fout << "always @(posedge "<< clkName<<") begin\n";
  fout << "   if("<< rstName<<") begin\n";
  // init_stmts go in rst cycle
  for(auto const &stmt : init_stmts) 
    fout << "       "<<stmt<<";\n";
  // 
  fout << "   end\n";
  fout << "   else if(" << validName << ") begin\n";
  for(auto const &stmt : always_stmts) 
    fout << "       "<<stmt<<";\n";
  // we don't require ite statement has that
  for (auto const &stmt : ite_stmts) {
    fout << "       "<<"if (" << std::get<0>(stmt) <<") begin\n";
    fout << "       "<<"    "<< std::get<1>(stmt)<<" ;\n";
    fout << "       "<<"end\n";
    if(std::get<2>(stmt) != "") {
      fout << "       "<<"else begin\n            "<<std::get<2>(stmt)<<" ;\n        end\n";
    }
  }

  fout << "   end\n";
  fout << "end\n";

  fout << "endmodule\n";
}


// parse a dummy ILA where we have
// I, and all child (as insts)
// multi-inst case, which to trigger? and their priority?
//# error the above question is unsolved

// this function could be used to export Instr w. (some/all) their childs, but there should be an external 
// step that assemble these part together
// as Verilog Generator, it does not do this internally
//void VerilogGenerator::ExportIla( const InstrPtr & instr_ptr_ )
//{
  // add inputs / states / functions
  // do remember to export its parents' state (hierarchically collect its parents)
  
  // try to convert inits, if not add to assumptions

  // add updates

  // add guard of valid signal to "else if"

  // make sure to generate decode/valid signal output
//}


}; // namespace ila