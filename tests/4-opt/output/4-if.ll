; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/4-if.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 11, i32* %op0
  store i32 22, i32* %op1
  store i32 33, i32* %op2
  %op3 = load i32, i32* %op0
  %op4 = load i32, i32* %op1
  %op5 = icmp sgt i32 %op3, %op4
  br i1 %op5, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  %op6 = load i32, i32* %op0
  %op7 = load i32, i32* %op2
  %op8 = icmp sgt i32 %op6, %op7
  br i1 %op8, label %label_turnBB3, label %label_falseBB3
label_falseBB1:                                                ; preds = %label_entry
  %op9 = load i32, i32* %op2
  %op10 = load i32, i32* %op1
  %op11 = icmp slt i32 %op9, %op10
  br i1 %op11, label %label_turnBB2, label %label_falseBB2
label_nextBB1:                                                ; preds = %label_nextBB2, %label_nextBB3
  ret i32 0
label_turnBB2:                                                ; preds = %label_falseBB1
  %op12 = load i32, i32* %op1
  call void @output(i32 %op12)
  br label %label_nextBB2
label_falseBB2:                                                ; preds = %label_falseBB1
  %op13 = load i32, i32* %op2
  call void @output(i32 %op13)
  br label %label_nextBB2
label_nextBB2:                                                ; preds = %label_falseBB2, %label_turnBB2
  br label %label_nextBB1
label_turnBB3:                                                ; preds = %label_turnBB1
  %op14 = load i32, i32* %op0
  call void @output(i32 %op14)
  br label %label_nextBB3
label_falseBB3:                                                ; preds = %label_turnBB1
  %op15 = load i32, i32* %op2
  call void @output(i32 %op15)
  br label %label_nextBB3
label_nextBB3:                                                ; preds = %label_falseBB3, %label_turnBB3
  br label %label_nextBB1
}
