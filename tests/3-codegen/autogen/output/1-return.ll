; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/3-codegen/autogen/testcases/1-return.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  call void @output(i32 111)
  ret i32 111
}
