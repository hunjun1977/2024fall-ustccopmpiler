define i32 @main() #0 {
entry:
  %a = alloca float
  %retval = alloca i32
  store i32 0, i32* %retval
  store float 0x40162E4000000000, float* %a;5.555的IEEE对应的十六进制数
  %0 = load float, float* %a
  %cmp = fcmp ogt float %0, 1.000000e+00
  br i1 %cmp, label %if.ture, label %if.end
if.ture: ; 如果 a > 1，返回 233
  store i32 233, i32* %retval, align 4
  br label %if.end
if.end: ; 默认返回 0
  %1 = load i32, i32* %retval, align 4
  ret i32 %1
}
