; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/mem2reg/mem2reg-2.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label1
label1:                                                ; preds = %label_entry, %label4
  %op9 = phi i32 [ 1, %label_entry ], [ %op6, %label4 ]
  %op3 = icmp slt i32 %op9, 999999999
  br i1 %op3, label %label4, label %label7
label4:                                                ; preds = %label1
  %op6 = add i32 %op9, 1
  br label %label1
label7:                                                ; preds = %label1
  ret i32 %op9
}
