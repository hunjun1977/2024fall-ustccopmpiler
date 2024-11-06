#include "cminusf_builder.hpp"
#include "BasicBlock.hpp"
#include "Function.hpp"
#include "Instruction.hpp"
#include "Type.hpp"
#include "Value.hpp"
#include "ast.hpp"
#include <cassert>
#include <cstdio>
#include <iostream>
#include <string>
#include <type_traits>
#include "logging.hpp"

#define CONST_FP(num) ConstantFP::get((float)num, module.get())
#define CONST_INT(num) ConstantInt::get(num, module.get())

// types
Type *VOID_T;
Type *INT1_T;
Type *INT32_T;
Type *INT32PTR_T;
Type *FLOAT_T;
Type *FLOATPTR_T;

/*
 * use CMinusfBuilder::Scope to construct scopes
 * scope.enter: enter a new scope
 * scope.exit: exit current scope
 * scope.push: add a new binding to current scope
 * scope.find: find and return the value bound to the name
 */

Value *CminusfBuilder::visit(ASTProgram &node) {
    VOID_T = module->get_void_type();
    INT1_T = module->get_int1_type();
    INT32_T = module->get_int32_type();
    INT32PTR_T = module->get_int32_ptr_type();
    FLOAT_T = module->get_float_type();
    FLOATPTR_T = module->get_float_ptr_type();

    Value *ret_val = nullptr;
    for (auto &decl : node.declarations) {
        ret_val = decl->accept(*this);
    }
    return ret_val;
}

Value *CminusfBuilder::visit(ASTNum &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if (node.type == TYPE_INT) {
        return CONST_INT(node.i_val);
    } else if (node.type == TYPE_FLOAT) {
        return CONST_FP(node.f_val);
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTVarDeclaration &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // Value *var_value = nullptr;
    // if (node.num) {
    //     // 处理数组定义
    //     if (node.num->type == TYPE_INT) {
    //         var_value = builder->create_alloca(
    //             ArrayType::get(INT32_T, node.num->i_val));
    //     } else if (node.num->type == TYPE_FLOAT) {
    //         var_value = builder->create_alloca(
    //             ArrayType::get(FLOAT_T, node.num->i_val));
    //     }
    //     scope.push(node.id, var_value); // 存储变量
    // } else {
    //     // 处理普通变量定义
    //     if (node.type == TYPE_INT) {
    //         var_value = builder->create_alloca(INT32_T);
    //     } else if (node.type == TYPE_FLOAT) {
    //         var_value = builder->create_alloca(FLOAT_T);
    //     }
    //     scope.push(node.id, var_value); // 存储变量
    // }
    // return var_value;

    if (!scope.in_global()) //局部
    {
        if (node.num != nullptr) //数组(指针非空
        {
            if(!node.num->i_val)
            {
            	Value * call_error = scope.find("neg_idx_except");//数组定义是大小为零时，打印报错信息
            	builder->create_call(call_error,{});
            }
            if (node.type == TYPE_INT) //整型数组
            {
                auto *arrayType = ArrayType::get(INT32_T, node.num->i_val);
                auto Local_IntArrayAlloca = builder->create_alloca(arrayType); //为数组分配空间
                scope.push(node.id, Local_IntArrayAlloca);
                return Local_IntArrayAlloca;
            }
            else if (node.type == TYPE_FLOAT) //浮点型数组
            {
                auto *arrayType = ArrayType::get(FLOAT_T, node.num->i_val);
                auto Local_FloatArrayAlloca = builder->create_alloca(arrayType); //为数组分配空间
                scope.push(node.id, Local_FloatArrayAlloca);
                return Local_FloatArrayAlloca;
            }
        }
        else //变量
        {
            if (node.type == TYPE_INT) //整型变量
            {
                auto Local_IntAlloca = builder->create_alloca(INT32_T); //为变量分配空间
                scope.push(node.id, Local_IntAlloca);
                return Local_IntAlloca;
            }
            else if (node.type == TYPE_FLOAT) //浮点型变量
            {
                auto Local_FloatAlloca = builder->create_alloca(FLOAT_T); //为变量分配空间
                scope.push(node.id, Local_FloatAlloca);
                return Local_FloatAlloca;
            }
        }
    }
    else //全局
    {
        if (node.num != nullptr ) //数组(指针非空
        {
            if(!node.num->i_val)
            {
            	Value * call_error = scope.find("neg_idx_except");
            	builder->create_call(call_error,{});
            }
            if (node.type == TYPE_INT) //整型数组
            {
                auto *arrayType = ArrayType::get(INT32_T, node.num->i_val);
                auto initializer = ConstantZero::get(arrayType, module.get());
                auto Globle_IntArrayAlloca = GlobalVariable::create(node.id, module.get(), arrayType, false, initializer); //为数组分配空间
                scope.push(node.id, Globle_IntArrayAlloca);
                return Globle_IntArrayAlloca;
            }
            else if (node.type == TYPE_FLOAT) //浮点型数组
            {
                auto *arrayType = ArrayType::get(FLOAT_T, node.num->i_val);
                auto initializer = ConstantZero::get(arrayType, module.get()); //初始值赋为零
                auto Globle_FloatArrayAlloca = GlobalVariable::create(node.id, module.get(), arrayType, false, initializer); //为数组分配空间
                scope.push(node.id, Globle_FloatArrayAlloca);
                return Globle_FloatArrayAlloca;
            }
        }
        else //变量
        {
            if (node.type == TYPE_INT) //整型变量
            {
                auto initializer = ConstantZero::get(INT32_T, module.get());
                auto Globle_IntAlloca = GlobalVariable::create(node.id, module.get(), INT32_T, false, initializer); //为变量分配空间
                scope.push(node.id, Globle_IntAlloca);
                return Globle_IntAlloca;
            }
            else if (node.type == TYPE_FLOAT) //浮点型变量
            {
                auto initializer = ConstantZero::get(FLOAT_T, module.get());
                auto Globle_FloatAlloca = GlobalVariable::create(node.id, module.get(), FLOAT_T, false, initializer); //为变量分配空间
                scope.push(node.id, Globle_FloatAlloca);
                return Globle_FloatAlloca;
            }
        }
    }

    return nullptr;
}

Value *CminusfBuilder::visit(ASTFunDeclaration &node) {
    //LOG(DEBUG)<<"enter fundeclaration";
    FunctionType *fun_type;
    Type *ret_type;
    std::vector<Type *> param_types;
    if (node.type == TYPE_INT)
        ret_type = INT32_T;
    else if (node.type == TYPE_FLOAT)
        ret_type = FLOAT_T;
    else
        ret_type = VOID_T;

    for (auto &param : node.params) {
        // TODO: Please accomplish param_types.
        if(param->isarray){
            Type *param_type=PointerType::get((param->type == TYPE_INT) ? INT32_T : FLOAT_T);
            param_types.push_back(param_type);
        }
        else{
        Type *param_type = (param->type == TYPE_INT) ? INT32_T : FLOAT_T;
            param_types.push_back(param_type);
        }
    }
        

    fun_type = FunctionType::get(ret_type, param_types);
    auto func = Function::create(fun_type, node.id, module.get());
    scope.push(node.id, func);
    context.func = func;
    auto funBB = BasicBlock::create(module.get(), "entry", func);
    context.currentBlock=funBB;
    builder->set_insert_point(funBB);
    scope.enter();
    std::vector<Value *> args;
    for (auto &arg : func->get_args()) {
        args.push_back(&arg);
    }
    for (auto param : node.params){
        param->accept(*this);
    }
    int i = 0;
    for (auto param : node.params) //将参数store下来
    {
        if(param->isarray){
            scope.push(param->id,args[i++]);
        }
        else{
        auto pAlloca = scope.find(param->id);
        std::cout<<pAlloca->print()<<std::endl;
        std::cout<<args[i]->print()<<std::endl;
        std::cout<<args[i]->get_type()->print()<<std::endl;
        std::cout<<param->id<<std::endl;
        if (pAlloca == nullptr){
            i++;
        }        
        else{
            auto temp=builder->create_store(args[i++], pAlloca);
            std::cout<<temp->print()<<std::endl;
        }
        }
    }
    
    node.compound_stmt->accept(*this);
    if (!builder->get_insert_block()->is_terminated()) {
        if (context.func->get_return_type()->is_void_type())
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type())
            builder->create_ret(CONST_FP(0.));
        else
            builder->create_ret(CONST_INT(0));
    }
    scope.exit();
    //LOG(DEBUG)<<"exit fundeclaration";
    return nullptr;
}

Value *CminusfBuilder::visit(ASTParam &node) {
    // TODO: This function is empty now.
    // Add some code here.
    Value *param_value = nullptr;
    if (node.isarray) {
        //scope.push(node.id, param_value);
        return nullptr;
    } else {
        // 为普通参数分配相应的内存
        param_value =
            builder->create_alloca(node.type == TYPE_INT ? INT32_T : FLOAT_T);
        std::cout<<param_value->get_type()->print()<<std::endl;
    }

    // 存储参数到作用域
    scope.push(node.id, param_value);

    return param_value; // 返回分配的参数值

    // return nullptr;
}

Value *CminusfBuilder::visit(ASTCompoundStmt &node) {
    // TODO: This function is not complete.
    // You may need to add some code here
    // to deal with complex statements.
    //std::cout << "deal with compoundstmt" << std::endl;
    scope.enter();
    for (auto &decl : node.local_declarations) {
        decl->accept(*this);
    }
    for (auto &stmt : node.statement_list) {
        stmt->accept(*this);
        if (builder->get_insert_block()->get_terminator() == nullptr)
            break;
    }
    scope.exit();
    return nullptr;
}

Value *CminusfBuilder::visit(ASTExpressionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    //std::cout << "deal with expressionstmt" << std::endl;
    if (node.expression) {
        // 调用表达式的 accept 方法以生成中间代码
        Value *expr_value = node.expression->accept(*this);
        return expr_value;
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTSelectionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto ret=node.expression->accept(*this);
    if (ret->get_type()->is_pointer_type()){
        ret = builder->create_load(ret);
        if (ret->get_type()->is_float_type())
        ret = builder->create_fcmp_ne(ret, CONST_FP(0));
        else if (ret->get_type()->is_int32_type())
        ret = builder->create_icmp_ne(ret, CONST_INT(0));
    }
    if (ret->get_type()->is_float_type())
        ret = builder->create_fcmp_ne(ret, CONST_FP(0));
    else if (ret->get_type()->is_int32_type())
        ret = builder->create_icmp_ne(ret, CONST_INT(0));
    //currentFunction
    context.selectionnum++;
    std::string bb1name="turnBB"+std::to_string(context.selectionnum);
    std::string bb3name="nextBB"+std::to_string(context.selectionnum);
    //std::string bb2name="falseBB"+std::to_string(context.selectionnum);
    auto currentFunc = builder->get_insert_block()->get_parent();
    auto trueBB = BasicBlock::create(module.get(), bb1name, currentFunc); //创建true分支
    BasicBlock *falseBB;
    BasicBlock *nextBB;
    //BranchInst *br;
    if (node.else_statement != nullptr) //有else
    {
        std::string bb2name="falseBB"+std::to_string(context.selectionnum);
        falseBB = BasicBlock::create(module.get(), bb2name, currentFunc);
        nextBB = BasicBlock::create(module.get(), bb3name, currentFunc);
        builder->create_cond_br(ret, trueBB, falseBB);
        //falseBB
        builder->set_insert_point(falseBB);
        node.else_statement->accept(*this);
        if (!builder->get_insert_block()->is_terminated())
        { 
            //nextBB = BasicBlock::create(module.get(), bb3name, currentFunc);
            builder->create_br(nextBB);
        }
        //tureBB
        builder->set_insert_point(trueBB);
        node.if_statement->accept(*this);
        if (!builder->get_insert_block()->is_terminated())
        { 
            //nextBB = BasicBlock::create(module.get(), bb3name, currentFunc);
            builder->create_br(nextBB);
        }
        builder->set_insert_point(nextBB);
        return nullptr;
    }
    else //无else
    {
        //tureBB
        nextBB = BasicBlock::create(module.get(), bb3name, currentFunc);
        builder->create_cond_br(ret, trueBB, nextBB);
        builder->set_insert_point(trueBB);
        node.if_statement->accept(*this);
        if (builder->get_insert_block()->is_terminated()==false)
        { 
            //nextBB = BasicBlock::create(module.get(), bb3name, currentFunc);
            builder->create_br(nextBB);
        }
        builder->set_insert_point(nextBB);
        return nullptr;
    }
}
Value *CminusfBuilder::visit(ASTIterationStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto currentFunc = builder->get_insert_block()->get_parent();
    auto loopJudge = BasicBlock::create(module.get(), "", currentFunc);
    auto loopBody = BasicBlock::create(module.get(), "", currentFunc);
    auto out = BasicBlock::create(module.get(), "", currentFunc);
    if (!builder->get_insert_block()->is_terminated()){
        builder->create_br(loopJudge);
    }
    //loopJudge BB
    builder->set_insert_point(loopJudge);
    auto ret=node.expression->accept(*this);
    if (ret->get_type()->is_pointer_type())
        ret = builder->create_load(ret);
    if (ret->get_type()->is_float_type())
        ret = builder->create_fcmp_ne(ret, CONST_FP(0));
    else if (ret->get_type() == INT32_T)
        ret = builder->create_icmp_ne(ret, CONST_INT(0));

    builder->create_cond_br(ret, loopBody, out);
    //loopBody BB
    builder->set_insert_point(loopBody);
    node.statement->accept(*this);
    if (!builder->get_insert_block()->is_terminated())
        builder->create_br(loopJudge);
    //outloop BB
    builder->set_insert_point(out);
    return nullptr;
}

Value *CminusfBuilder::visit(ASTReturnStmt &node) {
    printf("returnstmt\n");
    if (node.expression == nullptr) {
        builder->create_void_ret();
        return nullptr;
    } else {
        // TODO: The given code is incomplete.
        // You need to solve other return cases (e.g. return an integer).
        auto temp = node.expression->accept(*this);
        if(context.func->get_return_type()==INT32_T){
            if (temp->get_type()->is_float_type()) {
            //auto loadedValue = builder->create_load(temp); // 加载浮点值
            auto temp0=builder->create_fptosi(temp,INT32_T);
            builder->create_ret(temp0);
            }else {
            //auto loadedValue = builder->create_load(temp); // 加载浮点值
            builder->create_ret(temp);
            }
        } 
        else {
            if (temp->get_type()->is_float_type()) {
            //auto loadedValue = builder->create_load(temp); // 加载浮点值
            builder->create_ret(temp);
            }else {
            //auto loadedValue = builder->create_load(temp); // 加载浮点值
                auto temp0=builder->create_sitofp(temp,FLOAT_T);
                builder->create_ret(temp0);
            }
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTVar &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto var = scope.find(node.id);
    //Value *ret;
    if (var) {
        if (node.expression != nullptr) { // 处理数组索引
            // 处理表达式以获取索引
            //std::cout<<var->get_type()->print()<<std::endl;
            context.arrayindex++;
            Value *index = node.expression->accept(*this);
            // 确保索引类型正确
            if (index->get_type()->is_float_type()) {
                index = builder->create_fptosi(index, INT32_T);
            } else if (!index->get_type()->is_integer_type()) {
                // 处理错误情况
                assert(false &&
                       "Index must be an integer or convertible to integer.");
            }
            // 检查索引是否小于零
            //std::string blockName1 = "normal" + std::to_string(context.arrayindex);
            std::string blockName2 = "error" + std::to_string(context.arrayindex);
            std::string blockName3 = "end" + std::to_string(context.arrayindex);
            //BasicBlock *normalBB =
                //BasicBlock::create(module.get(), blockName1, context.func);
            BasicBlock *errorBB =
                BasicBlock::create(module.get(), blockName2, context.func);
            BasicBlock *endBB =
                BasicBlock::create(module.get(), blockName3, context.func);
            Value *isNonNegative = builder->create_icmp_ge(index, CONST_INT(0));
            builder->create_cond_br(isNonNegative, endBB, errorBB);
            //BasicBlock *temp=builder->get_insert_block();
            // 正常处理分支
            //builder->set_insert_point(normalBB);
            //ret = builder->create_load(varAddr); // 加载变量的值
            //return varAddr;
            //builder->create_br(endBB);
            // 错误处理分支
            builder->set_insert_point(errorBB);
            Value *callError = scope.find("neg_idx_except");
            builder->create_call(callError, {});
            builder->create_br(endBB);
            // 结束块
            builder->set_insert_point(endBB);
            if(var->get_type()->get_pointer_element_type()->is_array_type()){
            Value *varAddr = builder->create_gep(
                var, {CONST_INT(0), index});     // 获取数组元素地址
            //builder->create_br(context.currentBlock);
            //builder->set_insert_point(temp);
            return varAddr;}
            else if(var->get_type()->is_pointer_type()){
                Value *varAddr = builder->create_gep(
                var, { index});     // 获取数组元素地址
            //builder->create_br(context.currentBlock);
            //builder->set_insert_point(temp);
            return varAddr;
            }

        } else {
            // 处理普通变量
            return var;
            //ret = builder->create_load(var);
        }
    } else {
        // 处理未找到变量的情况
        printf("Variable '%s' not found in scope\n", node.id.c_str());
        return nullptr; // 或者抛出异常
    }

    //return ret; // 返回变量值
    return nullptr;
}

Value *CminusfBuilder::visit(ASTAssignExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 访问变量和表达式
    //Value* var = scope.find(node.var->id);
    Value* var=node.var->accept(*this);
    //std::cout << var->get_type()->print() << std::endl;
    Value *ret = node.expression.get()->accept(*this); // 访问表达式
    // 处理指向 float 型的情况
    if (var->get_type()->get_pointer_element_type()->is_float_type()) {
        if (ret->get_type()->is_pointer_type()) {
            ret = builder->create_load(ret);
            if (ret->get_type()->is_int32_type()) {
                ret = builder->create_sitofp(ret, FLOAT_T); // 整型转浮点型
            } else if (ret->get_type() == INT1_T) {
                ret = builder->create_zext(ret, INT32_T);   // INT1_T 转整型
                ret = builder->create_sitofp(ret, FLOAT_T); // 转为浮点型
            }
        }
        if (ret->get_type()->is_int32_type()) {
            ret = builder->create_sitofp(ret, FLOAT_T); // 整型转浮点型
        } else if (ret->get_type() == INT1_T) {
            ret = builder->create_zext(ret, INT32_T);   // INT1_T 转整型
            ret = builder->create_sitofp(ret, FLOAT_T); // 转为浮点型
        }
        Value* storeinst=builder->create_store(ret, var);
        //return storeinst;
        return ret;
        //return builder->create_load(storeinst); // 存储结果
    } else {                             // 处理指向 int 型的情况
        if (ret->get_type()->is_pointer_type()) {
            ret = builder->create_load(ret);
            if (ret->get_type() == INT1_T) {
                ret = builder->create_zext(ret, INT32_T); // INT1_T 转整型
            } else if (ret->get_type()->is_float_type()) {
                ret = builder->create_fptosi(ret, INT32_T); // 浮点型转整型
            }
        }
        if (ret->get_type() == INT1_T) {
            //printf("test1");
            ret = builder->create_zext(ret, INT32_T); // INT1_T 转整型
        } else if (ret->get_type()->is_float_type()) {
            // printf("test2");
            ret = builder->create_fptosi(ret, INT32_T); // 浮点型转整型
        }
        //printf("test3");
        Value* storeinst=builder->create_store(ret, var);
        //return ret;
        //return builder->create_load(storeinst); // 存储结果
        return ret;
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTSimpleExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 访问左边的加法表达式
    Value *lhs = node.additive_expression_l->accept(*this);
    // 如果没有右侧表达式和运算符，直接返回左边的值
    if (!node.additive_expression_r) {
        return lhs;
    }

    // 访问右边的加法表达式
    Value *rhs = node.additive_expression_r->accept(*this);

    // 判断是否为32位整型类型
    bool is_int32_type =
        lhs->get_type()->is_int32_type() && rhs->get_type()->is_int32_type();
    Value *converted_lhs = lhs;
    Value *converted_rhs = rhs;
    // 根据关系运算符的类型生成相应的比较指令，并返回比较结果
    if (!is_int32_type) {
        // 处理 lhs
        if (!lhs->get_type()->is_float_type()) {
            if (lhs->get_type() == INT32_T) {
                converted_lhs = builder->create_sitofp(lhs, FLOAT_T);
            } else if (lhs->get_type()->is_pointer_type()) {
                converted_lhs = builder->create_load(lhs);
                converted_lhs = builder->create_fptosi(converted_lhs, FLOAT_T);
            } else if (lhs->get_type() == INT1_T) {
                // 将 INT1_T 转换为整型再转为浮点型
                converted_lhs = builder->create_zext(lhs, INT32_T);
                converted_lhs = builder->create_sitofp(converted_lhs, FLOAT_T);
            }
        }

        // 处理 rhs
        if (!rhs->get_type()->is_float_type()) {
            if (rhs->get_type() == INT32_T) {
                converted_rhs = builder->create_sitofp(rhs, FLOAT_T);
            } else if (rhs->get_type()->is_pointer_type()) {
                converted_rhs = builder->create_load(rhs);
                converted_rhs = builder->create_fptosi(converted_rhs, FLOAT_T);
            } else if (rhs->get_type() == INT1_T) {
                // 将 INT1_T 转换为整型再转为浮点型
                converted_rhs = builder->create_zext(rhs, INT32_T);
                converted_rhs = builder->create_sitofp(converted_rhs, FLOAT_T);
            }
        }

        switch (node.op) {
        case OP_LE: // <=
            return builder->create_fcmp_le(converted_lhs, converted_rhs);
        case OP_LT: // <
            return builder->create_fcmp_lt(converted_lhs, converted_rhs);
        case OP_GE: // >=
            return builder->create_fcmp_ge(converted_lhs, converted_rhs);
        case OP_GT: // >
            return builder->create_fcmp_gt(converted_lhs, converted_rhs);
        case OP_EQ: // ==
            return builder->create_fcmp_eq(converted_lhs, converted_rhs);
        case OP_NEQ: // !=
            return builder->create_fcmp_ne(converted_lhs, converted_rhs);
        default:
            return nullptr;
        }
    } else {
        // 处理整数型比较
        switch (node.op) {
        case OP_LE: // <=
            return builder->create_icmp_le(lhs, rhs);
        case OP_LT: // <
            return builder->create_icmp_lt(lhs, rhs);
        case OP_GE: // >=
            return builder->create_icmp_ge(lhs, rhs);
        case OP_GT: // >
            return builder->create_icmp_gt(lhs, rhs);
        case OP_EQ: // ==
            return builder->create_icmp_eq(lhs, rhs);
        case OP_NEQ: // !=
            return builder->create_icmp_ne(lhs, rhs);
        default:
            return nullptr;
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTAdditiveExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 访问递归的左侧表达式（如果存在）
    //std::cout << "deal with additiveexpression" << std::endl;
    Value *lhs = nullptr;
    if (node.additive_expression) {
        lhs = node.additive_expression->accept(*this);
    }
    // 访问右侧项
    Value *rhs = node.term->accept(*this);
    // 如果没有左侧表达式，直接返回右侧项
    if (!node.additive_expression) {
        return rhs;
    }

    // 检查操作数的类型，并根据操作符进行加减操作
    if (lhs->get_type()->is_float_type() || rhs->get_type()->is_float_type()) {
        // 如果任意一个操作数是浮点数，执行浮点加法或减法
        if (rhs->get_type()->is_integer_type()) {
            rhs = builder->create_sitofp(rhs, FLOAT_T);
        }
        if (lhs->get_type()->is_integer_type()) {
            lhs = builder->create_sitofp(lhs, FLOAT_T);
        }
        if (node.op == OP_PLUS) {
            Value *result = builder->create_fadd(lhs, rhs);
            return result; // 返回指令
        } else if (node.op == OP_MINUS) {
            return builder->create_fsub(lhs, rhs);
        }
    } else {
        std::cout<<lhs->print()<<std::endl;
        std::cout<<rhs->print()<<std::endl;
        std::cout<<rhs->get_type()->print()<<std::endl;
        // 否则，执行整数加法或减法
        if (node.op == OP_PLUS) {
            return builder->create_iadd(lhs, rhs);
        } else if (node.op == OP_MINUS) {
            return builder->create_isub(lhs, rhs);
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTTerm &node) {
    // TODO: This function is empty now.
    // Add some code here.
    //std::cout << "deal with term" << std::endl;
    Value *lhs_value;
    Value *rhs_value;

    // 处理 term -> factor 的情况
    if (!node.term) {
        //std::cout<<node.factor->accept(*this)->get_type()->print()<<std::endl;
        auto temp=node.factor->accept(*this);
        //std::cout<<temp->print()<<std::endl;
        if(!context.inCall){
        if(temp->get_type()->is_pointer_type()){//如果指向变量指针
            if(temp->get_type()->get_pointer_element_type()->is_array_type()){
            return temp;
        }
        return builder->create_load(temp);
        }
        return temp;}
        else{
            return temp;
        }
    }

    // 处理 term -> term mulop factor 的情况
    lhs_value = node.term->accept(*this);
    if (lhs_value->get_type()->is_pointer_type()) {
        lhs_value = builder->create_load(lhs_value);
    }

    rhs_value = node.factor->accept(*this);
    if (rhs_value->get_type()->is_pointer_type()) {
        rhs_value = builder->create_load(rhs_value);
    }

    // 检查类型并执行相应操作
    if (lhs_value->get_type()->is_float_type() ||
        rhs_value->get_type()->is_float_type()) {
        // 至少有一个操作数是浮点数
        if (rhs_value->get_type()->is_integer_type()) {
            rhs_value = builder->create_sitofp(rhs_value, FLOAT_T);
        }
        if (lhs_value->get_type()->is_integer_type()) {
            lhs_value = builder->create_sitofp(lhs_value, FLOAT_T);
        }

        // 执行浮点乘法或除法
        if (node.op == OP_MUL) {
            return builder->create_fmul(lhs_value, rhs_value);
        } else if (node.op == OP_DIV) {
            return builder->create_fdiv(lhs_value, rhs_value);
        }
    } else {
        // 两个操作数都是整数
        if (node.op == OP_MUL) {
            return builder->create_imul(lhs_value, rhs_value);
        } else if (node.op == OP_DIV) {
            return builder->create_isdiv(lhs_value, rhs_value);
        }
    }
    return nullptr;
}

Value *CminusfBuilder::visit(ASTCall &node) {
    // TODO: This function is empty now.
    // Add some code here.
    //printf("deal with call\n");
    
    Value *value;
    value = scope.find(node.id); // 调用scope.find()找ID对应的值
    if (value == nullptr)        // 是不是函数名
    {
        printf("cannot find the fun\n");
        return nullptr;
    }
    auto fun = value->get_type();
    if (!fun->is_function_type()) // 检查函数类型
        return nullptr;

    auto callfun = static_cast<FunctionType *>(fun);
    std::vector<Value *> args;
    for (size_t i = 0; i < node.args.size(); ++i) {
        auto &arg = node.args[i];
        auto arg_type = callfun->get_param_type(i);
        if (arg_type->is_pointer_type()) {
            context.inCall=true;
        }
        // 判断是否为指针，如不是则获取参数的值
        std::cout<<arg_type->print()<<std::endl;
        Value *ret = arg->accept(*this);
        std::cout<<ret->print()<<std::endl;
        std::cout<<ret->get_type()->print()<<std::endl;
        //printf("test");
        // 如果返回值是布尔型，先将其转换为32位整型
        if (callfun->get_return_type() == INT1_T) {
            ret = builder->create_zext(ret, INT32_T);
        }
        // 根据期望的参数类型进行处理
        if (arg_type == INT32_T) {
            if (ret->get_type()->is_pointer_type()) {
                // ret->get_type()->print();
                ret = builder->create_load(ret);
                if (ret->get_type() == INT1_T) {
                    // ret = builder->create_load(ret);
                    ret = builder->create_zext(ret, INT32_T);
                } else if (ret->get_type() == FLOAT_T) {
                    ret = builder->create_fptosi(ret, INT32_T);
                } // 转换为整型
            } else if (ret->get_type() == INT1_T) {
                // ret = builder->create_load(ret);
                ret = builder->create_zext(ret, INT32_T);
            } else if (ret->get_type() == FLOAT_T) {
                ret = builder->create_fptosi(ret, INT32_T);
            } // 转换为整型
        } else if (arg_type == FLOAT_T) {
            if (ret->get_type()->is_pointer_type()) {
                // 如果是指针类型，首先加载
                ret = builder->create_load(ret);
                }
                // 加载后检查类型
                if (ret->get_type() == INT32_T) {
                    ret = builder->create_sitofp(ret,
                                                 FLOAT_T); // 整型转换为浮点型
                } else if (ret->get_type() == INT1_T) {
                    // 对于 INT1_T 类型，先进行扩展
                    ret = builder->create_zext(ret, INT32_T);
                    ret = builder->create_sitofp(ret,
                                                 FLOAT_T); // 然后转换为浮点型
                }
        } 
        else if (arg_type->is_pointer_type()) {
            if(ret->get_type()->is_pointer_type()){
            //如果是数组传入数组的第一个元素的指针
            if(ret->get_type()->get_pointer_element_type()->is_array_type()){
                std::cout<<ret->get_type()->print()<<std::endl;
                ret=builder->create_gep(ret,{CONST_INT(0),CONST_INT(0)});}
            else{
                ret=builder->create_gep(ret,{CONST_INT(0)});
            }
            }
        } else {
            // 处理未预见的类型
            printf("Unsupported parameter type\n");
            return nullptr;
        }
        args.push_back(ret); // 将处理后的值加入参数列表
        context.inCall=false;
    }

    // 创建函数调用
    std::cout<<"calldone"<<std::endl;
    return builder->create_call(value, args);
}
