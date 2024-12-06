	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
.fibonacci_label_entry:
# %op1 = alloca i32
	addi.d $t0, $fp, -32
	st.d $t0, $fp, -28
# store i32 %arg0, i32* %op1
	ld.w $t1, $fp, -20
	ld.d $t0, $fp, -28
	st.w $t1, $t0, 0
# %op2 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -36
# %op3 = icmp eq i32 %op2, 0
	ld.w $t1, $fp, -36
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -37
# br i1 %op3, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -37
	bnez $t0, .fibonacci_label_turnBB1
	b .fibonacci_label_falseBB1
.fibonacci_label_turnBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_falseBB1:
# %op4 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -41
# %op5 = icmp eq i32 %op4, 1
	ld.w $t1, $fp, -41
	addi.w $t2, $zero, 1
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -42
# br i1 %op5, label %label_turnBB2, label %label_falseBB2
	ld.b $t0, $fp, -42
	bnez $t0, .fibonacci_label_turnBB2
	b .fibonacci_label_falseBB2
.fibonacci_label_turnBB2:
# ret i32 1
	addi.w $a0, $zero, 1
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.fibonacci_label_falseBB2:
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -46
# %op7 = sub i32 %op6, 1
	ld.w $t0, $fp, -46
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -50
# %op8 = call i32 @fibonacci(i32 %op7)
	ld.w $a0, $fp, -50
	bl fibonacci
	st.w $a0, $fp, -54
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -58
# %op10 = sub i32 %op9, 2
	ld.w $t0, $fp, -58
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -62
# %op11 = call i32 @fibonacci(i32 %op10)
	ld.w $a0, $fp, -62
	bl fibonacci
	st.w $a0, $fp, -66
# %op12 = add i32 %op8, %op11
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -66
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# ret i32 %op12
	ld.w $a0, $fp, -70
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
	addi.d $sp, $sp, -80
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
# br i1 %op5, label %label6, label %label11
	ld.b $t0, $fp, -49
	bnez $t0, .main_label6
	b .main_label11
.main_label6:
# %op7 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -53
# %op8 = call i32 @fibonacci(i32 %op7)
	ld.w $a0, $fp, -53
	bl fibonacci
	st.w $a0, $fp, -57
# call void @output(i32 %op8)
	ld.w $a0, $fp, -57
	bl output
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -61
# %op10 = add i32 %op9, 1
	ld.w $t0, $fp, -61
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -65
# store i32 %op10, i32* %op1
	ld.w $t1, $fp, -65
	ld.d $t0, $fp, -36
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label11:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
