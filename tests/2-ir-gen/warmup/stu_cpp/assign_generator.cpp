#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num) ConstantInt::get(num, module)
#define CONST_FP(num)  ConstantFP::get(num, module) //IR中常数值的表示

int main() {
    auto module=new Module();   // 从 module 中获取 i32 类型
    Type *Int32Type = module->get_int32_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    auto builder = new IRBuilder(nullptr, module);
    builder->set_insert_point(bb);
    ArrayType *arrayType = ArrayType::get(Int32Type, 10);   
    auto aAlloca = builder->create_alloca(arrayType);
    auto a0 = builder->create_gep(aAlloca,{CONST_INT(0),CONST_INT(0)}); //用变量a0存指向a[0]的指针
    builder->create_store(CONST_INT(10), a0);
    auto tmp = builder->create_load(a0);                                  /* 取出a[0]的值存入变量tmp */
    auto mul = builder->create_imul(tmp, CONST_INT(2));                   /* 将值乘以2存入变量mul中 */
    auto a1 = builder->create_gep(aAlloca, {CONST_INT(0),CONST_INT(1)}); /* 用变量a1存指向a[1]的指针 */
    builder->create_store(mul, a1);                                       /* 将结果mul存入a[1]中 */
    auto res = builder->create_load(a1); /* 取出a[1]中的值作为返回结果，存到变量res中 */
    builder->create_ret(res);            /* 创建返回，将res返回 */
    std::cout<<module->print();  // 生成输出
    return 0;
}