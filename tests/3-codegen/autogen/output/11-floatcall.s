	.text
	.globl mod
	.type mod, @function
mod:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
	fst.s $fa0, $fp, -20
	fst.s $fa1, $fp, -24
.mod_label_entry:
# %op2 = alloca float
	addi.d $t0, $fp, -36
	st.d $t0, $fp, -32
# %op3 = alloca float
	addi.d $t0, $fp, -48
	st.d $t0, $fp, -44
# store float %arg0, float* %op2
	fld.s $ft0, $fp, -20
	ld.d $t0, $fp, -32
	fst.s $ft0, $t0, 0
# store float %arg1, float* %op3
	fld.s $ft0, $fp, -24
	ld.d $t0, $fp, -44
	fst.s $ft0, $t0, 0
# %op4 = alloca i32
	addi.d $t0, $fp, -60
	st.d $t0, $fp, -56
# %op5 = load float, float* %op2
	ld.d $t0, $fp, -32
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -64
# %op6 = load float, float* %op3
	ld.d $t0, $fp, -44
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -68
# %op7 = fdiv float %op5, %op6
	fld.s $ft0, $fp, -64
	fld.s $ft1, $fp, -68
	fdiv.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -72
# %op8 = fptosi float %op7 to i32
	fld.s $ft1, $fp, -72
	ftint.w.s $ft0, $ft1
	movfr2gr.s $t0,$ft0
	st.w $t0, $fp, -76
# store i32 %op8, i32* %op4
	ld.w $t1, $fp, -76
	ld.d $t0, $fp, -56
	st.w $t1, $t0, 0
# %op9 = load float, float* %op2
	ld.d $t0, $fp, -32
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -80
# %op10 = load i32, i32* %op4
	ld.d $t0, $fp, -56
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -84
# %op11 = load float, float* %op3
	ld.d $t0, $fp, -44
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -88
# %op12 = sitofp i32 %op10 to float
	ld.w $t0, $fp, -84
	movgr2fr.w $ft0,$t0
	ffint.s.w $ft1, $ft0
	fst.s $ft1, $fp, -92
# %op13 = fmul float %op12, %op11
	fld.s $ft0, $fp, -92
	fld.s $ft1, $fp, -88
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -96
# %op14 = fsub float %op9, %op13
	fld.s $ft0, $fp, -80
	fld.s $ft1, $fp, -96
	fsub.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -100
# ret float %op14
	fld.s $fa0, $fp, -100
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca float
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca float
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# store float 0x4026666660000000, float* %op0
	lu12i.w $t8, 267059
	ori $t8, $t8, 819
	movgr2fr.w $ft0, $t8
	ld.d $t0, $fp, -24
	fst.s $ft0, $t0, 0
# store float 0x40019999a0000000, float* %op1
	lu12i.w $t8, 262348
	ori $t8, $t8, 3277
	movgr2fr.w $ft0, $t8
	ld.d $t0, $fp, -36
	fst.s $ft0, $t0, 0
# %op2 = load float, float* %op0
	ld.d $t0, $fp, -24
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -44
# %op3 = load float, float* %op1
	ld.d $t0, $fp, -36
	fld.s $ft0, $t0, 0
	fst.s $ft0, $fp, -48
# %op4 = call float @mod(float %op2, float %op3)
	fld.s $fa0, $fp, -44
	fld.s $fa1, $fp, -48
	bl mod
	fst.s $fa0, $fp, -52
# call void @outputFloat(float %op4)
	fld.s $fa0, $fp, -52
	bl outputFloat
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
