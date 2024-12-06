	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# br label %label1
	addi.w $a0, $zero, 1
	st.w $a0, $fp, -20
	b .main_label1
.main_label1:
# %op9 = phi i32 [ 1, %label_entry ], [ %op6, %label4 ]
# %op3 = icmp slt i32 %op9, 999999999
	ld.w $t1, $fp, -20
	lu12i.w $t2, 244140
	ori $t2, $t2, 2559
	slt $t0, $t1, $t2
	st.b $t0, $fp, -21
# br i1 %op3, label %label4, label %label7
	ld.b $t0, $fp, -21
	bnez $t0, .main_label4
	b .main_label7
.main_label4:
# %op6 = add i32 %op9, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -25
# br label %label1
	ld.w $a0, $fp, -25
	st.w $a0, $fp, -20
	b .main_label1
.main_label7:
# ret i32 %op9
	ld.w $a0, $fp, -20
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.w $t0, $zero, 1
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -20
	ld.w $t0, $fp, -25
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -20
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
