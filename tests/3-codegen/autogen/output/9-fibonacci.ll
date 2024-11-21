; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/9-fibonacci.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @fibonacci(i32 %arg0) {
label_entry:
  %op1 = alloca i32
  store i32 %arg0, i32* %op1
  %op2 = load i32, i32* %op1
  %op3 = icmp eq i32 %op2, 0
  br i1 %op3, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  ret i32 0
label_falseBB1:                                                ; preds = %label_entry
  %op4 = load i32, i32* %op1
  %op5 = icmp eq i32 %op4, 1
  br i1 %op5, label %label_turnBB2, label %label_falseBB2
label_nextBB1:                                                ; preds = %label_nextBB2
  ret i32 0
label_turnBB2:                                                ; preds = %label_falseBB1
  ret i32 1
label_falseBB2:                                                ; preds = %label_falseBB1
  %op6 = load i32, i32* %op1
  %op7 = sub i32 %op6, 1
  %op8 = call i32 @fibonacci(i32 %op7)
  %op9 = load i32, i32* %op1
  %op10 = sub i32 %op9, 2
  %op11 = call i32 @fibonacci(i32 %op10)
  %op12 = add i32 %op8, %op11
  ret i32 %op12
label_nextBB2:
  br label %label_nextBB1
}
define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  store i32 10, i32* %op0
  store i32 0, i32* %op1
  br label %label2
label2:                                                ; preds = %label_entry, %label6
  %op3 = load i32, i32* %op1
  %op4 = load i32, i32* %op0
  %op5 = icmp slt i32 %op3, %op4
  br i1 %op5, label %label6, label %label11
label6:                                                ; preds = %label2
  %op7 = load i32, i32* %op1
  %op8 = call i32 @fibonacci(i32 %op7)
  call void @output(i32 %op8)
  %op9 = load i32, i32* %op1
  %op10 = add i32 %op9, 1
  store i32 %op10, i32* %op1
  br label %label2
label11:                                                ; preds = %label2
  ret i32 0
}
