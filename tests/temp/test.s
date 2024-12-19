	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# store i32 1, i32* %op0
	addi.w $t1, $zero, 1
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label1:
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -32
# %op3 = icmp slt i32 %op2, 999999999
	ld.w $t1, $fp, -32
	lu12i.w $t2, 244140
	ori $t2, $t2, 2559
	slt $t0, $t1, $t2
	st.b $t0, $fp, -33
# br i1 %op3, label %label4, label %label7
	ld.b $t0, $fp, -33
	bnez $t0, .main_label4
	b .main_label7
.main_label4:
# %op5 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -37
# %op6 = add i32 %op5, 1
	ld.w $t0, $fp, -37
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -41
# store i32 %op6, i32* %op0
	ld.w $t1, $fp, -41
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label7:
# %op8 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -45
# ret i32 %op8
	ld.w $a0, $fp, -45
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
