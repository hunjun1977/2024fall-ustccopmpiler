#include "CodeGen.hpp"

#include "CodeGenUtil.hpp"
#include "Constant.hpp"
#include "Value.hpp"
#include <string>
#include <vector>
#include <queue>

void CodeGen::allocate() {
    // 备份 $ra $fp
    unsigned offset = PROLOGUE_OFFSET_BASE;

    // 为每个参数分配栈空间
    for (auto &arg : context.func->get_args()) {
        auto size = arg.get_type()->get_size();
        offset = offset + size;
        context.offset_map[&arg] = -static_cast<int>(offset);
    }

    // 为指令结果分配栈空间
    for (auto &bb : context.func->get_basic_blocks()) {
        for (auto &instr : bb.get_instructions()) {
            // 每个非 void 的定值都分配栈空间
            if (not instr.is_void()) {
                auto size = instr.get_type()->get_size();
                offset = offset + size;
                context.offset_map[&instr] = -static_cast<int>(offset);
            }
            // alloca 的副作用：分配额外空间
            if (instr.is_alloca()) {
                auto *alloca_inst = static_cast<AllocaInst *>(&instr);
                auto alloc_size = alloca_inst->get_alloca_type()->get_size();
                offset += alloc_size;
            }
        }
    }

    // 分配栈空间，需要是 16 的整数倍
    context.frame_size = ALIGN(offset, PROLOGUE_ALIGN);
}

void CodeGen::copy_stmt() {
    for (auto &succ : context.bb->get_succ_basic_blocks()) {
        for (auto &inst : succ->get_instructions()) {
            if (inst.is_phi()) {
                // 遍历后继块中 phi 的定值 bb
                for (unsigned i = 1; i < inst.get_operands().size(); i += 2) {
                    // phi 的定值 bb 是当前翻译块
                    if (inst.get_operand(i) == context.bb) {
                        auto *lvalue = inst.get_operand(i - 1);
                        if (lvalue->get_type()->is_float_type()) {
                            load_to_freg(lvalue, FReg::fa(0));
                            store_from_freg(&inst, FReg::fa(0));
                        } else {
                            load_to_greg(lvalue, Reg::a(0));
                            store_from_greg(&inst, Reg::a(0));
                        }
                        break;
                    }
                    // 如果没有找到当前翻译块，说明是 undef，无事可做
                }
            } else {
                break;
            }
        }
    }
}

void CodeGen::load_to_greg(Value *val, const Reg &reg) {
    assert(val->get_type()->is_integer_type() ||
           val->get_type()->is_pointer_type());

    if (auto *constant = dynamic_cast<ConstantInt *>(val)) {
        int32_t val = constant->get_value();
        if (IS_IMM_12(val)) {
            append_inst(ADDI WORD, {reg.print(), "$zero", std::to_string(val)});
        } else {
            load_large_int32(val, reg);
        }
    } else if (auto *global = dynamic_cast<GlobalVariable *>(val)) {
        append_inst(LOAD_ADDR, {reg.print(), global->get_name()});
    } else {
        load_from_stack_to_greg(val, reg);
    }
}

void CodeGen::load_large_int32(int32_t val, const Reg &reg) {
    int32_t high_20 = val >> 12; // si20
    uint32_t low_12 = val & LOW_12_MASK;
    append_inst(LU12I_W, {reg.print(), std::to_string(high_20)});
    append_inst(ORI, {reg.print(), reg.print(), std::to_string(low_12)});
}

void CodeGen::load_large_int64(int64_t val, const Reg &reg) {
    auto low_32 = static_cast<int32_t>(val & LOW_32_MASK);
    load_large_int32(low_32, reg);

    auto high_32 = static_cast<int32_t>(val >> 32);
    int32_t high_32_low_20 = (high_32 << 12) >> 12; // si20
    int32_t high_32_high_12 = high_32 >> 20;        // si12
    append_inst(LU32I_D, {reg.print(), std::to_string(high_32_low_20)});
    append_inst(LU52I_D,
                {reg.print(), reg.print(), std::to_string(high_32_high_12)});
}

void CodeGen::load_from_stack_to_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        load_large_int64(offset, reg);
        append_inst(ADD DOUBLE, {reg.print(), "$fp", reg.print()});
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), reg.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), reg.print(), "0"});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), reg.print(), "0"});
        }
    }
}

void CodeGen::store_from_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), addr.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), addr.print(), "0"});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_to_freg(Value *val, const FReg &freg) {
    assert(val->get_type()->is_float_type());
    if (auto *constant = dynamic_cast<ConstantFP *>(val)) {
        float val = constant->get_value();
        load_float_imm(val, freg);
    } else {
        auto offset = context.offset_map.at(val);
        auto offset_str = std::to_string(offset);
        if (IS_IMM_12(offset)) {
            append_inst(FLOAD SINGLE, {freg.print(), "$fp", offset_str});
        } else {
            auto addr = Reg::t(8);
            load_large_int64(offset, addr);
            append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
            append_inst(FLOAD SINGLE, {freg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_float_imm(float val, const FReg &r) {
    int32_t bytes = *reinterpret_cast<int32_t *>(&val);
    load_large_int32(bytes, Reg::t(8));
    append_inst(GR2FR WORD, {r.print(), Reg::t(8).print()});
}

void CodeGen::store_from_freg(Value *val, const FReg &r) {
    auto offset = context.offset_map.at(val);
    if (IS_IMM_12(offset)) {
        auto offset_str = std::to_string(offset);
        append_inst(FSTORE SINGLE, {r.print(), "$fp", offset_str});
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        append_inst(FSTORE SINGLE, {r.print(), addr.print(), "0"});
    }
}

void CodeGen::gen_prologue() {
    if (IS_IMM_12(-static_cast<int>(context.frame_size))) {
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("addi.d $fp, $sp, 0");
        append_inst("addi.d $sp, $sp, " +
                    std::to_string(-static_cast<int>(context.frame_size)));
    } else {
        load_large_int64(context.frame_size, Reg::t(0));
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("sub.d $sp, $sp, $t0");
        append_inst("add.d $fp, $sp, $t0");
    }

    int garg_cnt = 0;
    int farg_cnt = 0;
    for (auto &arg : context.func->get_args()) {
        if (arg.get_type()->is_float_type()) {
            store_from_freg(&arg, FReg::fa(farg_cnt++));
        } else { // int or pointer
            store_from_greg(&arg, Reg::a(garg_cnt++));
        }
    }
}

void CodeGen::gen_epilogue() {
    // TODO 根据你的理解设定函数的 epilogue
    // 恢复帧指针和返回地址
    //先释放栈帧空间
    append_inst("addi.d $sp, $sp, " + std::to_string(static_cast<int>(context.frame_size)));
    append_inst("ld.d $ra, $sp, -8");
    append_inst("ld.d $fp, $sp, -16");
    append_inst("jr $ra");
    //throw not_implemented_error{__FUNCTION__};
}


void CodeGen::gen_ret() {
    // TODO 函数返回，思考如何处理返回值、寄存器备份，如何返回调用者地址
    auto *retInst = static_cast<ReturnInst *>(context.inst);
    if (retInst->get_num_operand() > 0) {
        auto *returnValue = retInst->get_operand(0);
        if (returnValue->get_type()->is_float_type()) {
            load_to_freg(returnValue, FReg::fa(0));
        } else {
            load_to_greg(returnValue, Reg::a(0));
        }
    }
    else if(retInst->get_num_operand()==0){
        append_inst("add.w $a0,$zero,$zero");
    }
    gen_epilogue();
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_br() {
    auto *branchInst = static_cast<BranchInst *>(context.inst);
    if (branchInst->is_cond_br()) {
        // TODO 补全条件跳转的情况
        auto *cond = branchInst->get_operand(0);
        auto *trueBB = static_cast<BasicBlock *>(branchInst->get_operand(1));
        auto *falseBB = static_cast<BasicBlock *>(branchInst->get_operand(2));
        load_to_greg(cond, Reg::t(0));
        append_inst("bnez " + Reg::t(0).print() + ", " + label_name(trueBB));
        append_inst("b " + label_name(falseBB));
        //throw not_implemented_error{__FUNCTION__};
    } else {
        auto *branchbb = static_cast<BasicBlock *>(branchInst->get_operand(0));
        append_inst("b " + label_name(branchbb));
    }
}

void CodeGen::gen_binary() {
    load_to_greg(context.inst->get_operand(0), Reg::t(0));
    load_to_greg(context.inst->get_operand(1), Reg::t(1));
    switch (context.inst->get_instr_type()) {
    case Instruction::add:
        output.emplace_back("add.w $t2, $t0, $t1");
        break;
    case Instruction::sub:
        output.emplace_back("sub.w $t2, $t0, $t1");
        break;
    case Instruction::mul:
        output.emplace_back("mul.w $t2, $t0, $t1");
        break;
    case Instruction::sdiv:
        output.emplace_back("div.w $t2, $t0, $t1");
        break;
    default:
        assert(false);
    }
    store_from_greg(context.inst, Reg::t(2));
}

void CodeGen::gen_float_binary() {
    // TODO 浮点类型的二元指令
    load_to_freg(context.inst->get_operand(0), FReg::ft(0));
    load_to_freg(context.inst->get_operand(1), FReg::ft(1));
    switch (context.inst->get_instr_type()) {
    case Instruction::fadd:
        append_inst("fadd.s $ft2, $ft0, $ft1");
        break;
    case Instruction::fsub:
        append_inst("fsub.s $ft2, $ft0, $ft1");
        break;
    case Instruction::fmul:
        append_inst("fmul.s $ft2, $ft0, $ft1");
        break;
    case Instruction::fdiv:
        append_inst("fdiv.s $ft2, $ft0, $ft1");
        break;
    default:
        assert(false);
    }
    store_from_freg(context.inst, FReg::ft(2));
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_alloca() {
    /* 我们已经为 alloca 的内容分配空间，在此我们还需保存 alloca
     * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
     */
    // TODO 将 alloca 出空间的起始地址保存在栈帧上
    auto *allocaInst = static_cast<AllocaInst *>(context.inst);
    auto offset = context.offset_map[allocaInst];
    int alloc_size = allocaInst->get_alloca_type()->get_size();
    auto reg = Reg::t(0);
    if (IS_IMM_12(offset-alloc_size)) {
        append_inst("addi.d " + reg.print() + ", $fp, " + std::to_string(offset-alloc_size));
    } else {
        load_large_int64(offset-alloc_size, reg);
        append_inst("add.d " + reg.print() + ", $fp, " + reg.print());
    }
    store_from_greg(context.inst, reg);
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_load() {
    auto *ptr = context.inst->get_operand(0);
    auto *type = context.inst->get_type();
    load_to_greg(ptr, Reg::t(0));
    if (type->is_float_type()) {
        append_inst("fld.s $ft0, $t0, 0");
        store_from_freg(context.inst, FReg::ft(0));
    } else {
        // TODO load 整数类型的数据
        append_inst("ld.w $t1, $t0, 0");
        store_from_greg(context.inst, Reg::t(1));
        //throw not_implemented_error{__FUNCTION__};
    }
}

void CodeGen::gen_store() {
    // TODO 翻译 store 指令
    auto *val = context.inst->get_operand(0);
    auto *ptr = context.inst->get_operand(1);
    if (val->get_type()->is_float_type()) {
        load_to_freg(val, FReg::ft(0));
        load_to_greg(ptr, Reg::t(0));
        append_inst("fst.s $ft0, $t0, 0");
    } else {
        load_to_greg(val, Reg::t(1));
        load_to_greg(ptr, Reg::t(0));
        if (val->get_type()->is_int1_type()) {
            append_inst("st.b $t1, $t0, 0");
        } else if (val->get_type()->is_int32_type()) {
            append_inst("st.w $t1, $t0, 0");
        } else { // Pointer
            append_inst("st.d $t1, $t0, 0");
        }
    }
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_icmp() {
    // TODO 处理各种整数比较的情况
    // 获取指令的操作符和操作数
    auto inst=context.inst;
    auto op = inst->get_instr_type();         // 比较类型，例如 eq, ne, lt 等
    auto lhs = inst->get_operand(0);  // 左操作数
    auto rhs = inst->get_operand(1);  // 右操作数

    // 分配目标寄存器
    std::string result_reg = Reg::t(0).print();  // 存储比较结果
    load_to_greg(lhs, Reg::t(1));
    auto lhs_reg=Reg::t(1).print();
    load_to_greg(rhs, Reg::t(2));
    auto rhs_reg=Reg::t(2).print();
    // 根据操作类型生成对应的指令
    switch (op) {
    case ICmpInst::eq: // ==
        // t0 = lhs ^ rhs, t0 = !(t0 != 0)
        append_inst("xor " + result_reg + ", " + lhs_reg + ", " + rhs_reg);
        append_inst("sltu " + result_reg + ", $zero, " + result_reg);
        append_inst("xori " + result_reg + ", " + result_reg + ", 1");
        break;

    case ICmpInst::ne: // !=
        // t0 = lhs ^ rhs, t0 = (t0 != 0)
        append_inst("xor " + result_reg + ", " + lhs_reg + ", " + rhs_reg);
        append_inst("sltu " + result_reg + ", $zero, " + result_reg);
        break;

    case ICmpInst::lt: // <
        // t0 = (lhs < rhs)
        append_inst("slt " + result_reg + ", " + lhs_reg + ", " + rhs_reg);
        break;

    case ICmpInst::le: // <=
        // t0 = !(rhs < lhs)
        append_inst("slt " + result_reg + ", " + rhs_reg + ", " + lhs_reg);
        append_inst("xori " + result_reg + ", " + result_reg + ", 1");
        break;

    case ICmpInst::gt: // >
        // t0 = (rhs < lhs)
        append_inst("slt " + result_reg + ", " + rhs_reg + ", " + lhs_reg);
        break;

    case ICmpInst::ge: // >=
        // t0 = !(lhs < rhs)
        append_inst("slt " + result_reg + ", " + lhs_reg + ", " + rhs_reg);
        append_inst("xori " + result_reg + ", " + result_reg + ", 1");
        break;
    default:
        throw not_implemented_error("Unsupported comparison operator.");
    }
    // 保存结果到中间代码的目标寄存器
    store_from_greg(inst, Reg::t(0));

}

void CodeGen::gen_fcmp() {
    //TODO
    // 获取当前指令和操作数
    auto inst = context.inst;
    auto op = inst->get_instr_type(); // 获取比较类型
    auto lhs = inst->get_operand(0); // 左操作数
    auto rhs = inst->get_operand(1); // 右操作数

    // 将操作数加载到浮点寄存器
    load_to_freg(lhs, FReg::ft(0));
    auto lhs_reg = FReg::ft(0).print();
    load_to_freg(rhs, FReg::ft(1));
    auto rhs_reg = FReg::ft(1).print();

    // 获取目标寄存器的栈偏移
    auto offset = context.offset_map[inst];

    // 生成唯一标签
    auto label_true = fcmp_label_name(context.bb, context.fcmp_cnt) + "_true";
    auto label_false = fcmp_label_name(context.bb, context.fcmp_cnt) + "_false";
    auto label_exit = fcmp_label_name(context.bb, context.fcmp_cnt) + "_exit";
    context.fcmp_cnt++;

    // 根据操作符生成指令
    switch (op) {
    case ICmpInst::feq: // ==
        append_inst("fcmp.ceq.s $fcc0, " + lhs_reg + ", " + rhs_reg);
        break;
    case ICmpInst::fne: // !=
        append_inst("fcmp.ceq.s $fcc0, " + lhs_reg + ", " + rhs_reg);
        append_inst("bceqz $fcc0, " + label_true); // 取反结果
        break;
    case ICmpInst::flt: // <
        append_inst("fcmp.slt.s $fcc0, " + lhs_reg + ", " + rhs_reg);
        break;
    case ICmpInst::fle: // <=
        append_inst("fcmp.sle.s $fcc0, " + lhs_reg + ", " + rhs_reg);
        break;
    case ICmpInst::fgt: // >
        append_inst("fcmp.slt.s $fcc0, " + rhs_reg + ", " + lhs_reg); // rhs < lhs
        break;
    case ICmpInst::fge: // >=
        append_inst("fcmp.sle.s $fcc0, " + rhs_reg + ", " + lhs_reg); // rhs <= lhs
        break;
    default:
        throw not_implemented_error("Unsupported floating-point comparison operator.");
    }

    // 处理比较结果
    append_inst("bcnez $fcc0, " + label_true); // 如果结果为真，跳转到 true_label
    append_inst("b " + label_false);          // 否则跳转到 false_label

    // True 分支
    append_inst(label_true, ASMInstruction::Label);
    append_inst("addi.w $t0, $zero, 1"); // 真：写入 1 到寄存器
    append_inst("st.w", {"$t0", "$fp", std::to_string(offset)});
    append_inst("b " + label_exit);

    // False 分支
    append_inst(label_false, ASMInstruction::Label);
    append_inst("addi.w $t0, $zero, 0"); // 假：写入 0 到寄存器
    append_inst("st.w", {"$t0", "$fp", std::to_string(offset)});
    append_inst("b " + label_exit);

    // Exit 标签
    append_inst(label_exit, ASMInstruction::Label);
}


void CodeGen::gen_zext() {
    //TODO
    // 获取当前指令和操作数
    auto inst = context.inst; // 当前指令
    auto src = inst->get_operand(0); // 窄位宽数据
    auto dest = inst; // 宽位宽数据 (结果存储的位置)
    // 加载源操作数到寄存器
    load_to_greg(src, Reg::t(0));
    auto src_reg = Reg::t(0).print();
    // 获取目标栈偏移
    auto offset = context.offset_map[dest];
    // 生成扩展指令
    // 目标位宽为 32 位，源位宽为 8 位，零扩展直接通过逻辑操作完成
    append_inst("andi", {src_reg, src_reg, "0xFF"}); // 保留低位数据，自动完成零扩展
    // 存储结果到栈上
    append_inst("st.w", {src_reg, "$fp", std::to_string(offset)});
}


void CodeGen::gen_call() {
    //TODO
    // 获取当前指令和操作数
    auto inst = context.inst; // 当前指令
    auto func = inst->get_operand(0); // 被调用函数
    auto args = inst->get_operands(); // 函数参数
    auto ret_val = inst; // 返回值位置

    // 加载参数到寄存器
    for (size_t i = 1; i < args.size() && i <= 8; ++i) {
        auto arg = args[i];
        if (arg->get_type()->is_integer_type()||arg->get_type()->is_pointer_type()) {
            // 整数参数加载到 $a0-$a7
            load_to_greg(arg, Reg::a(i - 1));
        } else if (arg->get_type()->is_float_type()) {
            // 浮点参数加载到 $fa0-$fa7
            load_to_freg(arg, FReg::fa(i - 1));
        } else {
            throw not_implemented_error{"Unsupported argument type."};
        }
    }
    // 生成函数调用指令
    auto func_name = func->get_name(); // 函数名
    append_inst("bl", {func_name});
    // 如果有返回值，存储到栈上
    if (!ret_val->get_type()->is_void_type()) {
        if (ret_val->get_type()->is_integer_type()) {
            // 返回值是整数，存储 $a0
            auto offset = context.offset_map[ret_val];
            append_inst("st.w", {"$a0", "$fp", std::to_string(offset)});
        } else if (ret_val->get_type()->is_float_type()) {
            // 返回值是浮点数，存储 $fa0
            auto offset = context.offset_map[ret_val];
            append_inst("fst.s", {"$fa0", "$fp", std::to_string(offset)});
        }
    }
}


/*
 * %op = getelementptr [10 x i32], [10 x i32]* %op, i32 0, i32 %op
 * %op = getelementptr        i32,        i32* %op, i32 %op
 *
 * Memory layout
 *       -            ^
 * +-----------+      | Smaller address
 * |  arg ptr  |---+  |
 * +-----------+   |  |
 * |           |   |  |
 * +-----------+   /  |
 * |           |<--   |
 * |           |   \  |
 * |           |   |  |
 * |   Array   |   |  |
 * |           |   |  |
 * |           |   |  |
 * |           |   |  |
 * +-----------+   |  |
 * |  Pointer  |---+  |
 * +-----------+      |
 * |           |      |
 * +-----------+      |
 * |           |      |
 * +-----------+      |
 * |           |      |
 * +-----------+      | Larger address
 *       +
 */
void CodeGen::gen_gep() {
    // TODO
    // 获取 GEP 指令的操作数
   auto gep_inst = dynamic_cast<GetElementPtrInst *>(context.inst);
    if (!gep_inst) {
        throw std::runtime_error("Invalid instruction type for GEP.");
    }

    // 基础指针
    Value *base_ptr = gep_inst->get_operand(0);
    std::string opname=base_ptr->get_name();
    int base_offset = context.offset_map[base_ptr];
    if(base_offset){//检查是否为全局变量
    // 加载基础指针地址到寄存器 $t0
    append_inst("ld.d", {"$t0", "$fp", std::to_string(base_offset)});}
    else{
        append_inst("la.local", {"$t0", opname});
    }

    // 索引队列
    std::queue<Value *> index_queue;
    for (int i = 1; i < gep_inst->get_num_operand(); ++i) {
        index_queue.push(gep_inst->get_operand(i));
    }
    Type *current_type = base_ptr->get_type()->get_pointer_element_type();
    while (!index_queue.empty()) {
        Value *index = index_queue.front();
        index_queue.pop();

        int index_value = 0;

        // 如果索引是常量
        if (auto const_idx = dynamic_cast<ConstantInt *>(index)) {
            index_value = const_idx->get_value();
        } else {
            // 加载动态索引值到 $t1
            int index_offset = context.offset_map[index];
            append_inst("ld.w", {"$t1", "$fp", std::to_string(index_offset)});
            append_inst("addi.d $t2, $zero, "+std::to_string(current_type->get_size()));
            append_inst("mul.d $t1, $t1, $t2");
            append_inst("add.d $t0, $t0, $t1");
            continue;
        }
        // 累加偏移量
        int offset = index_value * current_type->get_size();
        append_inst("addi.d $t0, $t0, " + std::to_string(offset));
        // 更新类型
        if (current_type->is_array_type()) {
            current_type = current_type->get_array_element_type();
        } else if (current_type->is_pointer_type()) {
            current_type = current_type->get_pointer_element_type();
        } else {
            //throw std::runtime_error("Invalid GEP: Indexing non-aggregate type.");
        }
    }
    // 存储计算结果
    int gep_offset=context.offset_map[gep_inst];
    append_inst("st.d", {"$t0", "$fp", std::to_string(gep_offset)});
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_sitofp() {
    // TODO 整数转向浮点数
    auto inst=context.inst;
    auto op0=inst->get_operand(0);
    load_to_greg(op0,Reg::t(0));
    append_inst("movgr2fr.w $ft0,$t0");
    append_inst("ffint.s.w $ft1, $ft0");
    store_from_freg(inst,FReg::ft(1));
    //throw not_implemented_error{__FUNCTION__};
}
// 单精度浮点数向下取整

void CodeGen::gen_fptosi() {
    // TODO 浮点数转向整数，注意向下取整(round to zero)
    auto inst=context.inst;
    auto op0=inst->get_operand(0);
    load_to_freg(op0,FReg::ft(1));
    append_inst("ftint.w.s $ft0, $ft1");
    append_inst("movfr2gr.s $t0,$ft0");
    store_from_greg(inst,Reg::t(0));
    //throw not_implemented_error{__FUNCTION__};
}

void CodeGen::run() {
    // 确保每个函数中基本块的名字都被设置好
    m->set_print_name();

    /* 使用 GNU 伪指令为全局变量分配空间
     * 你可以使用 `la.local` 指令将标签 (全局变量) 的地址载入寄存器中, 比如
     * 要将 `a` 的地址载入 $t0, 只需要 `la.local $t0, a`
     */
    if (!m->get_global_variable().empty()) {
        append_inst("Global variables", ASMInstruction::Comment);
        /* 虽然下面两条伪指令可以简化为一条 `.bss` 伪指令, 但是我们还是选择使用
         * `.section` 将全局变量放到可执行文件的 BSS 段, 原因如下:
         * - 尽可能对齐交叉编译器 loongarch64-unknown-linux-gnu-gcc 的行为
         * - 支持更旧版本的 GNU 汇编器, 因为 `.bss` 伪指令是应该相对较新的指令,
         *   GNU 汇编器在 2023 年 2 月的 2.37 版本才将其引入
         */
        append_inst(".text", ASMInstruction::Atrribute);
        append_inst(".section", {".bss", "\"aw\"", "@nobits"},
                    ASMInstruction::Atrribute);
        for (auto &global : m->get_global_variable()) {
            auto size =
                global.get_type()->get_pointer_element_type()->get_size();
            append_inst(".globl", {global.get_name()},
                        ASMInstruction::Atrribute);
            append_inst(".type", {global.get_name(), "@object"},
                        ASMInstruction::Atrribute);
            append_inst(".size", {global.get_name(), std::to_string(size)},
                        ASMInstruction::Atrribute);
            append_inst(global.get_name(), ASMInstruction::Label);
            append_inst(".space", {std::to_string(size)},
                        ASMInstruction::Atrribute);
        }
    }

    // 函数代码段
    output.emplace_back(".text", ASMInstruction::Atrribute);
    for (auto &func : m->get_functions()) {
        if (not func.is_declaration()) {
            // 更新 context
            context.clear();
            context.func = &func;

            // 函数信息
            append_inst(".globl", {func.get_name()}, ASMInstruction::Atrribute);
            append_inst(".type", {func.get_name(), "@function"},
                        ASMInstruction::Atrribute);
            append_inst(func.get_name(), ASMInstruction::Label);

            // 分配函数栈帧
            allocate();
            // 生成 prologue
            gen_prologue();

            for (auto &bb : func.get_basic_blocks()) {
                context.bb = &bb;
                append_inst(label_name(context.bb), ASMInstruction::Label);
                for (auto &instr : bb.get_instructions()) {
                    // For debug
                    append_inst(instr.print(), ASMInstruction::Comment);
                    context.inst = &instr; // 更新 context
                    switch (instr.get_instr_type()) {
                    case Instruction::ret:
                        gen_ret();
                        break;
                    case Instruction::br:
                        copy_stmt();
                        gen_br();
                        break;
                    case Instruction::add:
                    case Instruction::sub:
                    case Instruction::mul:
                    case Instruction::sdiv:
                        gen_binary();
                        break;
                    case Instruction::fadd:
                    case Instruction::fsub:
                    case Instruction::fmul:
                    case Instruction::fdiv:
                        gen_float_binary();
                        break;
                    case Instruction::alloca:
                        /* 对于 alloca 指令，我们已经为 alloca
                         * 的内容分配空间，在此我们还需保存 alloca
                         * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
                         */
                        gen_alloca();
                        break;
                    case Instruction::load:
                        gen_load();
                        break;
                    case Instruction::store:
                        gen_store();
                        break;
                    case Instruction::ge:
                    case Instruction::gt:
                    case Instruction::le:
                    case Instruction::lt:
                    case Instruction::eq:
                    case Instruction::ne:
                        gen_icmp();
                        break;
                    case Instruction::fge:
                    case Instruction::fgt:
                    case Instruction::fle:
                    case Instruction::flt:
                    case Instruction::feq:
                    case Instruction::fne:
                        gen_fcmp();
                        break;
                    case Instruction::phi:
                        /* for phi, just convert to a series of
                         * copy-stmts */
                        /* we can collect all phi and deal them at
                         * the end */
                        break;
                    case Instruction::call:
                        gen_call();
                        break;
                    case Instruction::getelementptr:
                        gen_gep();
                        break;
                    case Instruction::zext:
                        gen_zext();
                        break;
                    case Instruction::fptosi:
                        gen_fptosi();
                        break;
                    case Instruction::sitofp:
                        gen_sitofp();
                        break;
                    }
                }
            }
            // 生成 epilogue
            gen_epilogue();
        }
    }
}

std::string CodeGen::print() const {
    std::string result;
    for (const auto &inst : output) {
        result += inst.format();
    }
    return result;
}
