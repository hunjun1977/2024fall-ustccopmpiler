; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/9-fibonacci.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @fibonacci(i32 %arg0) {
label_entry:
  %op1 = icmp eq i32 %arg0, 0
  br i1 %op1, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  ret i32 0
label_falseBB1:                                                ; preds = %label_entry
  %op2 = icmp eq i32 %arg0, 1
  br i1 %op2, label %label_turnBB2, label %label_falseBB2
label_turnBB2:                                                ; preds = %label_falseBB1
  ret i32 1
label_falseBB2:                                                ; preds = %label_falseBB1
  %op3 = sub i32 %arg0, 1
  %op4 = call i32 @fibonacci(i32 %op3)
  %op5 = sub i32 %arg0, 2
  %op6 = call i32 @fibonacci(i32 %op5)
  %op7 = add i32 %op4, %op6
  ret i32 %op7
}
define i32 @main() {
label_entry:
  br label %label0
label0:                                                ; preds = %label_entry, %label3
  %op1 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
  %op2 = icmp slt i32 %op1, 10
  br i1 %op2, label %label3, label %label6
label3:                                                ; preds = %label0
  %op4 = call i32 @fibonacci(i32 %op1)
  call void @output(i32 %op4)
  %op5 = add i32 %op1, 1
  br label %label0
label6:                                                ; preds = %label0
  ret i32 0
}
