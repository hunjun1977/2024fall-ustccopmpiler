define i32 @main() {
entry:
  %a = alloca i32
  %i = alloca i32
  store i32 10, i32* %a
  store i32 0, i32* %i
  br label %start
start:
  %0 = load i32, i32* %i
  %1 = icmp slt i32 %0,10
  br i1 %1, label %body, label %end
body:
  %2 = load i32, i32* %i    
  %3 = add i32 %2, 1          
  store i32 %3, i32* %i      
  %4 = load i32, i32* %a      
  %5 = add i32 %4, %3        
  store i32 %5, i32* %a        
  br label %start            
end:
  %6 = load i32, i32* %a      
  ret i32 %6                  
}
