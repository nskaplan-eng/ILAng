; ModuleID = '/home/byhuang/workspace/ILA/apps/fw_verif/demo-system/fwsrc/main.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.pthread_mutex_t = type { i32, i32, %struct.pthread_mutexattr_t }
%struct.pthread_mutexattr_t = type { i32, i32, i32, i32 }
%struct.MB_REG_t = type { %union.STS_t, %union.R_CMD_t, %union.R_DAT0_t, %union.R_DAT1_t, %union.R_SIZE_t, %union.S_CMD_t, %union.S_DAT0_t, %union.S_DAT1_t, %union.S_SIZE_t, %union.ACK_t }
%union.STS_t = type { i32 }
%union.R_CMD_t = type { i32 }
%union.R_DAT0_t = type { i32 }
%union.R_DAT1_t = type { i32 }
%union.R_SIZE_t = type { i32 }
%union.S_CMD_t = type { i32 }
%union.S_DAT0_t = type { i32 }
%union.S_DAT1_t = type { i32 }
%union.S_SIZE_t = type { i32 }
%union.ACK_t = type { i32 }

@mstCpl = global i8 0, align 1
@slvCpl = global i8 0, align 1
@intCpl = global i8 0, align 1
@int_lock = common global %struct.pthread_mutex_t zeroinitializer, align 4
@fab_lock = common global %struct.pthread_mutex_t zeroinitializer, align 4
@reg_msg_mst2slv_db = external global i32, align 4
@reg_msg_mst2slv_dbm = external global i32, align 4
@reg_msg_slv2mst_db = external global i32, align 4
@reg_msg_slv2mst_dbm = external global i32, align 4
@hw_reg_MB = external global %struct.MB_REG_t, align 4
@reg_slv_int = common global i32 0, align 4
@gSlvFlag = external global [0 x i32], align 4
@gMbCtx = external global [0 x i32], align 4
@mst_sram = common global [32 x i8] zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define i8* @entryMst(i8* %in) #0 {
entry:
  %in.addr = alloca i8*, align 8
  store i8* %in, i8** %in.addr, align 8
  call void (...) @mainMst()
  store i8 1, i8* @mstCpl, align 1
  %0 = load i8*, i8** %in.addr, align 8
  ret i8* %0
}

declare void @mainMst(...) #1

; Function Attrs: nounwind uwtable
define i8* @entrySlv(i8* %in) #0 {
entry:
  %in.addr = alloca i8*, align 8
  store i8* %in, i8** %in.addr, align 8
  call void (...) @mainSlv()
  store i8 1, i8* @slvCpl, align 1
  %0 = load i8*, i8** %in.addr, align 8
  ret i8* %0
}

declare void @mainSlv(...) #1

; Function Attrs: nounwind uwtable
define i8* @entryHdl(i8* %in) #0 {
entry:
  %in.addr = alloca i8*, align 8
  store i8* %in, i8** %in.addr, align 8
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i8, i8* @mstCpl, align 1
  %tobool = icmp ne i8 %0, 0
  br i1 %tobool, label %lor.rhs, label %lor.end

lor.rhs:                                          ; preds = %while.cond
  %1 = load i8, i8* @slvCpl, align 1
  %tobool1 = icmp ne i8 %1, 0
  %lnot = xor i1 %tobool1, true
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %while.cond
  %2 = phi i1 [ true, %while.cond ], [ %lnot, %lor.rhs ]
  br i1 %2, label %while.body, label %while.end

while.body:                                       ; preds = %lor.end
  %call = call i32 @pthread_mutex_lock(%struct.pthread_mutex_t* @int_lock)
  call void (...) @intHdl()
  %call2 = call i32 @pthread_mutex_unlock(%struct.pthread_mutex_t* @int_lock)
  br label %while.cond

while.end:                                        ; preds = %lor.end
  store i8 1, i8* @intCpl, align 1
  %3 = load i8*, i8** %in.addr, align 8
  ret i8* %3
}

declare i32 @pthread_mutex_lock(%struct.pthread_mutex_t*) #1

declare void @intHdl(...) #1

declare i32 @pthread_mutex_unlock(%struct.pthread_mutex_t*) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %tidMst = alloca i32, align 4
  %tidSlv = alloca i32, align 4
  %tidHdl = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @initHW()
  store i8 0, i8* @intCpl, align 1
  store i8 0, i8* @slvCpl, align 1
  store i8 0, i8* @mstCpl, align 1
  %call = call i32 @pthread_mutex_init(%struct.pthread_mutex_t* @int_lock, %struct.pthread_mutexattr_t* null)
  %call1 = call i32 @pthread_mutex_init(%struct.pthread_mutex_t* @fab_lock, %struct.pthread_mutexattr_t* null)
  %call2 = call i32 @pthread_create(i32* %tidMst, i32* null, i8* (i8*)* @entryMst, i8* null)
  %call3 = call i32 @pthread_create(i32* %tidSlv, i32* null, i8* (i8*)* @entrySlv, i8* null)
  %call4 = call i32 @pthread_create(i32* %tidHdl, i32* null, i8* (i8*)* @entryHdl, i8* null)
  %0 = load i32, i32* %tidMst, align 4
  %call5 = call i32 @pthread_join(i32 %0, i8** null)
  %1 = load i32, i32* %tidSlv, align 4
  %call6 = call i32 @pthread_join(i32 %1, i8** null)
  %2 = load i32, i32* %tidHdl, align 4
  %call7 = call i32 @pthread_join(i32 %2, i8** null)
  %call8 = call i32 @pthread_mutex_destroy(%struct.pthread_mutex_t* @int_lock)
  %call9 = call i32 @pthread_mutex_destroy(%struct.pthread_mutex_t* @fab_lock)
  ret i32 0
}

declare i32 @pthread_mutex_init(%struct.pthread_mutex_t*, %struct.pthread_mutexattr_t*) #1

declare i32 @pthread_create(i32*, i32*, i8* (i8*)*, i8*) #1

declare i32 @pthread_join(i32, i8**) #1

declare i32 @pthread_mutex_destroy(%struct.pthread_mutex_t*) #1

; Function Attrs: nounwind uwtable
define void @initHW() #0 {
entry:
  store i32 0, i32* @reg_msg_mst2slv_db, align 4
  store i32 0, i32* @reg_msg_mst2slv_dbm, align 4
  store i32 0, i32* @reg_msg_slv2mst_db, align 4
  store i32 0, i32* @reg_msg_slv2mst_dbm, align 4
  store i32 0, i32* getelementptr inbounds (%struct.MB_REG_t, %struct.MB_REG_t* @hw_reg_MB, i32 0, i32 0, i32 0), align 4
  store i32 0, i32* getelementptr inbounds (%struct.MB_REG_t, %struct.MB_REG_t* @hw_reg_MB, i32 0, i32 1, i32 0), align 4
  store i32 0, i32* getelementptr inbounds (%struct.MB_REG_t, %struct.MB_REG_t* @hw_reg_MB, i32 0, i32 5, i32 0), align 4
  store i32 0, i32* @reg_slv_int, align 4
  store i32 0, i32* getelementptr inbounds ([0 x i32], [0 x i32]* @gSlvFlag, i64 0, i64 0), align 4
  store i32 0, i32* getelementptr inbounds ([0 x i32], [0 x i32]* @gMbCtx, i64 0, i64 0), align 4
  store i32 0, i32* getelementptr inbounds ([0 x i32], [0 x i32]* @gMbCtx, i64 0, i64 4), align 4
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0 (tags/RELEASE_381/final)"}
