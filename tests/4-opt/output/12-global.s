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
	addi.d $sp, $sp, -48
.returnToZeroSteps_label_entry:
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	b .returnToZeroSteps_label0
.returnToZeroSteps_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op11, %label_nextBB3 ]
# %op2 = phi i32 [ 0, %label_entry ], [ %op10, %label_nextBB3 ]
# %op3 = icmp slt i32 %op1, 20
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 20
	slt $t0, $t1, $t2
	st.b $t0, $fp, -25
# br i1 %op3, label %label4, label %label7
	ld.b $t0, $fp, -25
	bnez $t0, .returnToZeroSteps_label4
	b .returnToZeroSteps_label7
.returnToZeroSteps_label4:
# %op5 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -29
# %op6 = icmp ne i32 %op5, 0
	ld.w $t1, $fp, -29
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -30
# br i1 %op6, label %label_turnBB2, label %label_falseBB2
	ld.b $t0, $fp, -30
	bnez $t0, .returnToZeroSteps_label_turnBB2
	b .returnToZeroSteps_label_falseBB2
.returnToZeroSteps_label7:
# ret i32 20
	addi.w $a0, $zero, 20
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.returnToZeroSteps_label_turnBB2:
# %op8 = add i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# br label %label_nextBB2
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -42
	b .returnToZeroSteps_label_nextBB2
.returnToZeroSteps_label_falseBB2:
# %op9 = sub i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -38
# br label %label_nextBB2
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -42
	b .returnToZeroSteps_label_nextBB2
.returnToZeroSteps_label_nextBB2:
# %op10 = phi i32 [ %op8, %label_turnBB2 ], [ %op9, %label_falseBB2 ]
# %op11 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -46
# %op12 = icmp eq i32 %op10, 0
	ld.w $t1, $fp, -42
	addi.w $t2, $zero, 0
	xor $t0, $t1, $t2
	sltu $t0, $zero, $t0
	xori $t0, $t0, 1
	st.b $t0, $fp, -47
# br i1 %op12, label %label_turnBB3, label %label_nextBB3
	ld.b $t0, $fp, -47
	bnez $t0, .returnToZeroSteps_label_turnBB3
	b .returnToZeroSteps_label_nextBB3
.returnToZeroSteps_label_turnBB3:
# ret i32 %op11
	ld.w $a0, $fp, -46
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.returnToZeroSteps_label_nextBB3:
# br label %label0
	ld.w $a0, $fp, -46
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -42
	st.w $a0, $fp, -24
	b .returnToZeroSteps_label0
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -20
	ld.w $t0, $fp, -46
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -20
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -24
	ld.w $t0, $fp, -42
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -24
	ld.w $t0, $fp, -34
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -42
	ld.w $t0, $fp, -38
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -42
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
# store i32 3407, i32* @seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	la.local $t0, seed
	st.w $t1, $t0, 0
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
# %op2 = icmp slt i32 %op1, 20
	ld.w $t1, $fp, -20
	addi.w $t2, $zero, 20
	slt $t0, $t1, $t2
	st.b $t0, $fp, -21
# br i1 %op2, label %label3, label %label6
	ld.b $t0, $fp, -21
	bnez $t0, .main_label3
	b .main_label6
.main_label3:
# %op4 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
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
