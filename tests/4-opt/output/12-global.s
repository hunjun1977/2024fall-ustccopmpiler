# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl seed
	.type seed, @object
	.size seed, 4
seed:
	.space 4
	.text
	.globl randomLCG
	.type randomLCG, @function
randomLCG:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randomLCG_label_entry:
# %op0 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -20
# %op1 = mul i32 %op0, 1103515245
	ld.w $t0, $fp, -20
	lu12i.w $t1, 269412
	ori $t1, $t1, 3693
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -24
# %op2 = add i32 %op1, 12345
	ld.w $t0, $fp, -24
	lu12i.w $t1, 3
	ori $t1, $t1, 57
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -28
# store i32 %op2, i32* @seed
	ld.w $t1, $fp, -28
	la.local $t0, seed
	st.w $t1, $t0, 0
# %op3 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -32
# ret i32 %op3
	ld.w $a0, $fp, -32
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl randBin
	.type randBin, @function
randBin:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randBin_label_entry:
# %op0 = call i32 @randomLCG()
	bl randomLCG
	st.w $a0, $fp, -20
# %op1 = icmp sgt i32 %op0, 0
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 0
	slt $t0, $t2, $t1
	st.b $t0, $fp, -21
# br i1 %op1, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -21
	bnez $t0, .randBin_label_turnBB1
	b .randBin_label_falseBB1
.randBin_label_turnBB1:
# ret i32 1
	addi.w $a0, $zero, 1
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.randBin_label_falseBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl returnToZeroSteps
	.type returnToZeroSteps, @function
returnToZeroSteps:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
.returnToZeroSteps_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# store i32 0, i32* %op0
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -36
	st.w $t1, $t0, 0
# br label %label2
	b .returnToZeroSteps_label2
.returnToZeroSteps_label2:
# %op3 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -44
# %op4 = icmp slt i32 %op3, 20
	ld.w $t1, $fp, -44
	addi.w $t2, $zero, 20
	slt $t0, $t1, $t2
	st.b $t0, $fp, -45
# br i1 %op4, label %label5, label %label8
	ld.b $t0, $fp, -45
	bnez $t0, .returnToZeroSteps_label5
	b .returnToZeroSteps_label8
.returnToZeroSteps_label5:
# %op6 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -49
# %op7 = icmp ne i32 %op6, 0
	ld.w $t1, $fp, -49
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -50
# br i1 %op7, label %label_turnBB2, label %label_falseBB2
	ld.b $t0, $fp, -50
	bnez $t0, .returnToZeroSteps_label_turnBB2
	b .returnToZeroSteps_label_falseBB2
.returnToZeroSteps_label8:
# ret i32 20
	addi.w $a0, $zero, 20
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.returnToZeroSteps_label_turnBB2:
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -54
# %op10 = add i32 %op9, 1
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -58
# store i32 %op10, i32* %op0
	ld.w $t1, $fp, -58
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# br label %label_nextBB2
	b .returnToZeroSteps_label_nextBB2
.returnToZeroSteps_label_falseBB2:
# %op11 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -62
# %op12 = sub i32 %op11, 1
	ld.w $t0, $fp, -62
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -66
# store i32 %op12, i32* %op0
	ld.w $t1, $fp, -66
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# br label %label_nextBB2
	b .returnToZeroSteps_label_nextBB2
.returnToZeroSteps_label_nextBB2:
# %op13 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -70
# %op14 = add i32 %op13, 1
	ld.w $t0, $fp, -70
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -74
# store i32 %op14, i32* %op1
	ld.w $t1, $fp, -74
	ld.d $t0, $fp, -36
	st.w $t1, $t0, 0
# %op15 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -78
# %op16 = icmp eq i32 %op15, 0
	ld.w $t1, $fp, -78
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -79
# br i1 %op16, label %label_turnBB3, label %label_nextBB3
	ld.b $t0, $fp, -79
	bnez $t0, .returnToZeroSteps_label_turnBB3
	b .returnToZeroSteps_label_nextBB3
.returnToZeroSteps_label_turnBB3:
# %op17 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -83
# ret i32 %op17
	ld.w $a0, $fp, -83
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.returnToZeroSteps_label_nextBB3:
# br label %label2
	b .returnToZeroSteps_label2
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
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
# store i32 0, i32* %op0
	addi.w $t1, $zero, 0
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# store i32 3407, i32* @seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	la.local $t0, seed
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label1:
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -32
# %op3 = icmp slt i32 %op2, 20
	ld.w $t1, $fp, -32
	addi.w $t2, $zero, 20
	slt $t0, $t1, $t2
	st.b $t0, $fp, -33
# br i1 %op3, label %label4, label %label8
	ld.b $t0, $fp, -33
	bnez $t0, .main_label4
	b .main_label8
.main_label4:
# %op5 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	st.w $a0, $fp, -37
# call void @output(i32 %op5)
	ld.w $a0, $fp, -37
	bl output
# %op6 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -41
# %op7 = add i32 %op6, 1
	ld.w $t0, $fp, -41
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -45
# store i32 %op7, i32* %op0
	ld.w $t1, $fp, -45
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label8:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
