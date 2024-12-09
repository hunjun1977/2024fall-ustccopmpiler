; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/8-store.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @store(i32* %arg0, i32 %arg1, i32 %arg2) {
label_entry:
  %op3 = icmp sge i32 %arg1, 0
  br i1 %op3, label %label_end1, label %label_error1
label_error1:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label_end1
label_end1:                                                ; preds = %label_entry, %label_error1
  %op4 = getelementptr i32, i32* %arg0, i32 %arg1
  store i32 %arg2, i32* %op4
  ret i32 %arg2
}
define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  br label %label1
label1:                                                ; preds = %label_entry, %label4
  %op2 = phi i32 [ 0, %label_entry ], [ %op8, %label4 ]
  %op3 = icmp slt i32 %op2, 10
  br i1 %op3, label %label4, label %label9
label4:                                                ; preds = %label1
  %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op6 = mul i32 %op2, 2
  %op7 = call i32 @store(i32* %op5, i32 %op2, i32 %op6)
  %op8 = add i32 %op2, 1
  br label %label1
label9:                                                ; preds = %label1
  br label %label10
label10:                                                ; preds = %label9, %label_end2
  %op11 = phi i32 [ 0, %label9 ], [ %op19, %label_end2 ]
  %op12 = phi i32 [ 0, %label9 ], [ %op20, %label_end2 ]
  %op13 = icmp slt i32 %op12, 10
  br i1 %op13, label %label14, label %label16
label14:                                                ; preds = %label10
  %op15 = icmp sge i32 %op12, 0
  br i1 %op15, label %label_end2, label %label_error2
label16:                                                ; preds = %label10
  call void @output(i32 %op11)
  ret i32 0
label_error2:                                                ; preds = %label14
  call void @neg_idx_except()
  br label %label_end2
label_end2:                                                ; preds = %label14, %label_error2
  %op17 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op12
  %op18 = load i32, i32* %op17
  %op19 = add i32 %op11, %op18
  %op20 = add i32 %op12, 1
  br label %label10
}
