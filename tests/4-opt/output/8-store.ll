; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/8-store.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @store(i32* %arg0, i32 %arg1, i32 %arg2) {
label_entry:
  %op3 = alloca i32
  %op4 = alloca i32
  store i32 %arg1, i32* %op3
  store i32 %arg2, i32* %op4
  %op5 = load i32, i32* %op3
  %op6 = icmp sge i32 %op5, 0
  br i1 %op6, label %label_end1, label %label_error1
label_error1:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label_end1
label_end1:                                                ; preds = %label_entry, %label_error1
  %op7 = getelementptr i32, i32* %arg0, i32 %op5
  %op8 = load i32, i32* %op4
  store i32 %op8, i32* %op7
  %op9 = load i32, i32* %op4
  ret i32 %op9
}
define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = alloca i32
  %op2 = alloca i32
  store i32 0, i32* %op1
  br label %label3
label3:                                                ; preds = %label_entry, %label6
  %op4 = load i32, i32* %op1
  %op5 = icmp slt i32 %op4, 10
  br i1 %op5, label %label6, label %label14
label6:                                                ; preds = %label3
  %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op8 = load i32, i32* %op1
  %op9 = load i32, i32* %op1
  %op10 = mul i32 %op9, 2
  %op11 = call i32 @store(i32* %op7, i32 %op8, i32 %op10)
  %op12 = load i32, i32* %op1
  %op13 = add i32 %op12, 1
  store i32 %op13, i32* %op1
  br label %label3
label14:                                                ; preds = %label3
  store i32 0, i32* %op2
  store i32 0, i32* %op1
  br label %label15
label15:                                                ; preds = %label14, %label_end2
  %op16 = load i32, i32* %op1
  %op17 = icmp slt i32 %op16, 10
  br i1 %op17, label %label18, label %label22
label18:                                                ; preds = %label15
  %op19 = load i32, i32* %op2
  %op20 = load i32, i32* %op1
  %op21 = icmp sge i32 %op20, 0
  br i1 %op21, label %label_end2, label %label_error2
label22:                                                ; preds = %label15
  %op23 = load i32, i32* %op2
  call void @output(i32 %op23)
  ret i32 0
label_error2:                                                ; preds = %label18
  call void @neg_idx_except()
  br label %label_end2
label_end2:                                                ; preds = %label18, %label_error2
  %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op20
  %op25 = load i32, i32* %op24
  %op26 = add i32 %op19, %op25
  store i32 %op26, i32* %op2
  %op27 = load i32, i32* %op1
  %op28 = add i32 %op27, 1
  store i32 %op28, i32* %op1
  br label %label15
}
