	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
.fibonacci_label_entry:
# %op1 = icmp eq i32 %arg0, 0
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -21
# br i1 %op1, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -21
	bnez $t0, .fibonacci_label_turnBB1
	b .fibonacci_label_falseBB1
.fibonacci_label_turnBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_falseBB1:
# %op2 = icmp eq i32 %arg0, 1
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 1
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -22
# br i1 %op2, label %label_turnBB2, label %label_falseBB2
	ld.b $t0, $fp, -22
	bnez $t0, .fibonacci_label_turnBB2
	b .fibonacci_label_falseBB2
.fibonacci_label_turnBB2:
# ret i32 1
	addi.w $a0, $zero, 1
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_falseBB2:
# %op3 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -26
# %op4 = call i32 @fibonacci(i32 %op3)
	ld.w $a0, $fp, -26
	bl fibonacci
	st.w $a0, $fp, -30
# %op5 = sub i32 %arg0, 2
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# %op6 = call i32 @fibonacci(i32 %op5)
	ld.w $a0, $fp, -34
	bl fibonacci
	st.w $a0, $fp, -38
# %op7 = add i32 %op4, %op6
	ld.w $t0, $fp, -30
	ld.w $t1, $fp, -38
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -42
# ret i32 %op7
	ld.w $a0, $fp, -42
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
# %op2 = icmp slt i32 %op1, 10
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 10
	slt $t0, $t1, $t2
	st.b $t0, $fp, -21
# br i1 %op2, label %label3, label %label6
	ld.b $t0, $fp, -21
	bnez $t0, .main_label3
	b .main_label6
.main_label3:
# %op4 = call i32 @fibonacci(i32 %op1)
	ld.w $a0, $fp, -20
	bl fibonacci
	st.w $a0, $fp, -25
# call void @output(i32 %op4)
	ld.w $a0, $fp, -25
	bl output
# %op5 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -29
# br label %label0
	ld.w $a0, $fp, -29
	st.w $a0, $fp, -20
	b .main_label0
.main_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -20
	ld.w $t0, $fp, -29
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -20
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
