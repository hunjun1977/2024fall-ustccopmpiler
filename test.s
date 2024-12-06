	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op2 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -65
# br i1 %op2, label %label_end1, label %label_error1
	ld.b $t0, $fp, -65
	bnez $t0, .main_label_end1
	b .main_label_error1
.main_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .main_label_end1
.main_label_end1:
# %op4 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -66
# br i1 %op4, label %label_end2, label %label_error2
	ld.b $t0, $fp, -66
	bnez $t0, .main_label_end2
	b .main_label_error2
.main_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .main_label_end2
.main_label_end2:
# %op6 = icmp sge i32 9, 0
	addi.w $t1, $zero, 9
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -67
# br i1 %op6, label %label_end3, label %label_error3
	ld.b $t0, $fp, -67
	bnez $t0, .main_label_end3
	b .main_label_error3
.main_label_error3:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end3
	b .main_label_end3
.main_label_end3:
# %op8 = icmp sge i32 0, 0
	addi.w $t1, $zero, 0
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -68
# br i1 %op8, label %label_end4, label %label_error4
	ld.b $t0, $fp, -68
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
	st.d $t0, $fp, -76
# %op10 = load i32, i32* %op9
	ld.d $t0, $fp, -76
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -80
# call void @output(i32 %op10)
	ld.w $a0, $fp, -80
	bl output
# %op11 = icmp sge i32 4, 0
	addi.w $t1, $zero, 4
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -81
# br i1 %op11, label %label_end5, label %label_error5
	ld.b $t0, $fp, -81
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
	st.d $t0, $fp, -89
# %op13 = load i32, i32* %op12
	ld.d $t0, $fp, -89
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -93
# call void @output(i32 %op13)
	ld.w $a0, $fp, -93
	bl output
# %op14 = icmp sge i32 9, 0
	addi.w $t1, $zero, 9
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -94
# br i1 %op14, label %label_end6, label %label_error6
	ld.b $t0, $fp, -94
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
	st.d $t0, $fp, -102
# %op16 = load i32, i32* %op15
	ld.d $t0, $fp, -102
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -106
# call void @output(i32 %op16)
	ld.w $a0, $fp, -106
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
