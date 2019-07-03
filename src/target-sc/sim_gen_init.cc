#include <ilang/target-sc/ila_sim.h>

#include <ilang/ila/ast_fuse.h>
#include <ilang/util/log.h>

namespace ilang {

void IlaSim::create_init(const InstrLvlAbsPtr& ila) {
  stringstream init_function;
  string indent = "";
  string init_func_name;
  init_func_name = "init_" + ila->name().str();
  
  auto valid_expr = ila->valid(); 
  init_decl(init_function, indent, init_func_name);

  auto DfsKernel = [this, &init_function, &indent](const ExprPtr& e) {
    dfs_kernel(init_function, indent, e);
  };
  valid_expr->DepthFirstVisit(DfsKernel);
  init_check_valid(init_function, indent, valid_expr, ila);

  for (int i = 0; i < ila->init_num(); i++) {
    auto init_expr = ila->init(i);
    if (GetUidExpr(init_expr) != AST_UID_EXPR::OP) {
      ILA_ERROR << "init condition must be a comparison";
    }
    if (GetUidExprOp(init_expr) != AST_UID_EXPR_OP::EQ) {
      ILA_ERROR << "init_condition must be an EQ comparison";
    }
    auto arg0 = init_expr->arg(0);
    auto arg1 = init_expr->arg(1);
    if (GetUidExpr(arg0) != AST_UID_EXPR::VAR) {
      ILA_ERROR << "init_condition must constrain states";
    }
    arg1->DepthFirstVisit(DfsKernel);
    string arg0_str = get_arg_str(arg0);
    string arg1_str = get_arg_str(arg1);
    init_function << indent << arg0_str << " = " << arg1_str << ";" << endl;
  }
  init_return(init_function, indent);

  decrease_indent(indent);
  init_function << indent << "};" << endl;
  init_export(init_function, init_func_name);
  init_mk_file(init_func_name);
  return;
}

void IlaSim::init_decl(stringstream& init_function, string& indent,
                         string& init_func_name) {
  if (!qemu_device_)
    init_function << "#include \"systemc.h\"" << endl;
  init_function << "#include \"" << model_ptr_->name() << ".h\"" << endl;

  init_function << indent << "void " << model_ptr_->name()
                 << "::" << init_func_name << "() {" << endl;
  increase_indent(indent);
  searched_id_set_.clear();
  header_ << header_indent_ << "void " << init_func_name << "();" << endl;
}

void IlaSim::init_check_valid(stringstream& init_function, string& indent,
                                const ExprPtr& valid_expr,
                                const InstrLvlAbsPtr& ila) {
  string valid_str;
  auto valid_expr_uid = GetUidExpr(valid_expr);
  if (valid_expr_uid == AST_UID_EXPR::VAR)
    valid_str =
        ila->name().str() + "_" + valid_expr->name().str();
  else if (valid_expr_uid == AST_UID_EXPR::OP)
    valid_str = "c_" + to_string(valid_expr->name().id());
  else {
    auto valid_expr_const = dynamic_pointer_cast<ExprConst>(valid_expr);
    valid_str = to_string(valid_expr_const->val_bool()->val());
  }
  init_function << indent << "if (!" << valid_str << ") {" << endl;
  init_function << indent << "  return;" << endl;
  init_function << indent << "}" << endl;
}

void IlaSim::init_return(stringstream& init_function, string& indent) {
  init_function << indent << "return " << ";" << endl;
}

void IlaSim::init_export(stringstream& init_function,
                           string& init_func_name) {
  ofstream outFile;
  stringstream out_file;
  outFile.open(export_dir_ + init_func_name + ".cc");
  outFile << init_function.rdbuf();
  outFile.close();
}

void IlaSim::init_mk_file(string& init_func_name) {
  if (qemu_device_)
    mk_script_ << "g++ -I./ -c -o " << init_func_name << ".o " << init_func_name << ".cc" << endl;
  else 
    mk_script_ << "g++ -I. -I " << systemc_path_ << "/include/ "
               << "-L. -L " << systemc_path_ << "/lib-linux64/ "
               << "-Wl,-rpath=" << systemc_path_ << "/lib-linux64/ "
               << "-c -o " << init_func_name << ".o " << init_func_name
               << ".cc "
               << "-lsystemc" << endl;
  obj_list_ << init_func_name << ".o ";
}

} // namespace ilang
