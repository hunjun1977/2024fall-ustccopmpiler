# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl n
	.type n, @object
	.size n, 4
n:
	.space 4
	.globl m
	.type m, @object
	.size m, 4
m:
	.space 4
	.globl w
	.type w, @object
	.size w, 20
w:
	.space 20
	.globl v
	.type v, @object
	.size v, 20
v:
	.space 20
	.globl dp
	.type dp, @object
	.size dp, 264
dp:
	.space 264
	.text
	.globl max
	.type max, @function
max:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry:
# %op2 = icmp sgt i32 %arg0, %arg1
	ld.w $t1, $fp, -20
	ld.w $t2, $fp, -24
	slt $t0, $t2, $t1
	st.b $t0, $fp, -25
# br i1 %op2, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -25
	bnez $t0, .max_label_turnBB1
	b .max_label_falseBB1
.max_label_turnBB1:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.max_label_falseBB1:
# ret i32 %arg1
	ld.w $a0, $fp, -24
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -192
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry:
# %op2 = icmp sle i32 %arg1, 0
	ld.w $t1, $fp, -24
	addi.w $t2, $zero, 0
	slt $t0, $t2, $t1
	xori $t0, $t0, 1
	st.b $t0, $fp, -25
# br i1 %op2, label %label_turnBB2, label %label_nextBB2
	ld.b $t0, $fp, -25
	bnez $t0, .knapsack_label_turnBB2
	b .knapsack_label_nextBB2
.knapsack_label_turnBB2:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_nextBB2:
# %op3 = icmp eq i32 %arg0, 0
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -26
# br i1 %op3, label %label_turnBB3, label %label_nextBB3
	ld.b $t0, $fp, -26
	bnez $t0, .knapsack_label_turnBB3
	b .knapsack_label_nextBB3
.knapsack_label_turnBB3:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_nextBB3:
# %op4 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -30
# %op5 = add i32 %op4, %arg1
	ld.w $t0, $fp, -30
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# %op6 = icmp sge i32 %op5, 0
	ld.w $t1, $fp, -34
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -35
# br i1 %op6, label %label_end1, label %label_error1
	ld.b $t0, $fp, -35
	bnez $t0, .knapsack_label_end1
	b .knapsack_label_error1
.knapsack_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .knapsack_label_end1
.knapsack_label_end1:
# %op7 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op5
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -34
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -43
# %op8 = load i32, i32* %op7
	ld.d $t0, $fp, -43
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -47
# %op9 = icmp sge i32 %op8, 0
	ld.w $t1, $fp, -47
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -48
# br i1 %op9, label %label_turnBB4, label %label_nextBB4
	ld.b $t0, $fp, -48
	bnez $t0, .knapsack_label_turnBB4
	b .knapsack_label_nextBB4
.knapsack_label_turnBB4:
# %op10 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# %op11 = add i32 %op10, %arg1
	ld.w $t0, $fp, -52
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -56
# %op12 = icmp sge i32 %op11, 0
	ld.w $t1, $fp, -56
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -57
# br i1 %op12, label %label_end2, label %label_error2
	ld.b $t0, $fp, -57
	bnez $t0, .knapsack_label_end2
	b .knapsack_label_error2
.knapsack_label_nextBB4:
# %op13 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -61
# %op14 = icmp sge i32 %op13, 0
	ld.w $t1, $fp, -61
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -62
# br i1 %op14, label %label_end3, label %label_error3
	ld.b $t0, $fp, -62
	bnez $t0, .knapsack_label_end3
	b .knapsack_label_error3
.knapsack_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .knapsack_label_end2
.knapsack_label_end2:
# %op15 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op11
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -56
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -70
# %op16 = load i32, i32* %op15
	ld.d $t0, $fp, -70
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -74
# ret i32 %op16
	ld.w $a0, $fp, -74
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_error3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end3
	b .knapsack_label_end3
.knapsack_label_end3:
# %op17 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op13
	la.local $t0, w
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -61
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -82
# %op18 = load i32, i32* %op17
	ld.d $t0, $fp, -82
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -86
# %op19 = icmp slt i32 %arg1, %op18
	ld.w $t1, $fp, -24
	ld.w $t2, $fp, -86
	slt $t0, $t1, $t2
	st.b $t0, $fp, -87
# br i1 %op19, label %label_turnBB5, label %label_falseBB5
	ld.b $t0, $fp, -87
	bnez $t0, .knapsack_label_turnBB5
	b .knapsack_label_falseBB5
.knapsack_label_turnBB5:
# %op20 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -91
# %op21 = call i32 @knapsack(i32 %op20, i32 %arg1)
	ld.w $a0, $fp, -91
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -95
# br label %label_nextBB5
	ld.w $a0, $fp, -95
	st.w $a0, $fp, -116
	b .knapsack_label_nextBB5
.knapsack_label_falseBB5:
# %op22 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -99
# %op23 = call i32 @knapsack(i32 %op22, i32 %arg1)
	ld.w $a0, $fp, -99
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -103
# %op24 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -107
# %op25 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -111
# %op26 = icmp sge i32 %op25, 0
	ld.w $t1, $fp, -111
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -112
# br i1 %op26, label %label_end4, label %label_error4
	ld.b $t0, $fp, -112
	bnez $t0, .knapsack_label_end4
	b .knapsack_label_error4
.knapsack_label_nextBB5:
# %op27 = phi i32 [ %op21, %label_turnBB5 ], [ %op40, %label_end5 ]
# %op28 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# %op29 = add i32 %op28, %arg1
	ld.w $t0, $fp, -120
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op30 = icmp sge i32 %op29, 0
	ld.w $t1, $fp, -124
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -125
# br i1 %op30, label %label_end6, label %label_error6
	ld.b $t0, $fp, -125
	bnez $t0, .knapsack_label_end6
	b .knapsack_label_error6
.knapsack_label_error4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end4
	b .knapsack_label_end4
.knapsack_label_end4:
# %op31 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op25
	la.local $t0, w
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -111
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -133
# %op32 = load i32, i32* %op31
	ld.d $t0, $fp, -133
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -137
# %op33 = sub i32 %arg1, %op32
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -137
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -141
# %op34 = call i32 @knapsack(i32 %op24, i32 %op33)
	ld.w $a0, $fp, -107
	ld.w $a1, $fp, -141
	bl knapsack
	st.w $a0, $fp, -145
# %op35 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -149
# %op36 = icmp sge i32 %op35, 0
	ld.w $t1, $fp, -149
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -150
# br i1 %op36, label %label_end5, label %label_error5
	ld.b $t0, $fp, -150
	bnez $t0, .knapsack_label_end5
	b .knapsack_label_error5
.knapsack_label_error5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end5
	b .knapsack_label_end5
.knapsack_label_end5:
# %op37 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op35
	la.local $t0, v
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -149
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -158
# %op38 = load i32, i32* %op37
	ld.d $t0, $fp, -158
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -162
# %op39 = add i32 %op34, %op38
	ld.w $t0, $fp, -145
	ld.w $t1, $fp, -162
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -166
# %op40 = call i32 @max(i32 %op23, i32 %op39)
	ld.w $a0, $fp, -103
	ld.w $a1, $fp, -166
	bl max
	st.w $a0, $fp, -170
# br label %label_nextBB5
	ld.w $a0, $fp, -170
	st.w $a0, $fp, -116
	b .knapsack_label_nextBB5
.knapsack_label_error6:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end6
	b .knapsack_label_end6
.knapsack_label_end6:
# %op41 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op29
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -124
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -178
# store i32 %op27, i32* %op41
	ld.w $t1, $fp, -116
	ld.d $t0, $fp, -178
	st.w $t1, $t0, 0
# ret i32 %op27
	ld.w $a0, $fp, -116
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	ld.w $t0, $fp, -95
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -116
	ld.w $t0, $fp, -170
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -116
	addi.d $sp, $sp, 192
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# store i32 5, i32* @n
	addi.w $t1, $zero, 5
	la.local $t0, n
	st.w $t1, $t0, 0
# store i32 10, i32* @m
	addi.w $t1, $zero, 10
	la.local $t0, m
	st.w $t1, $t0, 0
# %op0 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -17
# br i1 %op0, label %label_end7, label %label_error7
	ld.b $t0, $fp, -17
	bnez $t0, .main_label_end7
	b .main_label_error7
.main_label_error7:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end7
	b .main_label_end7
.main_label_end7:
# %op1 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -25
# store i32 2, i32* %op1
	addi.w $t1, $zero, 2
	ld.d $t0, $fp, -25
	st.w $t1, $t0, 0
# %op2 = icmp sge i32 1, 0
	addi.w $t1, $zero, 1
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -26
# br i1 %op2, label %label_end8, label %label_error8
	ld.b $t0, $fp, -26
	bnez $t0, .main_label_end8
	b .main_label_error8
.main_label_error8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end8
	b .main_label_end8
.main_label_end8:
# %op3 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 4
	st.d $t0, $fp, -34
# store i32 2, i32* %op3
	addi.w $t1, $zero, 2
	ld.d $t0, $fp, -34
	st.w $t1, $t0, 0
# %op4 = icmp sge i32 2, 0
	addi.w $t1, $zero, 2
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -35
# br i1 %op4, label %label_end9, label %label_error9
	ld.b $t0, $fp, -35
	bnez $t0, .main_label_end9
	b .main_label_error9
.main_label_error9:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end9
	b .main_label_end9
.main_label_end9:
# %op5 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 8
	st.d $t0, $fp, -43
# store i32 6, i32* %op5
	addi.w $t1, $zero, 6
	ld.d $t0, $fp, -43
	st.w $t1, $t0, 0
# %op6 = icmp sge i32 3, 0
	addi.w $t1, $zero, 3
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -44
# br i1 %op6, label %label_end10, label %label_error10
	ld.b $t0, $fp, -44
	bnez $t0, .main_label_end10
	b .main_label_error10
.main_label_error10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end10
	b .main_label_end10
.main_label_end10:
# %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 12
	st.d $t0, $fp, -52
# store i32 5, i32* %op7
	addi.w $t1, $zero, 5
	ld.d $t0, $fp, -52
	st.w $t1, $t0, 0
# %op8 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -53
# br i1 %op8, label %label_end11, label %label_error11
	ld.b $t0, $fp, -53
	bnez $t0, .main_label_end11
	b .main_label_error11
.main_label_error11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end11
	b .main_label_end11
.main_label_end11:
# %op9 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -61
# store i32 4, i32* %op9
	addi.w $t1, $zero, 4
	ld.d $t0, $fp, -61
	st.w $t1, $t0, 0
# %op10 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -62
# br i1 %op10, label %label_end12, label %label_error12
	ld.b $t0, $fp, -62
	bnez $t0, .main_label_end12
	b .main_label_error12
.main_label_error12:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end12
	b .main_label_end12
.main_label_end12:
# %op11 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -70
# store i32 6, i32* %op11
	addi.w $t1, $zero, 6
	ld.d $t0, $fp, -70
	st.w $t1, $t0, 0
# %op12 = icmp sge i32 1, 0
	addi.w $t1, $zero, 1
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -71
# br i1 %op12, label %label_end13, label %label_error13
	ld.b $t0, $fp, -71
	bnez $t0, .main_label_end13
	b .main_label_error13
.main_label_error13:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end13
	b .main_label_end13
.main_label_end13:
# %op13 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 4
	st.d $t0, $fp, -79
# store i32 3, i32* %op13
	addi.w $t1, $zero, 3
	ld.d $t0, $fp, -79
	st.w $t1, $t0, 0
# %op14 = icmp sge i32 2, 0
	addi.w $t1, $zero, 2
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -80
# br i1 %op14, label %label_end14, label %label_error14
	ld.b $t0, $fp, -80
	bnez $t0, .main_label_end14
	b .main_label_error14
.main_label_error14:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end14
	b .main_label_end14
.main_label_end14:
# %op15 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 8
	st.d $t0, $fp, -88
# store i32 5, i32* %op15
	addi.w $t1, $zero, 5
	ld.d $t0, $fp, -88
	st.w $t1, $t0, 0
# %op16 = icmp sge i32 3, 0
	addi.w $t1, $zero, 3
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -89
# br i1 %op16, label %label_end15, label %label_error15
	ld.b $t0, $fp, -89
	bnez $t0, .main_label_end15
	b .main_label_error15
.main_label_error15:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end15
	b .main_label_end15
.main_label_end15:
# %op17 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 12
	st.d $t0, $fp, -97
# store i32 4, i32* %op17
	addi.w $t1, $zero, 4
	ld.d $t0, $fp, -97
	st.w $t1, $t0, 0
# %op18 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -98
# br i1 %op18, label %label_end16, label %label_error16
	ld.b $t0, $fp, -98
	bnez $t0, .main_label_end16
	b .main_label_error16
.main_label_error16:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end16
	b .main_label_end16
.main_label_end16:
# %op19 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -106
# store i32 6, i32* %op19
	addi.w $t1, $zero, 6
	ld.d $t0, $fp, -106
	st.w $t1, $t0, 0
# br label %label32
	b .main_label32
.main_label20:
# %op21 = phi i32 [ %op31, %label_end17 ], [ 0, %label32 ]
# %op22 = icmp slt i32 %op21, 66
	ld.w $t1, $fp, -110
	addi.w $t2, $zero, 66
	slt $t0, $t1, $t2
	st.b $t0, $fp, -111
# br i1 %op22, label %label23, label %label25
	ld.b $t0, $fp, -111
	bnez $t0, .main_label23
	b .main_label25
.main_label23:
# %op24 = icmp sge i32 %op21, 0
	ld.w $t1, $fp, -110
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -112
# br i1 %op24, label %label_end17, label %label_error17
	ld.b $t0, $fp, -112
	bnez $t0, .main_label_end17
	b .main_label_error17
.main_label25:
# %op26 = load i32, i32* @n
	la.local $t0, n
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -116
# %op27 = load i32, i32* @m
	la.local $t0, m
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -120
# %op28 = call i32 @knapsack(i32 %op26, i32 %op27)
	ld.w $a0, $fp, -116
	ld.w $a1, $fp, -120
	bl knapsack
	st.w $a0, $fp, -124
# call void @output(i32 %op28)
	ld.w $a0, $fp, -124
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_error17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end17
	b .main_label_end17
.main_label_end17:
# %op29 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op21
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -110
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -132
# store i32 %op30, i32* %op29
	ld.w $t1, $fp, -140
	ld.d $t0, $fp, -132
	st.w $t1, $t0, 0
# %op31 = add i32 %op21, 1
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# br label %label20
	ld.w $a0, $fp, -136
	st.w $a0, $fp, -110
	b .main_label20
.main_label32:
# %op30 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# br label %label20
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -110
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -110
	b .main_label20
	ld.w $t0, $fp, -136
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -110
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -110
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
