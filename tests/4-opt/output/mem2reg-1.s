	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# br label %label8
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label8
.main_label8:
# %op66 = phi i32 [ 0, %label_entry ], [ %op63, %label12 ]
# %op67 = phi i32 [ 0, %label_entry ], [ %op61, %label12 ]
# %op11 = icmp slt i32 %op66, %op7
	ld.w $t1, $fp, -24
	ld.w $t2, $fp, -20
	slt $t0, $t1, $t2
	st.b $t0, $fp, -29
# br i1 %op11, label %label12, label %label64
	ld.b $t0, $fp, -29
	bnez $t0, .main_label12
	b .main_label64
.main_label12:
# %op13 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
	lu12i.w $t8, 260576
	ori $t8, $t8, 1552
	movgr2fr.w $ft0, $t8
	lu12i.w $t8, 265080
	ori $t8, $t8, 849
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -33
# %op14 = fmul float %op13, 0x4002aa9940000000
	fld.s $ft0, $fp, -33
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -37
# %op15 = fmul float %op14, 0x4011781d80000000
	fld.s $ft0, $fp, -37
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -41
# %op16 = fmul float %op15, 0x401962ac40000000
	fld.s $ft0, $fp, -41
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -45
# %op17 = fptosi float %op16 to i32
	fld.s $ft1, $fp, -45
	ftint.w.s $ft0, $ft1
	movfr2gr.s $t0,$ft0
	st.w $t0, $fp, -49
# %op20 = mul i32 %op17, %op17
	ld.w $t0, $fp, -49
	ld.w $t1, $fp, -49
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -53
# %op22 = mul i32 %op20, %op17
	ld.w $t0, $fp, -53
	ld.w $t1, $fp, -49
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -57
# %op24 = mul i32 %op22, %op17
	ld.w $t0, $fp, -57
	ld.w $t1, $fp, -49
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -61
# %op26 = mul i32 %op24, %op17
	ld.w $t0, $fp, -61
	ld.w $t1, $fp, -49
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -65
# %op28 = mul i32 %op26, %op17
	ld.w $t0, $fp, -65
	ld.w $t1, $fp, -49
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -69
# %op31 = mul i32 %op28, %op28
	ld.w $t0, $fp, -69
	ld.w $t1, $fp, -69
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -73
# %op33 = mul i32 %op31, %op28
	ld.w $t0, $fp, -73
	ld.w $t1, $fp, -69
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -77
# %op35 = mul i32 %op33, %op28
	ld.w $t0, $fp, -77
	ld.w $t1, $fp, -69
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -81
# %op37 = mul i32 %op35, %op28
	ld.w $t0, $fp, -81
	ld.w $t1, $fp, -69
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -85
# %op39 = mul i32 %op37, %op28
	ld.w $t0, $fp, -85
	ld.w $t1, $fp, -69
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -89
# %op42 = mul i32 %op39, %op39
	ld.w $t0, $fp, -89
	ld.w $t1, $fp, -89
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -93
# %op44 = mul i32 %op42, %op39
	ld.w $t0, $fp, -93
	ld.w $t1, $fp, -89
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -97
# %op46 = mul i32 %op44, %op39
	ld.w $t0, $fp, -97
	ld.w $t1, $fp, -89
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -101
# %op48 = mul i32 %op46, %op39
	ld.w $t0, $fp, -101
	ld.w $t1, $fp, -89
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -105
# %op50 = mul i32 %op48, %op39
	ld.w $t0, $fp, -105
	ld.w $t1, $fp, -89
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -109
# %op53 = mul i32 %op50, %op50
	ld.w $t0, $fp, -109
	ld.w $t1, $fp, -109
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -113
# %op55 = mul i32 %op53, %op50
	ld.w $t0, $fp, -113
	ld.w $t1, $fp, -109
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -117
# %op57 = mul i32 %op55, %op50
	ld.w $t0, $fp, -117
	ld.w $t1, $fp, -109
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -121
# %op59 = mul i32 %op57, %op50
	ld.w $t0, $fp, -121
	ld.w $t1, $fp, -109
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -125
# %op61 = mul i32 %op59, %op50
	ld.w $t0, $fp, -125
	ld.w $t1, $fp, -109
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -129
# %op63 = add i32 %op66, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -133
# br label %label8
	ld.w $a0, $fp, -133
	st.w $a0, $fp, -24
	ld.w $a0, $fp, -129
	st.w $a0, $fp, -28
	b .main_label8
.main_label64:
# call void @output(i32 %op67)
	ld.w $a0, $fp, -28
	bl output
# ret void
	add.w $a0,$zero,$zero
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -24
	ld.w $t0, $fp, -133
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -24
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -28
	ld.w $t0, $fp, -129
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -28
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
