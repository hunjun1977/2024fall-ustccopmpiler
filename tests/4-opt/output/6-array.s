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
# %op1 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -65
# br i1 %op1, label %label_end1, label %label_error1
	ld.b $t0, $fp, -65
	bnez $t0, .main_label_end1
	b .main_label_error1
.main_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .main_label_end1
.main_label_end1:
# %op2 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -73
# store i32 11, i32* %op2
	addi.w $t1, $zero, 11
	ld.d $t0, $fp, -73
	st.w $t1, $t0, 0
# %op3 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -74
# br i1 %op3, label %label_end2, label %label_error2
	ld.b $t0, $fp, -74
	bnez $t0, .main_label_end2
	b .main_label_error2
.main_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .main_label_end2
.main_label_end2:
# %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -82
# store i32 22, i32* %op4
	addi.w $t1, $zero, 22
	ld.d $t0, $fp, -82
	st.w $t1, $t0, 0
# %op5 = icmp sge i32 9, 0
	addi.w $t1, $zero, 9
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -83
# br i1 %op5, label %label_end3, label %label_error3
	ld.b $t0, $fp, -83
	bnez $t0, .main_label_end3
	b .main_label_error3
.main_label_error3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end3
	b .main_label_end3
.main_label_end3:
# %op6 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 36
	st.d $t0, $fp, -91
# store i32 33, i32* %op6
	addi.w $t1, $zero, 33
	ld.d $t0, $fp, -91
	st.w $t1, $t0, 0
# %op7 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -92
# br i1 %op7, label %label_end4, label %label_error4
	ld.b $t0, $fp, -92
	bnez $t0, .main_label_end4
	b .main_label_error4
.main_label_error4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end4
	b .main_label_end4
.main_label_end4:
# %op8 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -100
# %op9 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -104
# call void @output(i32 %op9)
	ld.w $a0, $fp, -104
	bl output
# %op10 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -105
# br i1 %op10, label %label_end5, label %label_error5
	ld.b $t0, $fp, -105
	bnez $t0, .main_label_end5
	b .main_label_error5
.main_label_error5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end5
	b .main_label_end5
.main_label_end5:
# %op11 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 16
	st.d $t0, $fp, -113
# %op12 = load i32, i32* %op11
	ld.d $t0, $fp, -113
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -117
# call void @output(i32 %op12)
	ld.w $a0, $fp, -117
	bl output
# %op13 = icmp sge i32 9, 0
	addi.w $t1, $zero, 9
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -118
# br i1 %op13, label %label_end6, label %label_error6
	ld.b $t0, $fp, -118
	bnez $t0, .main_label_end6
	b .main_label_error6
.main_label_error6:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end6
	b .main_label_end6
.main_label_end6:
# %op14 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 36
	st.d $t0, $fp, -126
# %op15 = load i32, i32* %op14
	ld.d $t0, $fp, -126
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -130
# call void @output(i32 %op15)
	ld.w $a0, $fp, -130
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
