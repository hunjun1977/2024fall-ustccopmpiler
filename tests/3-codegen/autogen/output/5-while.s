	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# store i32 10, i32* %op0
	addi.w $t1, $zero, 10
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -36
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label2:
# %op3 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -44
# %op4 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -48
# %op5 = icmp slt i32 %op3, %op4
	ld.w $t1, $fp, -44
	ld.w $t2, $fp, -48
	slt $t0, $t1, $t2
	st.b $t0, $fp, -49
# br i1 %op5, label %label6, label %label10
	ld.b $t0, $fp, -49
	bnez $t0, .main_label6
	b .main_label10
.main_label6:
# %op7 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -53
# call void @output(i32 %op7)
	ld.w $a0, $fp, -53
	bl output
# %op8 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -57
# %op9 = add i32 %op8, 1
	ld.w $t0, $fp, -57
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -61
# store i32 %op9, i32* %op1
	ld.w $t1, $fp, -61
	ld.d $t0, $fp, -36
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label10:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
