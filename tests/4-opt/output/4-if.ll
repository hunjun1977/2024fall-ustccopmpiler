; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/4-if.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = icmp sgt i32 11, 22
  br i1 %op0, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  %op1 = icmp sgt i32 11, 33
  br i1 %op1, label %label_turnBB3, label %label_falseBB3
label_falseBB1:                                                ; preds = %label_entry
  %op2 = icmp slt i32 33, 22
  br i1 %op2, label %label_turnBB2, label %label_falseBB2
label_nextBB1:                                                ; preds = %label_nextBB2, %label_nextBB3
  ret i32 0
label_turnBB2:                                                ; preds = %label_falseBB1
  call void @output(i32 22)
  br label %label_nextBB2
label_falseBB2:                                                ; preds = %label_falseBB1
  call void @output(i32 33)
  br label %label_nextBB2
label_nextBB2:                                                ; preds = %label_falseBB2, %label_turnBB2
  br label %label_nextBB1
label_turnBB3:                                                ; preds = %label_turnBB1
  call void @output(i32 11)
  br label %label_nextBB3
label_falseBB3:                                                ; preds = %label_turnBB1
  call void @output(i32 33)
  br label %label_nextBB3
label_nextBB3:                                                ; preds = %label_falseBB3, %label_turnBB3
  br label %label_nextBB1
}
