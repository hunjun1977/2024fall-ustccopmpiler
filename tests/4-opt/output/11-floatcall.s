	.text
	.globl mod
	.type mod, @function
mod:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	fst.s $fa0, $fp, -20
	fst.s $fa1, $fp, -24
.mod_label_entry:
# %op2 = fdiv float %arg0, %arg1
	fld.s $ft0, $fp, -20
	fld.s $ft1, $fp, -24
	fdiv.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -28
# %op3 = fptosi float %op2 to i32
	fld.s $ft1, $fp, -28
	ftint.w.s $ft0, $ft1
	movfr2gr.s $t0,$ft0
	st.w $t0, $fp, -32
# %op4 = sitofp i32 %op3 to float
	ld.w $t0, $fp, -32
	movgr2fr.w $ft0,$t0
	ffint.s.w $ft1, $ft0
	fst.s $ft1, $fp, -36
# %op5 = fmul float %op4, %arg1
	fld.s $ft0, $fp, -36
	fld.s $ft1, $fp, -24
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -40
# %op6 = fsub float %arg0, %op5
	fld.s $ft0, $fp, -20
	fld.s $ft1, $fp, -40
	fsub.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -44
# ret float %op6
	fld.s $fa0, $fp, -44
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
# %op0 = call float @mod(float 0x4026666660000000, float 0x40019999a0000000)
	lu12i.w $t8, 267059
	ori $t8, $t8, 819
	movgr2fr.w $fa0, $t8
	lu12i.w $t8, 262348
	ori $t8, $t8, 3277
	movgr2fr.w $fa1, $t8
	bl mod
	fst.s $fa0, $fp, -20
# call void @outputFloat(float %op0)
	fld.s $fa0, $fp, -20
	bl outputFloat
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
