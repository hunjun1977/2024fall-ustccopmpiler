	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -76
	st.d $t0, $fp, -72
# store i32 0, i32* %op1
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -72
	st.w $t1, $t0, 0
# %op2 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -77
# br i1 %op2, label %label_end1, label %label_error1
	ld.b $t0, $fp, -77
	bnez $t0, .main_label_end1
	b .main_label_error1
.main_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .main_label_end1
.main_label_end1:
# %op3 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -85
# store i32 11, i32* %op3
	addi.w $t1, $zero, 11
	ld.d $t0, $fp, -85
	st.w $t1, $t0, 0
# %op4 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -86
# br i1 %op4, label %label_end2, label %label_error2
	ld.b $t0, $fp, -86
	bnez $t0, .main_label_end2
	b .main_label_error2
.main_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .main_label_end2
.main_label_end2:
# %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -94
# store i32 22, i32* %op5
	addi.w $t1, $zero, 22
	ld.d $t0, $fp, -94
	st.w $t1, $t0, 0
# %op6 = icmp sge i32 9, 0
	addi.w $t1, $zero, 9
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -95
# br i1 %op6, label %label_end3, label %label_error3
	ld.b $t0, $fp, -95
	bnez $t0, .main_label_end3
	b .main_label_error3
.main_label_error3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end3
	b .main_label_end3
.main_label_end3:
# %op7 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 36
	st.d $t0, $fp, -103
# store i32 33, i32* %op7
	addi.w $t1, $zero, 33
	ld.d $t0, $fp, -103
	st.w $t1, $t0, 0
# %op8 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -104
# br i1 %op8, label %label_end4, label %label_error4
	ld.b $t0, $fp, -104
	bnez $t0, .main_label_end4
	b .main_label_error4
.main_label_error4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end4
	b .main_label_end4
.main_label_end4:
# %op9 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -112
# %op10 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -116
# call void @output(i32 %op10)
	ld.w $a0, $fp, -116
	bl output
# %op11 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -117
# br i1 %op11, label %label_end5, label %label_error5
	ld.b $t0, $fp, -117
	bnez $t0, .main_label_end5
	b .main_label_error5
.main_label_error5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end5
	b .main_label_end5
.main_label_end5:
# %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -125
# %op13 = load i32, i32* %op12
	ld.d $t0, $fp, -125
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -129
# call void @output(i32 %op13)
	ld.w $a0, $fp, -129
	bl output
# %op14 = icmp sge i32 9, 0
	addi.w $t1, $zero, 9
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -130
# br i1 %op14, label %label_end6, label %label_error6
	ld.b $t0, $fp, -130
	bnez $t0, .main_label_end6
	b .main_label_error6
.main_label_error6:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end6
	b .main_label_end6
.main_label_end6:
# %op15 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 36
	st.d $t0, $fp, -138
# %op16 = load i32, i32* %op15
	ld.d $t0, $fp, -138
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -142
# call void @output(i32 %op16)
	ld.w $a0, $fp, -142
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
