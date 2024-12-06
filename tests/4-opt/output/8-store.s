	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
.store_label_entry:
# %op3 = alloca i32
	addi.d $t0, $fp, -44
	st.d $t0, $fp, -40
# %op4 = alloca i32
	addi.d $t0, $fp, -56
	st.d $t0, $fp, -52
# store i32 %arg1, i32* %op3
	ld.w $t1, $fp, -28
	ld.d $t0, $fp, -40
	st.w $t1, $t0, 0
# store i32 %arg2, i32* %op4
	ld.w $t1, $fp, -32
	ld.d $t0, $fp, -52
	st.w $t1, $t0, 0
# %op5 = load i32, i32* %op3
	ld.d $t0, $fp, -40
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -60
# %op6 = icmp sge i32 %op5, 0
	ld.w $t1, $fp, -60
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -61
# br i1 %op6, label %label_end1, label %label_error1
	ld.b $t0, $fp, -61
	bnez $t0, .store_label_end1
	b .store_label_error1
.store_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .store_label_end1
.store_label_end1:
# %op7 = getelementptr i32, i32* %arg0, i32 %op5
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -60
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -69
# %op8 = load i32, i32* %op4
	ld.d $t0, $fp, -52
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -73
# store i32 %op8, i32* %op7
	ld.w $t1, $fp, -73
	ld.d $t0, $fp, -69
	st.w $t1, $t0, 0
# %op9 = load i32, i32* %op4
	ld.d $t0, $fp, -52
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -77
# ret i32 %op9
	ld.w $a0, $fp, -77
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -176
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -76
	st.d $t0, $fp, -72
# %op2 = alloca i32
	addi.d $t0, $fp, -88
	st.d $t0, $fp, -84
# store i32 0, i32* %op1
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -72
	st.w $t1, $t0, 0
# br label %label3
	b .main_label3
.main_label3:
# %op4 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -92
# %op5 = icmp slt i32 %op4, 10
	ld.w $t1, $fp, -92
	addi.w $t2, $zero, 10
	slt $t0, $t1, $t2
	st.b $t0, $fp, -93
# br i1 %op5, label %label6, label %label14
	ld.b $t0, $fp, -93
	bnez $t0, .main_label6
	b .main_label14
.main_label6:
# %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -101
# %op8 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -105
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -109
# %op10 = mul i32 %op9, 2
	ld.w $t0, $fp, -109
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -113
# %op11 = call i32 @store(i32* %op7, i32 %op8, i32 %op10)
	ld.d $a0, $fp, -101
	ld.w $a1, $fp, -105
	ld.w $a2, $fp, -113
	bl store
	st.w $a0, $fp, -117
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -121
# %op13 = add i32 %op12, 1
	ld.w $t0, $fp, -121
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -125
# store i32 %op13, i32* %op1
	ld.w $t1, $fp, -125
	ld.d $t0, $fp, -72
	st.w $t1, $t0, 0
# br label %label3
	b .main_label3
.main_label14:
# store i32 0, i32* %op2
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -84
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -72
	st.w $t1, $t0, 0
# br label %label15
	b .main_label15
.main_label15:
# %op16 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -129
# %op17 = icmp slt i32 %op16, 10
	ld.w $t1, $fp, -129
	addi.w $t2, $zero, 10
	slt $t0, $t1, $t2
	st.b $t0, $fp, -130
# br i1 %op17, label %label18, label %label22
	ld.b $t0, $fp, -130
	bnez $t0, .main_label18
	b .main_label22
.main_label18:
# %op19 = load i32, i32* %op2
	ld.d $t0, $fp, -84
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -134
# %op20 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -138
# %op21 = icmp sge i32 %op20, 0
	ld.w $t1, $fp, -138
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -139
# br i1 %op21, label %label_end2, label %label_error2
	ld.b $t0, $fp, -139
	bnez $t0, .main_label_end2
	b .main_label_error2
.main_label22:
# %op23 = load i32, i32* %op2
	ld.d $t0, $fp, -84
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -143
# call void @output(i32 %op23)
	ld.w $a0, $fp, -143
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .main_label_end2
.main_label_end2:
# %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op20
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -138
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -151
# %op25 = load i32, i32* %op24
	ld.d $t0, $fp, -151
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -155
# %op26 = add i32 %op19, %op25
	ld.w $t0, $fp, -134
	ld.w $t1, $fp, -155
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -159
# store i32 %op26, i32* %op2
	ld.w $t1, $fp, -159
	ld.d $t0, $fp, -84
	st.w $t1, $t0, 0
# %op27 = load i32, i32* %op1
	ld.d $t0, $fp, -72
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -163
# %op28 = add i32 %op27, 1
	ld.w $t0, $fp, -163
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -167
# store i32 %op28, i32* %op1
	ld.w $t1, $fp, -167
	ld.d $t0, $fp, -72
	st.w $t1, $t0, 0
# br label %label15
	b .main_label15
	addi.d $sp, $sp, 176
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
