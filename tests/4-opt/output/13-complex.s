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
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry:
# %op2 = alloca i32
	addi.d $t0, $fp, -36
	st.d $t0, $fp, -32
# %op3 = alloca i32
	addi.d $t0, $fp, -48
	st.d $t0, $fp, -44
# store i32 %arg0, i32* %op2
	ld.w $t1, $fp, -20
	ld.d $t0, $fp, -32
	st.w $t1, $t0, 0
# store i32 %arg1, i32* %op3
	ld.w $t1, $fp, -24
	ld.d $t0, $fp, -44
	st.w $t1, $t0, 0
# %op4 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -52
# %op5 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -56
# %op6 = icmp sgt i32 %op4, %op5
	ld.w $t1, $fp, -52
	ld.w $t2, $fp, -56
	slt $t0, $t2, $t1
	st.b $t0, $fp, -57
# br i1 %op6, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -57
	bnez $t0, .max_label_turnBB1
	b .max_label_falseBB1
.max_label_turnBB1:
# %op7 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -61
# ret i32 %op7
	ld.w $a0, $fp, -61
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.max_label_falseBB1:
# %op8 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -65
# ret i32 %op8
	ld.w $a0, $fp, -65
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -304
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry:
# %op2 = alloca i32
	addi.d $t0, $fp, -36
	st.d $t0, $fp, -32
# %op3 = alloca i32
	addi.d $t0, $fp, -48
	st.d $t0, $fp, -44
# store i32 %arg0, i32* %op2
	ld.w $t1, $fp, -20
	ld.d $t0, $fp, -32
	st.w $t1, $t0, 0
# store i32 %arg1, i32* %op3
	ld.w $t1, $fp, -24
	ld.d $t0, $fp, -44
	st.w $t1, $t0, 0
# %op4 = alloca i32
	addi.d $t0, $fp, -60
	st.d $t0, $fp, -56
# %op5 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -64
# %op6 = icmp sle i32 %op5, 0
	ld.w $t1, $fp, -64
	addi.w $t2, $zero, 0
	slt $t0, $t2, $t1
	xori $t0, $t0, 1
	st.b $t0, $fp, -65
# br i1 %op6, label %label_turnBB2, label %label_nextBB2
	ld.b $t0, $fp, -65
	bnez $t0, .knapsack_label_turnBB2
	b .knapsack_label_nextBB2
.knapsack_label_turnBB2:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_nextBB2:
# %op7 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -69
# %op8 = icmp eq i32 %op7, 0
	ld.w $t1, $fp, -69
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -70
# br i1 %op8, label %label_turnBB3, label %label_nextBB3
	ld.b $t0, $fp, -70
	bnez $t0, .knapsack_label_turnBB3
	b .knapsack_label_nextBB3
.knapsack_label_turnBB3:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_nextBB3:
# %op9 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -74
# %op10 = mul i32 %op9, 11
	ld.w $t0, $fp, -74
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -78
# %op11 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -82
# %op12 = add i32 %op10, %op11
	ld.w $t0, $fp, -78
	ld.w $t1, $fp, -82
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -86
# %op13 = icmp sge i32 %op12, 0
	ld.w $t1, $fp, -86
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -87
# br i1 %op13, label %label_end1, label %label_error1
	ld.b $t0, $fp, -87
	bnez $t0, .knapsack_label_end1
	b .knapsack_label_error1
.knapsack_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .knapsack_label_end1
.knapsack_label_end1:
# %op14 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op12
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -86
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -95
# %op15 = load i32, i32* %op14
	ld.d $t0, $fp, -95
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -99
# %op16 = icmp sge i32 %op15, 0
	ld.w $t1, $fp, -99
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -100
# br i1 %op16, label %label_turnBB4, label %label_nextBB4
	ld.b $t0, $fp, -100
	bnez $t0, .knapsack_label_turnBB4
	b .knapsack_label_nextBB4
.knapsack_label_turnBB4:
# %op17 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -104
# %op18 = mul i32 %op17, 11
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# %op19 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -112
# %op20 = add i32 %op18, %op19
	ld.w $t0, $fp, -108
	ld.w $t1, $fp, -112
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -116
# %op21 = icmp sge i32 %op20, 0
	ld.w $t1, $fp, -116
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -117
# br i1 %op21, label %label_end2, label %label_error2
	ld.b $t0, $fp, -117
	bnez $t0, .knapsack_label_end2
	b .knapsack_label_error2
.knapsack_label_nextBB4:
# %op22 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -121
# %op23 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -125
# %op24 = sub i32 %op23, 1
	ld.w $t0, $fp, -125
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -129
# %op25 = icmp sge i32 %op24, 0
	ld.w $t1, $fp, -129
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -130
# br i1 %op25, label %label_end3, label %label_error3
	ld.b $t0, $fp, -130
	bnez $t0, .knapsack_label_end3
	b .knapsack_label_error3
.knapsack_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .knapsack_label_end2
.knapsack_label_end2:
# %op26 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op20
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -116
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -138
# %op27 = load i32, i32* %op26
	ld.d $t0, $fp, -138
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -142
# ret i32 %op27
	ld.w $a0, $fp, -142
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.knapsack_label_error3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end3
	b .knapsack_label_end3
.knapsack_label_end3:
# %op28 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op24
	la.local $t0, w
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -129
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -150
# %op29 = load i32, i32* %op28
	ld.d $t0, $fp, -150
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -154
# %op30 = icmp slt i32 %op22, %op29
	ld.w $t1, $fp, -121
	ld.w $t2, $fp, -154
	slt $t0, $t1, $t2
	st.b $t0, $fp, -155
# br i1 %op30, label %label_turnBB5, label %label_falseBB5
	ld.b $t0, $fp, -155
	bnez $t0, .knapsack_label_turnBB5
	b .knapsack_label_falseBB5
.knapsack_label_turnBB5:
# %op31 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -159
# %op32 = sub i32 %op31, 1
	ld.w $t0, $fp, -159
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -163
# %op33 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -167
# %op34 = call i32 @knapsack(i32 %op32, i32 %op33)
	ld.w $a0, $fp, -163
	ld.w $a1, $fp, -167
	bl knapsack
	st.w $a0, $fp, -171
# store i32 %op34, i32* %op4
	ld.w $t1, $fp, -171
	ld.d $t0, $fp, -56
	st.w $t1, $t0, 0
# br label %label_nextBB5
	b .knapsack_label_nextBB5
.knapsack_label_falseBB5:
# %op35 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -175
# %op36 = sub i32 %op35, 1
	ld.w $t0, $fp, -175
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -179
# %op37 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -183
# %op38 = call i32 @knapsack(i32 %op36, i32 %op37)
	ld.w $a0, $fp, -179
	ld.w $a1, $fp, -183
	bl knapsack
	st.w $a0, $fp, -187
# %op39 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -191
# %op40 = sub i32 %op39, 1
	ld.w $t0, $fp, -191
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -195
# %op41 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -199
# %op42 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -203
# %op43 = sub i32 %op42, 1
	ld.w $t0, $fp, -203
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -207
# %op44 = icmp sge i32 %op43, 0
	ld.w $t1, $fp, -207
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -208
# br i1 %op44, label %label_end4, label %label_error4
	ld.b $t0, $fp, -208
	bnez $t0, .knapsack_label_end4
	b .knapsack_label_error4
.knapsack_label_nextBB5:
# %op45 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -212
# %op46 = mul i32 %op45, 11
	ld.w $t0, $fp, -212
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -216
# %op47 = load i32, i32* %op3
	ld.d $t0, $fp, -44
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -220
# %op48 = add i32 %op46, %op47
	ld.w $t0, $fp, -216
	ld.w $t1, $fp, -220
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -224
# %op49 = icmp sge i32 %op48, 0
	ld.w $t1, $fp, -224
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -225
# br i1 %op49, label %label_end6, label %label_error6
	ld.b $t0, $fp, -225
	bnez $t0, .knapsack_label_end6
	b .knapsack_label_error6
.knapsack_label_error4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end4
	b .knapsack_label_end4
.knapsack_label_end4:
# %op50 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op43
	la.local $t0, w
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -207
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -233
# %op51 = load i32, i32* %op50
	ld.d $t0, $fp, -233
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -237
# %op52 = sub i32 %op41, %op51
	ld.w $t0, $fp, -199
	ld.w $t1, $fp, -237
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -241
# %op53 = call i32 @knapsack(i32 %op40, i32 %op52)
	ld.w $a0, $fp, -195
	ld.w $a1, $fp, -241
	bl knapsack
	st.w $a0, $fp, -245
# %op54 = load i32, i32* %op2
	ld.d $t0, $fp, -32
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -249
# %op55 = sub i32 %op54, 1
	ld.w $t0, $fp, -249
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -253
# %op56 = icmp sge i32 %op55, 0
	ld.w $t1, $fp, -253
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -254
# br i1 %op56, label %label_end5, label %label_error5
	ld.b $t0, $fp, -254
	bnez $t0, .knapsack_label_end5
	b .knapsack_label_error5
.knapsack_label_error5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end5
	b .knapsack_label_end5
.knapsack_label_end5:
# %op57 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op55
	la.local $t0, v
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -253
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -262
# %op58 = load i32, i32* %op57
	ld.d $t0, $fp, -262
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -266
# %op59 = add i32 %op53, %op58
	ld.w $t0, $fp, -245
	ld.w $t1, $fp, -266
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -270
# %op60 = call i32 @max(i32 %op38, i32 %op59)
	ld.w $a0, $fp, -187
	ld.w $a1, $fp, -270
	bl max
	st.w $a0, $fp, -274
# store i32 %op60, i32* %op4
	ld.w $t1, $fp, -274
	ld.d $t0, $fp, -56
	st.w $t1, $t0, 0
# br label %label_nextBB5
	b .knapsack_label_nextBB5
.knapsack_label_error6:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end6
	b .knapsack_label_end6
.knapsack_label_end6:
# %op61 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op48
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -224
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -282
# %op62 = load i32, i32* %op4
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -286
# store i32 %op62, i32* %op61
	ld.w $t1, $fp, -286
	ld.d $t0, $fp, -282
	st.w $t1, $t0, 0
# %op63 = load i32, i32* %op4
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -290
# ret i32 %op63
	ld.w $a0, $fp, -290
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# store i32 0, i32* %op0
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# store i32 5, i32* @n
	addi.w $t1, $zero, 5
	la.local $t0, n
	st.w $t1, $t0, 0
# store i32 10, i32* @m
	addi.w $t1, $zero, 10
	la.local $t0, m
	st.w $t1, $t0, 0
# %op1 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -29
# br i1 %op1, label %label_end7, label %label_error7
	ld.b $t0, $fp, -29
	bnez $t0, .main_label_end7
	b .main_label_error7
.main_label_error7:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end7
	b .main_label_end7
.main_label_end7:
# %op2 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -37
# store i32 2, i32* %op2
	addi.w $t1, $zero, 2
	ld.d $t0, $fp, -37
	st.w $t1, $t0, 0
# %op3 = icmp sge i32 1, 0
	addi.w $t1, $zero, 1
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -38
# br i1 %op3, label %label_end8, label %label_error8
	ld.b $t0, $fp, -38
	bnez $t0, .main_label_end8
	b .main_label_error8
.main_label_error8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end8
	b .main_label_end8
.main_label_end8:
# %op4 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 4
	st.d $t0, $fp, -46
# store i32 2, i32* %op4
	addi.w $t1, $zero, 2
	ld.d $t0, $fp, -46
	st.w $t1, $t0, 0
# %op5 = icmp sge i32 2, 0
	addi.w $t1, $zero, 2
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -47
# br i1 %op5, label %label_end9, label %label_error9
	ld.b $t0, $fp, -47
	bnez $t0, .main_label_end9
	b .main_label_error9
.main_label_error9:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end9
	b .main_label_end9
.main_label_end9:
# %op6 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 8
	st.d $t0, $fp, -55
# store i32 6, i32* %op6
	addi.w $t1, $zero, 6
	ld.d $t0, $fp, -55
	st.w $t1, $t0, 0
# %op7 = icmp sge i32 3, 0
	addi.w $t1, $zero, 3
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -56
# br i1 %op7, label %label_end10, label %label_error10
	ld.b $t0, $fp, -56
	bnez $t0, .main_label_end10
	b .main_label_error10
.main_label_error10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end10
	b .main_label_end10
.main_label_end10:
# %op8 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 12
	st.d $t0, $fp, -64
# store i32 5, i32* %op8
	addi.w $t1, $zero, 5
	ld.d $t0, $fp, -64
	st.w $t1, $t0, 0
# %op9 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -65
# br i1 %op9, label %label_end11, label %label_error11
	ld.b $t0, $fp, -65
	bnez $t0, .main_label_end11
	b .main_label_error11
.main_label_error11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end11
	b .main_label_end11
.main_label_end11:
# %op10 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t0, w
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -73
# store i32 4, i32* %op10
	addi.w $t1, $zero, 4
	ld.d $t0, $fp, -73
	st.w $t1, $t0, 0
# %op11 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -74
# br i1 %op11, label %label_end12, label %label_error12
	ld.b $t0, $fp, -74
	bnez $t0, .main_label_end12
	b .main_label_error12
.main_label_error12:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end12
	b .main_label_end12
.main_label_end12:
# %op12 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -82
# store i32 6, i32* %op12
	addi.w $t1, $zero, 6
	ld.d $t0, $fp, -82
	st.w $t1, $t0, 0
# %op13 = icmp sge i32 1, 0
	addi.w $t1, $zero, 1
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -83
# br i1 %op13, label %label_end13, label %label_error13
	ld.b $t0, $fp, -83
	bnez $t0, .main_label_end13
	b .main_label_error13
.main_label_error13:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end13
	b .main_label_end13
.main_label_end13:
# %op14 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 4
	st.d $t0, $fp, -91
# store i32 3, i32* %op14
	addi.w $t1, $zero, 3
	ld.d $t0, $fp, -91
	st.w $t1, $t0, 0
# %op15 = icmp sge i32 2, 0
	addi.w $t1, $zero, 2
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -92
# br i1 %op15, label %label_end14, label %label_error14
	ld.b $t0, $fp, -92
	bnez $t0, .main_label_end14
	b .main_label_error14
.main_label_error14:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end14
	b .main_label_end14
.main_label_end14:
# %op16 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 8
	st.d $t0, $fp, -100
# store i32 5, i32* %op16
	addi.w $t1, $zero, 5
	ld.d $t0, $fp, -100
	st.w $t1, $t0, 0
# %op17 = icmp sge i32 3, 0
	addi.w $t1, $zero, 3
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -101
# br i1 %op17, label %label_end15, label %label_error15
	ld.b $t0, $fp, -101
	bnez $t0, .main_label_end15
	b .main_label_error15
.main_label_error15:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end15
	b .main_label_end15
.main_label_end15:
# %op18 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 12
	st.d $t0, $fp, -109
# store i32 4, i32* %op18
	addi.w $t1, $zero, 4
	ld.d $t0, $fp, -109
	st.w $t1, $t0, 0
# %op19 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -110
# br i1 %op19, label %label_end16, label %label_error16
	ld.b $t0, $fp, -110
	bnez $t0, .main_label_end16
	b .main_label_error16
.main_label_error16:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end16
	b .main_label_end16
.main_label_end16:
# %op20 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t0, v
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -118
# store i32 6, i32* %op20
	addi.w $t1, $zero, 6
	ld.d $t0, $fp, -118
	st.w $t1, $t0, 0
# br label %label21
	b .main_label21
.main_label21:
# %op22 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -122
# %op23 = icmp slt i32 %op22, 66
	ld.w $t1, $fp, -122
	addi.w $t2, $zero, 66
	slt $t0, $t1, $t2
	st.b $t0, $fp, -123
# br i1 %op23, label %label24, label %label27
	ld.b $t0, $fp, -123
	bnez $t0, .main_label24
	b .main_label27
.main_label24:
# %op25 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -127
# %op26 = icmp sge i32 %op25, 0
	ld.w $t1, $fp, -127
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -128
# br i1 %op26, label %label_end17, label %label_error17
	ld.b $t0, $fp, -128
	bnez $t0, .main_label_end17
	b .main_label_error17
.main_label27:
# %op28 = load i32, i32* @n
	la.local $t0, n
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -132
# %op29 = load i32, i32* @m
	la.local $t0, m
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -136
# %op30 = call i32 @knapsack(i32 %op28, i32 %op29)
	ld.w $a0, $fp, -132
	ld.w $a1, $fp, -136
	bl knapsack
	st.w $a0, $fp, -140
# call void @output(i32 %op30)
	ld.w $a0, $fp, -140
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_error17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end17
	b .main_label_end17
.main_label_end17:
# %op31 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op25
	la.local $t0, dp
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -127
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -148
# %op32 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -152
# store i32 %op32, i32* %op31
	ld.w $t1, $fp, -152
	ld.d $t0, $fp, -148
	st.w $t1, $t0, 0
# %op33 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -156
# %op34 = add i32 %op33, 1
	ld.w $t0, $fp, -156
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -160
# store i32 %op34, i32* %op0
	ld.w $t1, $fp, -160
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# br label %label21
	b .main_label21
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
