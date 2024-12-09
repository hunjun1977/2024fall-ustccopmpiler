; ModuleID = 'cminus'
source_filename = "/home/hunjun/Test/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/12-global.cminus"

@seed = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @randomLCG() {
label_entry:
  %op0 = load i32, i32* @seed
  %op1 = mul i32 %op0, 1103515245
  %op2 = add i32 %op1, 12345
  store i32 %op2, i32* @seed
  %op3 = load i32, i32* @seed
  ret i32 %op3
}
define i32 @randBin() {
label_entry:
  %op0 = call i32 @randomLCG()
  %op1 = icmp sgt i32 %op0, 0
  br i1 %op1, label %label_turnBB1, label %label_falseBB1
label_turnBB1:                                                ; preds = %label_entry
  ret i32 1
label_falseBB1:                                                ; preds = %label_entry
  ret i32 0
}
define i32 @returnToZeroSteps() {
label_entry:
  br label %label0
label0:                                                ; preds = %label_entry, %label_nextBB3
  %op1 = phi i32 [ 0, %label_entry ], [ %op11, %label_nextBB3 ]
  %op2 = phi i32 [ 0, %label_entry ], [ %op10, %label_nextBB3 ]
  %op3 = icmp slt i32 %op1, 20
  br i1 %op3, label %label4, label %label7
label4:                                                ; preds = %label0
  %op5 = call i32 @randBin()
  %op6 = icmp ne i32 %op5, 0
  br i1 %op6, label %label_turnBB2, label %label_falseBB2
label7:                                                ; preds = %label0
  ret i32 20
label_turnBB2:                                                ; preds = %label4
  %op8 = add i32 %op2, 1
  br label %label_nextBB2
label_falseBB2:                                                ; preds = %label4
  %op9 = sub i32 %op2, 1
  br label %label_nextBB2
label_nextBB2:                                                ; preds = %label_falseBB2, %label_turnBB2
  %op10 = phi i32 [ %op8, %label_turnBB2 ], [ %op9, %label_falseBB2 ]
  %op11 = add i32 %op1, 1
  %op12 = icmp eq i32 %op10, 0
  br i1 %op12, label %label_turnBB3, label %label_nextBB3
label_turnBB3:                                                ; preds = %label_nextBB2
  ret i32 %op11
label_nextBB3:                                                ; preds = %label_nextBB2
  br label %label0
}
define i32 @main() {
label_entry:
  store i32 3407, i32* @seed
  br label %label0
label0:                                                ; preds = %label_entry, %label3
  %op1 = phi i32 [ 0, %label_entry ], [ %op5, %label3 ]
  %op2 = icmp slt i32 %op1, 20
  br i1 %op2, label %label3, label %label6
label3:                                                ; preds = %label0
  %op4 = call i32 @returnToZeroSteps()
  call void @output(i32 %op4)
  %op5 = add i32 %op1, 1
  br label %label0
label6:                                                ; preds = %label0
  ret i32 0
}
