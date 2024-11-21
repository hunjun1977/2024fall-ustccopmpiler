; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/6-array.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = alloca i32
  store i32 0, i32* %op1
  %op2 = icmp sge i32 0, 0
  br i1 %op2, label %label_end1, label %label_error1
label_error1:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label_end1
label_end1:                                                ; preds = %label_entry, %label_error1
  %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  store i32 11, i32* %op3
  %op4 = icmp sge i32 4, 0
  br i1 %op4, label %label_end2, label %label_error2
label_error2:                                                ; preds = %label_end1
  call void @neg_idx_except()
  br label %label_end2
label_end2:                                                ; preds = %label_end1, %label_error2
  %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  store i32 22, i32* %op5
  %op6 = icmp sge i32 9, 0
  br i1 %op6, label %label_end3, label %label_error3
label_error3:                                                ; preds = %label_end2
  call void @neg_idx_except()
  br label %label_end3
label_end3:                                                ; preds = %label_end2, %label_error3
  %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  store i32 33, i32* %op7
  %op8 = icmp sge i32 0, 0
  br i1 %op8, label %label_end4, label %label_error4
label_error4:                                                ; preds = %label_end3
  call void @neg_idx_except()
  br label %label_end4
label_end4:                                                ; preds = %label_end3, %label_error4
  %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op10 = load i32, i32* %op9
  call void @output(i32 %op10)
  %op11 = icmp sge i32 4, 0
  br i1 %op11, label %label_end5, label %label_error5
label_error5:                                                ; preds = %label_end4
  call void @neg_idx_except()
  br label %label_end5
label_end5:                                                ; preds = %label_end4, %label_error5
  %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  %op13 = load i32, i32* %op12
  call void @output(i32 %op13)
  %op14 = icmp sge i32 9, 0
  br i1 %op14, label %label_end6, label %label_error6
label_error6:                                                ; preds = %label_end5
  call void @neg_idx_except()
  br label %label_end6
label_end6:                                                ; preds = %label_end5, %label_error6
  %op15 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  %op16 = load i32, i32* %op15
  call void @output(i32 %op16)
  ret i32 0
}
