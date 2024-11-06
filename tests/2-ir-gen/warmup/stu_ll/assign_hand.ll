; ModuleID = 'assign.c'
define i32 @main() {
start:
  %a = alloca [10 x i32]           ; 分配数组 a[10]
  %0 = getelementptr  [10 x i32], [10 x i32]* %a, i32 0, i32 0
  store i32 10, i32* %0, align 4             ; a[0] = 10
  %1 = getelementptr  [10 x i32], [10 x i32]* %a, i32 0, i32 0
  %2 = load i32, i32* %1, align 4            ; 读取 a[0] 的值
  %3 = mul i32 %2, 2                   ; a[1] = a[0] * 2
  %4 = getelementptr  [10 x i32], [10 x i32]* %a, i32 0, i32 1
  store i32 %3, i32* %4, align 4           ; 存储 a[1]
  %5 = load i32, i32* %4, align 4            ; 读取 a[1] 的值
  ret i32 %5                                 ; 返回 a[1]
}