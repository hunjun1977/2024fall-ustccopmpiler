	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# %op2 = alloca i32
	addi.d $t0, $fp, -52
	st.d $t0, $fp, -48
# store i32 11, i32* %op0
	addi.w $t1, $zero, 11
	ld.d $t0, $fp, -24
	st.w $t1, $t0, 0
# store i32 22, i32* %op1
	addi.w $t1, $zero, 22
	ld.d $t0, $fp, -36
	st.w $t1, $t0, 0
# store i32 33, i32* %op2
	addi.w $t1, $zero, 33
	ld.d $t0, $fp, -48
	st.w $t1, $t0, 0
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -56
# %op4 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -60
# %op5 = icmp sgt i32 %op3, %op4
	ld.w $t1, $fp, -56
	ld.w $t2, $fp, -60
	slt $t0, $t2, $t1
	st.b $t0, $fp, -61
# br i1 %op5, label %label_turnBB1, label %label_falseBB1
	ld.b $t0, $fp, -61
	bnez $t0, .main_label_turnBB1
	b .main_label_falseBB1
.main_label_turnBB1:
# %op6 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -65
# %op7 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -69
# %op8 = icmp sgt i32 %op6, %op7
	ld.w $t1, $fp, -65
	ld.w $t2, $fp, -69
	slt $t0, $t2, $t1
	st.b $t0, $fp, -70
# br i1 %op8, label %label_turnBB3, label %label_falseBB3
	ld.b $t0, $fp, -70
	bnez $t0, .main_label_turnBB3
	b .main_label_falseBB3
.main_label_falseBB1:
# %op9 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -74
# %op10 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -78
# %op11 = icmp slt i32 %op9, %op10
	ld.w $t1, $fp, -74
	ld.w $t2, $fp, -78
	slt $t0, $t1, $t2
	st.b $t0, $fp, -79
# br i1 %op11, label %label_turnBB2, label %label_falseBB2
	ld.b $t0, $fp, -79
	bnez $t0, .main_label_turnBB2
	b .main_label_falseBB2
.main_label_nextBB1:
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_turnBB2:
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -83
# call void @output(i32 %op12)
	ld.w $a0, $fp, -83
	bl output
# br label %label_nextBB2
	b .main_label_nextBB2
.main_label_falseBB2:
# %op13 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -87
# call void @output(i32 %op13)
	ld.w $a0, $fp, -87
	bl output
# br label %label_nextBB2
	b .main_label_nextBB2
.main_label_nextBB2:
# br label %label_nextBB1
	b .main_label_nextBB1
.main_label_turnBB3:
# %op14 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -91
# call void @output(i32 %op14)
	ld.w $a0, $fp, -91
	bl output
# br label %label_nextBB3
	b .main_label_nextBB3
.main_label_falseBB3:
# %op15 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -95
# call void @output(i32 %op15)
	ld.w $a0, $fp, -95
	bl output
# br label %label_nextBB3
	b .main_label_nextBB3
.main_label_nextBB3:
# br label %label_nextBB1
	b .main_label_nextBB1
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
