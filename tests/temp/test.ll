; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/mem2reg/mem2reg-1.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = call i32 @input()
  br label %label1
label1:                                                ; preds = %label_entry, %label5
  %op2 = phi i32 [ 0, %label_entry ], [ %op31, %label5 ]
  %op3 = phi i32 [ 0, %label_entry ], [ %op30, %label5 ]
  %op4 = icmp slt i32 %op2, %op0
  br i1 %op4, label %label5, label %label32
label5:                                                ; preds = %label1
  %op6 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
  %op7 = fmul float %op6, 0x4002aa9940000000
  %op8 = fmul float %op7, 0x4011781d80000000
  %op9 = fmul float %op8, 0x401962ac40000000
  %op10 = fptosi float %op9 to i32
  %op11 = mul i32 %op10, %op10
  %op12 = mul i32 %op11, %op10
  %op13 = mul i32 %op12, %op10
  %op14 = mul i32 %op13, %op10
  %op15 = mul i32 %op14, %op10
  %op16 = mul i32 %op15, %op15
  %op17 = mul i32 %op16, %op15
  %op18 = mul i32 %op17, %op15
  %op19 = mul i32 %op18, %op15
  %op20 = mul i32 %op19, %op15
  %op21 = mul i32 %op20, %op20
  %op22 = mul i32 %op21, %op20
  %op23 = mul i32 %op22, %op20
  %op24 = mul i32 %op23, %op20
  %op25 = mul i32 %op24, %op20
  %op26 = mul i32 %op25, %op25
  %op27 = mul i32 %op26, %op25
  %op28 = mul i32 %op27, %op25
  %op29 = mul i32 %op28, %op25
  %op30 = mul i32 %op29, %op25
  %op31 = add i32 %op2, 1
  br label %label1
label32:                                                ; preds = %label1
  call void @output(i32 %op3)
  ret void
}
