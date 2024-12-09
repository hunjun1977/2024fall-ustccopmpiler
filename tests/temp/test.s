	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
.store_label_entry:
# %op3 = icmp sge i32 %arg1, 0
	ld.w $t1, $fp, -28
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -33
# br i1 %op3, label %label_end1, label %label_error1
	ld.b $t0, $fp, -33
	bnez $t0, .store_label_end1
	b .store_label_error1
.store_label_error1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end1
	b .store_label_end1
.store_label_end1:
# %op4 = getelementptr i32, i32* %arg0, i32 %arg1
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -28
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -41
# store i32 %arg2, i32* %op4
	ld.w $t1, $fp, -32
	ld.d $t0, $fp, -41
	st.w $t1, $t0, 0
# ret i32 %arg2
	ld.w $a0, $fp, -32
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
	addi.d $sp, $sp, -128
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# br label %label1
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -68
	b .main_label1
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op8, %label4 ]
# %op3 = icmp slt i32 %op2, 10
	ld.w $t1, $fp, -68
	addi.w $t2, $zero, 10
	slt $t0, $t1, $t2
	st.b $t0, $fp, -69
# br i1 %op3, label %label4, label %label9
	ld.b $t0, $fp, -69
	bnez $t0, .main_label4
	b .main_label9
.main_label4:
# %op5 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	addi.d $t0, $t0, 0
	st.d $t0, $fp, -77
# %op6 = mul i32 %op8, 2
	ld.w $t0, $fp, -89
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -81
# %op7 = call i32 @store(i32* %op5, i32 %op8, i32 %op6)
	ld.d $a0, $fp, -77
	ld.w $a1, $fp, -89
	ld.w $a2, $fp, -81
	bl store
	st.w $a0, $fp, -85
# %op8 = add i32 %op8, 1
	ld.w $t0, $fp, -89
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -89
# br label %label1
	ld.w $a0, $fp, -89
	st.w $a0, $fp, -68
	b .main_label1
.main_label9:
# br label %label10
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -93
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -97
	b .main_label10
.main_label10:
# %op11 = phi i32 [ 0, %label9 ], [ %op19, %label_end2 ]
# %op12 = phi i32 [ 0, %label9 ], [ %op20, %label_end2 ]
# %op13 = icmp slt i32 %op12, 10
	ld.w $t1, $fp, -97
	addi.w $t2, $zero, 10
	slt $t0, $t1, $t2
	st.b $t0, $fp, -98
# br i1 %op13, label %label14, label %label16
	ld.b $t0, $fp, -98
	bnez $t0, .main_label14
	b .main_label16
.main_label14:
# %op15 = icmp sge i32 %op12, 0
	ld.w $t1, $fp, -97
	addi.w $t2, $zero, 0
	slt $t0, $t1, $t2
	xori $t0, $t0, 1
	st.b $t0, $fp, -99
# br i1 %op15, label %label_end2, label %label_error2
	ld.b $t0, $fp, -99
	bnez $t0, .main_label_end2
	b .main_label_error2
.main_label16:
# call void @output(i32 %op11)
	ld.w $a0, $fp, -93
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
.main_label_error2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label_end2
	b .main_label_end2
.main_label_end2:
# %op17 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op12
	ld.d $t0, $fp, -24
	addi.d $t0, $t0, 0
	ld.w $t1, $fp, -97
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -107
# %op18 = load i32, i32* %op17
	ld.d $t0, $fp, -107
	ld.w $t1, $t0, 0
	st.w $t1, $fp, -111
# %op19 = add i32 %op11, %op18
	ld.w $t0, $fp, -93
	ld.w $t1, $fp, -111
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -115
# %op20 = add i32 %op20, 1
	ld.w $t0, $fp, -119
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -119
# br label %label10
	ld.w $a0, $fp, -115
	st.w $a0, $fp, -93
	ld.w $a0, $fp, -119
	st.w $a0, $fp, -97
	b .main_label10
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -68
	ld.w $t0, $fp, -89
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -68
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -93
	ld.w $t0, $fp, -115
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -93
	addi.w $t0, $zero, 0
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -97
	ld.w $t0, $fp, -119
	add.w $t2,$zero,$t1
	st.w $t2, $fp, -97
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
