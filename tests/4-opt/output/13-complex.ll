; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/13-complex.cminus"

@n = global i32 zeroinitializer
@m = global i32 zeroinitializer
@w = global [5 x i32] zeroinitializer
@v = global [5 x i32] zeroinitializer
@dp = global [66 x i32] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @max(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = icmp sgt i32 %arg0, %arg1
  br i1 %op2, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  ret i32 %arg0
label_falseBB1:                                                ; preds = %label_entry
  ret i32 %arg1
}
define i32 @knapsack(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = icmp sle i32 %arg1, 0
  br i1 %op2, label %label_turnBB2, label %label_nextBB2
label_turnBB2:                                                ; preds = %label_entry
  ret i32 0
label_nextBB2:                                                ; preds = %label_entry
  %op3 = icmp eq i32 %arg0, 0
  br i1 %op3, label %label_turnBB3, label %label_nextBB3
label_turnBB3:                                                ; preds = %label_nextBB2
  ret i32 0
label_nextBB3:                                                ; preds = %label_nextBB2
  %op4 = mul i32 %arg0, 11
  %op5 = add i32 %op4, %arg1
  %op6 = icmp sge i32 %op5, 0
  br i1 %op6, label %label_end1, label %label_error1
label_error1:                                                ; preds = %label_nextBB3
  call void @neg_idx_except()
  br label %label_end1
label_end1:                                                ; preds = %label_nextBB3, %label_error1
  %op7 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op5
  %op8 = load i32, i32* %op7
  %op9 = icmp sge i32 %op8, 0
  br i1 %op9, label %label_turnBB4, label %label_nextBB4
label_turnBB4:                                                ; preds = %label_end1
  %op10 = mul i32 %arg0, 11
  %op11 = add i32 %op10, %arg1
  %op12 = icmp sge i32 %op11, 0
  br i1 %op12, label %label_end2, label %label_error2
label_nextBB4:                                                ; preds = %label_end1
  %op13 = sub i32 %arg0, 1
  %op14 = icmp sge i32 %op13, 0
  br i1 %op14, label %label_end3, label %label_error3
label_error2:                                                ; preds = %label_turnBB4
  call void @neg_idx_except()
  br label %label_end2
label_end2:                                                ; preds = %label_turnBB4, %label_error2
  %op15 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op11
  %op16 = load i32, i32* %op15
  ret i32 %op16
label_error3:                                                ; preds = %label_nextBB4
  call void @neg_idx_except()
  br label %label_end3
label_end3:                                                ; preds = %label_nextBB4, %label_error3
  %op17 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op13
  %op18 = load i32, i32* %op17
  %op19 = icmp slt i32 %arg1, %op18
  br i1 %op19, label %label_turnBB5, label %label_falseBB5
label_turnBB5:                                                ; preds = %label_end3
  %op20 = sub i32 %arg0, 1
  %op21 = call i32 @knapsack(i32 %op20, i32 %arg1)
  br label %label_nextBB5
label_falseBB5:                                                ; preds = %label_end3
  %op22 = sub i32 %arg0, 1
  %op23 = call i32 @knapsack(i32 %op22, i32 %arg1)
  %op24 = sub i32 %arg0, 1
  %op25 = sub i32 %arg0, 1
  %op26 = icmp sge i32 %op25, 0
  br i1 %op26, label %label_end4, label %label_error4
label_nextBB5:                                                ; preds = %label_end5, %label_turnBB5
  %op27 = phi i32 [ %op21, %label_turnBB5 ], [ %op40, %label_end5 ]
  %op28 = mul i32 %arg0, 11
  %op29 = add i32 %op28, %arg1
  %op30 = icmp sge i32 %op29, 0
  br i1 %op30, label %label_end6, label %label_error6
label_error4:                                                ; preds = %label_falseBB5
  call void @neg_idx_except()
  br label %label_end4
label_end4:                                                ; preds = %label_falseBB5, %label_error4
  %op31 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op25
  %op32 = load i32, i32* %op31
  %op33 = sub i32 %arg1, %op32
  %op34 = call i32 @knapsack(i32 %op24, i32 %op33)
  %op35 = sub i32 %arg0, 1
  %op36 = icmp sge i32 %op35, 0
  br i1 %op36, label %label_end5, label %label_error5
label_error5:                                                ; preds = %label_end4
  call void @neg_idx_except()
  br label %label_end5
label_end5:                                                ; preds = %label_end4, %label_error5
  %op37 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op35
  %op38 = load i32, i32* %op37
  %op39 = add i32 %op34, %op38
  %op40 = call i32 @max(i32 %op23, i32 %op39)
  br label %label_nextBB5
label_error6:                                                ; preds = %label_nextBB5
  call void @neg_idx_except()
  br label %label_end6
label_end6:                                                ; preds = %label_nextBB5, %label_error6
  %op41 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op29
  store i32 %op27, i32* %op41
  ret i32 %op27
}
define i32 @main() {
label_entry:
  store i32 5, i32* @n
  store i32 10, i32* @m
  %op0 = icmp sge i32 0, 0
  br i1 %op0, label %label_end7, label %label_error7
label_error7:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label_end7
label_end7:                                                ; preds = %label_entry, %label_error7
  %op1 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
  store i32 2, i32* %op1
  %op2 = icmp sge i32 1, 0
  br i1 %op2, label %label_end8, label %label_error8
label_error8:                                                ; preds = %label_end7
  call void @neg_idx_except()
  br label %label_end8
label_end8:                                                ; preds = %label_end7, %label_error8
  %op3 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
  store i32 2, i32* %op3
  %op4 = icmp sge i32 2, 0
  br i1 %op4, label %label_end9, label %label_error9
label_error9:                                                ; preds = %label_end8
  call void @neg_idx_except()
  br label %label_end9
label_end9:                                                ; preds = %label_end8, %label_error9
  %op5 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
  store i32 6, i32* %op5
  %op6 = icmp sge i32 3, 0
  br i1 %op6, label %label_end10, label %label_error10
label_error10:                                                ; preds = %label_end9
  call void @neg_idx_except()
  br label %label_end10
label_end10:                                                ; preds = %label_end9, %label_error10
  %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
  store i32 5, i32* %op7
  %op8 = icmp sge i32 4, 0
  br i1 %op8, label %label_end11, label %label_error11
label_error11:                                                ; preds = %label_end10
  call void @neg_idx_except()
  br label %label_end11
label_end11:                                                ; preds = %label_end10, %label_error11
  %op9 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
  store i32 4, i32* %op9
  %op10 = icmp sge i32 0, 0
  br i1 %op10, label %label_end12, label %label_error12
label_error12:                                                ; preds = %label_end11
  call void @neg_idx_except()
  br label %label_end12
label_end12:                                                ; preds = %label_end11, %label_error12
  %op11 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
  store i32 6, i32* %op11
  %op12 = icmp sge i32 1, 0
  br i1 %op12, label %label_end13, label %label_error13
label_error13:                                                ; preds = %label_end12
  call void @neg_idx_except()
  br label %label_end13
label_end13:                                                ; preds = %label_end12, %label_error13
  %op13 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
  store i32 3, i32* %op13
  %op14 = icmp sge i32 2, 0
  br i1 %op14, label %label_end14, label %label_error14
label_error14:                                                ; preds = %label_end13
  call void @neg_idx_except()
  br label %label_end14
label_end14:                                                ; preds = %label_end13, %label_error14
  %op15 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
  store i32 5, i32* %op15
  %op16 = icmp sge i32 3, 0
  br i1 %op16, label %label_end15, label %label_error15
label_error15:                                                ; preds = %label_end14
  call void @neg_idx_except()
  br label %label_end15
label_end15:                                                ; preds = %label_end14, %label_error15
  %op17 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
  store i32 4, i32* %op17
  %op18 = icmp sge i32 4, 0
  br i1 %op18, label %label_end16, label %label_error16
label_error16:                                                ; preds = %label_end15
  call void @neg_idx_except()
  br label %label_end16
label_end16:                                                ; preds = %label_end15, %label_error16
  %op19 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
  store i32 6, i32* %op19
  br label %label20
label20:                                                ; preds = %label_end16, %label_end17
  %op21 = phi i32 [ 0, %label_end16 ], [ %op31, %label_end17 ]
  %op22 = icmp slt i32 %op21, 66
  br i1 %op22, label %label23, label %label25
label23:                                                ; preds = %label20
  %op24 = icmp sge i32 %op21, 0
  br i1 %op24, label %label_end17, label %label_error17
label25:                                                ; preds = %label20
  %op26 = load i32, i32* @n
  %op27 = load i32, i32* @m
  %op28 = call i32 @knapsack(i32 %op26, i32 %op27)
  call void @output(i32 %op28)
  ret i32 0
label_error17:                                                ; preds = %label23
  call void @neg_idx_except()
  br label %label_end17
label_end17:                                                ; preds = %label23, %label_error17
  %op29 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op21
  %op30 = sub i32 0, 1
  store i32 %op30, i32* %op29
  %op31 = add i32 %op21, 1
  br label %label20
}
