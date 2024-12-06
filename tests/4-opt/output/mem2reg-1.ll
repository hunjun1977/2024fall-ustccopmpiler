; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/mem2reg/mem2reg-1.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op7 = call i32 @input()
  br label %label8
label8:                                                ; preds = %label_entry, %label12
  %op66 = phi i32 [ 0, %label_entry ], [ %op63, %label12 ]
  %op67 = phi i32 [ 0, %label_entry ], [ %op61, %label12 ]
  %op11 = icmp slt i32 %op66, %op7
  br i1 %op11, label %label12, label %label64
label12:                                                ; preds = %label8
  %op13 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
  %op14 = fmul float %op13, 0x4002aa9940000000
  %op15 = fmul float %op14, 0x4011781d80000000
  %op16 = fmul float %op15, 0x401962ac40000000
  %op17 = fptosi float %op16 to i32
  %op20 = mul i32 %op17, %op17
  %op22 = mul i32 %op20, %op17
  %op24 = mul i32 %op22, %op17
  %op26 = mul i32 %op24, %op17
  %op28 = mul i32 %op26, %op17
  %op31 = mul i32 %op28, %op28
  %op33 = mul i32 %op31, %op28
  %op35 = mul i32 %op33, %op28
  %op37 = mul i32 %op35, %op28
  %op39 = mul i32 %op37, %op28
  %op42 = mul i32 %op39, %op39
  %op44 = mul i32 %op42, %op39
  %op46 = mul i32 %op44, %op39
  %op48 = mul i32 %op46, %op39
  %op50 = mul i32 %op48, %op39
  %op53 = mul i32 %op50, %op50
  %op55 = mul i32 %op53, %op50
  %op57 = mul i32 %op55, %op50
  %op59 = mul i32 %op57, %op50
  %op61 = mul i32 %op59, %op50
  %op63 = add i32 %op66, 1
  br label %label8
label64:                                                ; preds = %label8
  call void @output(i32 %op67)
  ret void
}
