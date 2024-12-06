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
  %op2 = alloca i32
  %op3 = alloca i32
  store i32 %arg0, i32* %op2
  store i32 %arg1, i32* %op3
  %op4 = load i32, i32* %op2
  %op5 = load i32, i32* %op3
  %op6 = icmp sgt i32 %op4, %op5
  br i1 %op6, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  %op7 = load i32, i32* %op2
  ret i32 %op7
label_falseBB1:                                                ; preds = %label_entry
  %op8 = load i32, i32* %op3
  ret i32 %op8
}
define i32 @knapsack(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  %op3 = alloca i32
  store i32 %arg0, i32* %op2
  store i32 %arg1, i32* %op3
  %op4 = alloca i32
  %op5 = load i32, i32* %op3
  %op6 = icmp sle i32 %op5, 0
  br i1 %op6, label %label_turnBB2, label %label_nextBB2
label_turnBB2:                                                ; preds = %label_entry
  ret i32 0
label_nextBB2:                                                ; preds = %label_entry
  %op7 = load i32, i32* %op2
  %op8 = icmp eq i32 %op7, 0
  br i1 %op8, label %label_turnBB3, label %label_nextBB3
label_turnBB3:                                                ; preds = %label_nextBB2
  ret i32 0
label_nextBB3:                                                ; preds = %label_nextBB2
  %op9 = load i32, i32* %op2
  %op10 = mul i32 %op9, 11
  %op11 = load i32, i32* %op3
  %op12 = add i32 %op10, %op11
  %op13 = icmp sge i32 %op12, 0
  br i1 %op13, label %label_end1, label %label_error1
label_error1:                                                ; preds = %label_nextBB3
  call void @neg_idx_except()
  br label %label_end1
label_end1:                                                ; preds = %label_nextBB3, %label_error1
  %op14 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op12
  %op15 = load i32, i32* %op14
  %op16 = icmp sge i32 %op15, 0
  br i1 %op16, label %label_turnBB4, label %label_nextBB4
label_turnBB4:                                                ; preds = %label_end1
  %op17 = load i32, i32* %op2
  %op18 = mul i32 %op17, 11
  %op19 = load i32, i32* %op3
  %op20 = add i32 %op18, %op19
  %op21 = icmp sge i32 %op20, 0
  br i1 %op21, label %label_end2, label %label_error2
label_nextBB4:                                                ; preds = %label_end1
  %op22 = load i32, i32* %op3
  %op23 = load i32, i32* %op2
  %op24 = sub i32 %op23, 1
  %op25 = icmp sge i32 %op24, 0
  br i1 %op25, label %label_end3, label %label_error3
label_error2:                                                ; preds = %label_turnBB4
  call void @neg_idx_except()
  br label %label_end2
label_end2:                                                ; preds = %label_turnBB4, %label_error2
  %op26 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op20
  %op27 = load i32, i32* %op26
  ret i32 %op27
label_error3:                                                ; preds = %label_nextBB4
  call void @neg_idx_except()
  br label %label_end3
label_end3:                                                ; preds = %label_nextBB4, %label_error3
  %op28 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op24
  %op29 = load i32, i32* %op28
  %op30 = icmp slt i32 %op22, %op29
  br i1 %op30, label %label_turnBB5, label %label_falseBB5
label_turnBB5:                                                ; preds = %label_end3
  %op31 = load i32, i32* %op2
  %op32 = sub i32 %op31, 1
  %op33 = load i32, i32* %op3
  %op34 = call i32 @knapsack(i32 %op32, i32 %op33)
  store i32 %op34, i32* %op4
  br label %label_nextBB5
label_falseBB5:                                                ; preds = %label_end3
  %op35 = load i32, i32* %op2
  %op36 = sub i32 %op35, 1
  %op37 = load i32, i32* %op3
  %op38 = call i32 @knapsack(i32 %op36, i32 %op37)
  %op39 = load i32, i32* %op2
  %op40 = sub i32 %op39, 1
  %op41 = load i32, i32* %op3
  %op42 = load i32, i32* %op2
  %op43 = sub i32 %op42, 1
  %op44 = icmp sge i32 %op43, 0
  br i1 %op44, label %label_end4, label %label_error4
label_nextBB5:                                                ; preds = %label_end5, %label_turnBB5
  %op45 = load i32, i32* %op2
  %op46 = mul i32 %op45, 11
  %op47 = load i32, i32* %op3
  %op48 = add i32 %op46, %op47
  %op49 = icmp sge i32 %op48, 0
  br i1 %op49, label %label_end6, label %label_error6
label_error4:                                                ; preds = %label_falseBB5
  call void @neg_idx_except()
  br label %label_end4
label_end4:                                                ; preds = %label_falseBB5, %label_error4
  %op50 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op43
  %op51 = load i32, i32* %op50
  %op52 = sub i32 %op41, %op51
  %op53 = call i32 @knapsack(i32 %op40, i32 %op52)
  %op54 = load i32, i32* %op2
  %op55 = sub i32 %op54, 1
  %op56 = icmp sge i32 %op55, 0
  br i1 %op56, label %label_end5, label %label_error5
label_error5:                                                ; preds = %label_end4
  call void @neg_idx_except()
  br label %label_end5
label_end5:                                                ; preds = %label_end4, %label_error5
  %op57 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op55
  %op58 = load i32, i32* %op57
  %op59 = add i32 %op53, %op58
  %op60 = call i32 @max(i32 %op38, i32 %op59)
  store i32 %op60, i32* %op4
  br label %label_nextBB5
label_error6:                                                ; preds = %label_nextBB5
  call void @neg_idx_except()
  br label %label_end6
label_end6:                                                ; preds = %label_nextBB5, %label_error6
  %op61 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op48
  %op62 = load i32, i32* %op4
  store i32 %op62, i32* %op61
  %op63 = load i32, i32* %op4
  ret i32 %op63
}
define i32 @main() {
label_entry:
  %op0 = alloca i32
  store i32 0, i32* %op0
  store i32 5, i32* @n
  store i32 10, i32* @m
  %op1 = icmp sge i32 0, 0
  br i1 %op1, label %label_end7, label %label_error7
label_error7:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label_end7
label_end7:                                                ; preds = %label_entry, %label_error7
  %op2 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
  store i32 2, i32* %op2
  %op3 = icmp sge i32 1, 0
  br i1 %op3, label %label_end8, label %label_error8
label_error8:                                                ; preds = %label_end7
  call void @neg_idx_except()
  br label %label_end8
label_end8:                                                ; preds = %label_end7, %label_error8
  %op4 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
  store i32 2, i32* %op4
  %op5 = icmp sge i32 2, 0
  br i1 %op5, label %label_end9, label %label_error9
label_error9:                                                ; preds = %label_end8
  call void @neg_idx_except()
  br label %label_end9
label_end9:                                                ; preds = %label_end8, %label_error9
  %op6 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
  store i32 6, i32* %op6
  %op7 = icmp sge i32 3, 0
  br i1 %op7, label %label_end10, label %label_error10
label_error10:                                                ; preds = %label_end9
  call void @neg_idx_except()
  br label %label_end10
label_end10:                                                ; preds = %label_end9, %label_error10
  %op8 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
  store i32 5, i32* %op8
  %op9 = icmp sge i32 4, 0
  br i1 %op9, label %label_end11, label %label_error11
label_error11:                                                ; preds = %label_end10
  call void @neg_idx_except()
  br label %label_end11
label_end11:                                                ; preds = %label_end10, %label_error11
  %op10 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
  store i32 4, i32* %op10
  %op11 = icmp sge i32 0, 0
  br i1 %op11, label %label_end12, label %label_error12
label_error12:                                                ; preds = %label_end11
  call void @neg_idx_except()
  br label %label_end12
label_end12:                                                ; preds = %label_end11, %label_error12
  %op12 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
  store i32 6, i32* %op12
  %op13 = icmp sge i32 1, 0
  br i1 %op13, label %label_end13, label %label_error13
label_error13:                                                ; preds = %label_end12
  call void @neg_idx_except()
  br label %label_end13
label_end13:                                                ; preds = %label_end12, %label_error13
  %op14 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
  store i32 3, i32* %op14
  %op15 = icmp sge i32 2, 0
  br i1 %op15, label %label_end14, label %label_error14
label_error14:                                                ; preds = %label_end13
  call void @neg_idx_except()
  br label %label_end14
label_end14:                                                ; preds = %label_end13, %label_error14
  %op16 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
  store i32 5, i32* %op16
  %op17 = icmp sge i32 3, 0
  br i1 %op17, label %label_end15, label %label_error15
label_error15:                                                ; preds = %label_end14
  call void @neg_idx_except()
  br label %label_end15
label_end15:                                                ; preds = %label_end14, %label_error15
  %op18 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
  store i32 4, i32* %op18
  %op19 = icmp sge i32 4, 0
  br i1 %op19, label %label_end16, label %label_error16
label_error16:                                                ; preds = %label_end15
  call void @neg_idx_except()
  br label %label_end16
label_end16:                                                ; preds = %label_end15, %label_error16
  %op20 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
  store i32 6, i32* %op20
  br label %label21
label21:                                                ; preds = %label_end16, %label_end17
  %op22 = load i32, i32* %op0
  %op23 = icmp slt i32 %op22, 66
  br i1 %op23, label %label24, label %label27
label24:                                                ; preds = %label21
  %op25 = load i32, i32* %op0
  %op26 = icmp sge i32 %op25, 0
  br i1 %op26, label %label_end17, label %label_error17
label27:                                                ; preds = %label21
  %op28 = load i32, i32* @n
  %op29 = load i32, i32* @m
  %op30 = call i32 @knapsack(i32 %op28, i32 %op29)
  call void @output(i32 %op30)
  ret i32 0
label_error17:                                                ; preds = %label24
  call void @neg_idx_except()
  br label %label_end17
label_end17:                                                ; preds = %label24, %label_error17
  %op31 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op25
  %op32 = sub i32 0, 1
  store i32 %op32, i32* %op31
  %op33 = load i32, i32* %op0
  %op34 = add i32 %op33, 1
  store i32 %op34, i32* %op0
  br label %label21
}
