	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = icmp sgt i32 11, 22
	addi.w $t1, $zero, 11
	addi.w $t2, $zero, 22
	slt $t0, $t2, $t1
	st.b $t0, $fp, -17
# br i1 %op0, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -17
	bnez $t0, .main_label_turnBB1
	b .main_label_falseBB1
.main_label_turnBB1:
# %op1 = icmp sgt i32 11, 33
	addi.w $t1, $zero, 11
	addi.w $t2, $zero, 33
	slt $t0, $t2, $t1
	st.b $t0, $fp, -18
# br i1 %op1, label %label_turnBB3, label %label_falseBB3
	ld.b $t0, $fp, -18
	bnez $t0, .main_label_turnBB3
	b .main_label_falseBB3
.main_label_falseBB1:
# %op2 = icmp slt i32 33, 22
	addi.w $t1, $zero, 33
	addi.w $t2, $zero, 22
	slt $t0, $t1, $t2
	st.b $t0, $fp, -19
# br i1 %op2, label %label_turnBB2, label %label_falseBB2
	ld.b $t0, $fp, -19
	bnez $t0, .main_label_turnBB2
	b .main_label_falseBB2
.main_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_turnBB2:
# call void @output(i32 22)
	addi.w $a0, $zero, 22
	bl output
# br label %label_nextBB2
	b .main_label_nextBB2
.main_label_falseBB2:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label_nextBB2
	b .main_label_nextBB2
.main_label_nextBB2:
# br label %label_nextBB1
	b .main_label_nextBB1
.main_label_turnBB3:
# call void @output(i32 11)
	addi.w $a0, $zero, 11
	bl output
# br label %label_nextBB3
	b .main_label_nextBB3
.main_label_falseBB3:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label_nextBB3
	b .main_label_nextBB3
.main_label_nextBB3:
# br label %label_nextBB1
	b .main_label_nextBB1
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
