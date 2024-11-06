#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num) \
    ConstantInt::get(num, module)

#define CONST_FP(num) \
    ConstantFP::get(num, module) //IR中常数值的表示
int main() {
    auto module=new Module();
    Type *Int32Type = module->get_int32_type();
    auto calleeFun = Function::create(FunctionType::get(Int32Type, {Int32Type}), "callee", module);
    auto bb1 = BasicBlock::create(module, "start", calleeFun);
    auto builder = new IRBuilder(nullptr, module);
    builder->set_insert_point(bb1);
    auto aAlloca = builder->create_alloca(Int32Type); /* 在内存中分配参数a的位置 */
    std::vector<Value *> args;
    for (auto &arg : calleeFun->get_args()) {
        args.push_back(&arg);
    }
    builder->create_store(args[0], aAlloca); /* 存储参数a */
    auto aLoad = builder->create_load(aAlloca);           /* 将参数a存到变量aLoad中 */
    auto res = builder->create_imul(aLoad, CONST_INT(2)); /* 将值乘以2存入变量res中 */
    builder->create_ret(res);                       
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "start", mainFun);
    builder->set_insert_point(bb);
    auto call=builder->create_call(calleeFun,{CONST_INT(110)});
    builder->create_ret(call);
    std::cout<<module->print();
    return 0;


}