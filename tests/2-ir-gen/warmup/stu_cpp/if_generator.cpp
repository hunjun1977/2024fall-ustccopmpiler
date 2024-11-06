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
    auto module = new Module();   // 创建模块
    Type *Int32Type = module->get_int32_type();
    Type *FloatType = module->get_float_type();
    
    // 创建 main 函数
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    auto builder = new IRBuilder(nullptr, module);
    builder->set_insert_point(bb);
    
    // 分配变量 a 和 retval
    auto aAlloca = builder->create_alloca(FloatType);
    auto retvalAlloca = builder->create_alloca(Int32Type);
    
    // 初始化 retval 为 0
    builder->create_store(CONST_INT(0), retvalAlloca);
    
    // 将 5.555 存入 a (IEEE 754 的十六进制表示: 0x40162E4000000000)
    builder->create_store(CONST_FP(5.555), aAlloca);
    
    // 加载 a 的值
    auto aValue = builder->create_load(aAlloca);
    
    // 比较 a 是否大于 1.0
    auto cmp = builder->create_fcmp_gt(aValue, CONST_FP(1.0));

    // 创建 if.true 和 if.end 基本块
    auto ifTrueBB = BasicBlock::create(module, "if.true", mainFun);
    auto ifEndBB = BasicBlock::create(module, "if.end", mainFun);
    
    // 条件跳转，根据 cmp 结果跳转到 if.true 或 if.end
    builder->create_cond_br(cmp, ifTrueBB, ifEndBB);
    
    // if.true 基本块：a > 1 时，返回 233
    builder->set_insert_point(ifTrueBB);
    builder->create_store(CONST_INT(233), retvalAlloca);
    builder->create_br(ifEndBB);  // 跳转到 if.end
    
    // if.end 基本块：从 retval 加载值并返回
    builder->set_insert_point(ifEndBB);
    auto retval = builder->create_load(retvalAlloca);
    builder->create_ret(retval);
    
    // 输出生成的 LLVM IR
    std::cout << module->print();
    return 0;
}
