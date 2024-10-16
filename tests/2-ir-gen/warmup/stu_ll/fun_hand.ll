define i32 @callee(i32 %a)  {
start:
  %mul = mul i32 %a, 2    ; 计算 2 * a
  ret i32 %mul                ; 返回结果
}
;
define i32 @main()  {
start:
  %call = call i32 @callee(i32 110)  ; 调用 callee(110)
  ret i32 %call                      ; 返回 callee 的结果
}