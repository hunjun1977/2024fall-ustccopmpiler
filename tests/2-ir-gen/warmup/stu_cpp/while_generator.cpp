#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "IRBuilder.hpp"
#include "Module.hpp"
#include "Type.hpp"

#include <iostream>
#include <memory>

#define CONST_INT(num) ConstantInt::get(num, module)

int main() {
    auto module = new Module();  // 创建模块
    Type *Int32Type = module->get_int32_type();  // 获取 i32 类型

    // 创建 main 函数
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    auto builder = new IRBuilder(nullptr, module);

    builder->set_insert_point(bb);  // 设置插入点到入口基本块

    // 分配 i32 类型的 a 和 i
    auto aAlloca = builder->create_alloca(Int32Type);
    auto iAlloca = builder->create_alloca(Int32Type);

    // 初始化 a 和 i
    builder->create_store(CONST_INT(10), aAlloca);
    builder->create_store(CONST_INT(0), iAlloca);
    auto startBB = BasicBlock::create(module, "start", mainFun);
    builder->create_br(startBB);  // 跳转到 start

    // 开始循环
    builder->set_insert_point(startBB);
    auto iLoad = builder->create_load(iAlloca);  // 加载 i
    auto cmp = builder->create_icmp_lt(iLoad, CONST_INT(10));  // i < 10

    auto bodyBB = BasicBlock::create(module, "body", mainFun);
    auto endBB = BasicBlock::create(module, "end", mainFun);
    
    builder->create_cond_br(cmp, bodyBB, endBB);  // 条件跳转

    // 循环体
    builder->set_insert_point(bodyBB);
    auto iInc = builder->create_iadd(iLoad, CONST_INT(1));  // i + 1
    builder->create_store(iInc, iAlloca);  // 存回 i

    auto aLoad = builder->create_load(aAlloca);  // 加载 a
    auto sum = builder->create_iadd(aLoad, iInc);  // a + i
    builder->create_store(sum, aAlloca);  // 存回 a
    builder->create_br(startBB);  // 返回 start 开始下一个循环

    // 结束块
    builder->set_insert_point(endBB);
    auto resultLoad = builder->create_load(aAlloca);  // 加载最终结果
    builder->create_ret(resultLoad);  // 返回结果

    // 输出生成的 IR 代码
    std::cout << module->print();  // 生成输出
    return 0;
}

