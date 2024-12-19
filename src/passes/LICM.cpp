#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "GlobalVariable.hpp"
#include "Instruction.hpp"
#include "LICM.hpp"
#include "PassManager.hpp"
#include <cstddef>
#include <memory>
#include <vector>

/**
 * @brief 循环不变式外提Pass的主入口函数
 * 
 */
void LoopInvariantCodeMotion::run() {

    loop_detection_ = std::make_unique<LoopDetection>(m_);
    loop_detection_->run();
    func_info_ = std::make_unique<FuncInfo>(m_);
    func_info_->run();
    for (auto &loop : loop_detection_->get_loops()) {
        is_loop_done_[loop] = false;
    }

    for (auto &loop : loop_detection_->get_loops()) {
        traverse_loop(loop);
    }
}

/**
 * @brief 遍历循环及其子循环
 * @param loop 当前要处理的循环
 * 
 */
void LoopInvariantCodeMotion::traverse_loop(std::shared_ptr<Loop> loop) {
    if (is_loop_done_[loop]) {
        return;
    }
    is_loop_done_[loop] = true;
    for (auto &sub_loop : loop->get_sub_loops()) {
        traverse_loop(sub_loop);
    }
    run_on_loop(loop);
}

// TODO: 实现collect_loop_info函数
// 1. 遍历当前循环及其子循环的所有指令
// 2. 收集所有指令到loop_instructions中
// 3. 检查store指令是否修改了全局变量，如果是则添加到updated_global中
// 4. 检查是否包含非纯函数调用，如果有则设置contains_impure_call为true
void LoopInvariantCodeMotion::collect_loop_info(
    std::shared_ptr<Loop> loop,
    std::set<Value *> &loop_instructions,
    std::set<Value *> &updated_global,
    bool &contains_impure_call) {
          // 遍历当前循环及其子循环的所有基本块
    for (auto *bb : loop->get_blocks()) {
        // 遍历每个基本块中的所有指令
        for (auto &instr : bb->get_instructions()) {
            // 将每个指令添加到 loop_instructions 集合中
            loop_instructions.insert(&instr);
            // 如果是 store 指令，检查是否更新了全局变量
            if (instr.is_store()) {
                auto *store_instr = dynamic_cast<StoreInst *>(&instr);
                auto *l_val = store_instr->get_lval();
                // 检查 store 的地址是否为全局变量
                if (dynamic_cast<GlobalVariable *>(l_val) != nullptr) {
                    updated_global.insert(l_val); // 将全局变量添加到 updated_global 中
                }
            }

            // 检查是否包含非纯函数调用
            if (instr.is_call()) {
                auto *call_instr = dynamic_cast<CallInst *>(&instr);
                auto *callee = dynamic_cast<Function*>(call_instr->get_operand(0));

                // 判断是否是非纯函数调用（即具有副作用的函数）
                if (callee != nullptr && !func_info_->is_pure_function(callee)) {
                    contains_impure_call = true; // 设置 contains_impure_call 为 true
                }
            }
        }
    }

    // 递归遍历子循环
    for (auto &sub_loop : loop->get_sub_loops()) {
        collect_loop_info(sub_loop, loop_instructions, updated_global, contains_impure_call);
    }
    
    //throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
}

/**
 * @brief 对单个循环执行不变式外提优化
 * @param loop 要优化的循环
 * 
 */
void LoopInvariantCodeMotion::run_on_loop(std::shared_ptr<Loop> loop) {
    std::set<Value *> loop_instructions;
    std::set<Value *> updated_global;
    bool contains_impure_call = false;
    collect_loop_info(loop, loop_instructions, updated_global, contains_impure_call);

    std::vector<Value *> loop_invariant;


    // TODO: 识别循环不变式指令
    //
    // - 如果指令已被标记为不变式则跳过
    // - 跳过 store、ret、br、phi 等指令与非纯函数调用
    // - 特殊处理全局变量的 load 指令
    // - 检查指令的所有操作数是否都是循环不变的
    // - 如果有新的不变式被添加则注意更新 changed 标志，继续迭代

    bool changed;
    do {
        changed = false;

        //throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
         // 步骤一：识别循环不变式指令
        for (auto &t : loop_instructions) {
            auto instr=dynamic_cast<Instruction*>(t);
            // 跳过不变式的指令（已标记为不变式）
            if (std::find(loop_invariant.begin(),loop_invariant.end(),instr)!=loop_invariant.end()) {
                continue;
            }
            // 检查是否为循环不变式：store、ret、br、phi 等指令跳过
            if (instr->is_store() || instr->is_ret() || instr->is_br() || instr->is_phi()) {
                continue;
            }
            if(instr->is_call()&&contains_impure_call){
                continue;
            }
           // 检查指令的所有操作数是否都是循环不变式的
            bool is_invariant = true;
            for (auto &op : instr->get_operands()) {
                // 如果操作数不是常量或循环外的变量或非循环不变式的指令
                if (dynamic_cast<Constant *>(op) == nullptr&&
                    std::find(loop_invariant.begin(),loop_invariant.end(),op)==loop_invariant.end()&&
                    dynamic_cast<GlobalVariable *>(op) == nullptr&&loop_instructions.find(op)!=loop_instructions.end()) {
                    is_invariant = false;
                    break;
                }
            }

            // 如果是循环不变式指令，添加到 loop_invariant
            if (is_invariant) {
                loop_invariant.push_back(instr);// 标记为不变式
                changed = true;
            }
        }

    } while (changed);

    if (loop->get_preheader() == nullptr) {
        loop->set_preheader(
            BasicBlock::create(m_, "", loop->get_header()->get_parent()));
    }

    if (loop_invariant.empty())
        return;

    // insert preheader
    auto preheader = loop->get_preheader();

    // TODO: 更新 phi 指令
    for (auto &phi_inst_ : loop->get_header()->get_instructions()) {
        if (phi_inst_.get_instr_type() != Instruction::phi)
            break;
        auto *phi_inst = dynamic_cast<PhiInst *>(&phi_inst_);
        if (phi_inst) {
            // 更新 phi 指令，修改它的操作数
            //auto l_val = phi_lval.at(phi_inst);
            for(auto &pair:phi_inst->get_phi_pairs())
                for (auto *pre_block:loop->get_header()->get_pre_basic_blocks()) {
                    if (pair.second == pre_block&&loop->get_latches().find(pre_block) == loop->get_latches().end()) {
                        phi_inst->remove_phi_operand(pre_block);
                        phi_inst->add_phi_pair_operand(pair.first,preheader);
                    }
                }

        }
        
        //throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
    }

    // TODO: 用跳转指令重构控制流图 
    // 将所有非 latch 的 header 前驱块的跳转指向 preheader
    // 并将 preheader 的跳转指向 header
    // 注意这里需要更新前驱块的后继和后继的前驱
    std::vector<BasicBlock *> pred_to_remove;
    for (auto &pred : loop->get_header()->get_pre_basic_blocks()) {
        //throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
         // 将非 latch 的前驱基本块跳转指令指向 preheader
        if (loop->get_latches().find(pred) == loop->get_latches().end()) {
            auto br_instr=pred->get_terminator();
            br_instr->set_operand(0,preheader);
            pred_to_remove.push_back(pred);
        }
    }
    preheader->add_succ_basic_block(loop->get_header());
    loop->get_header()->add_pre_basic_block(preheader);
    for (auto &pred : pred_to_remove) {
        pred->remove_succ_basic_block(loop->get_header());
        pred->add_succ_basic_block(preheader);
        preheader->add_pre_basic_block(pred);
        loop->get_header()->remove_pre_basic_block(pred);
    }
    // TODO: 外提循环不变指令
    //throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
    // 步骤五：外提循环不变式指令
    std::cout<<"down"<<std::endl;
    for (size_t i = 0; i < loop_invariant.size(); ++i) {
        auto *instr=dynamic_cast<Instruction*>(loop_invariant[i]);
        instr->get_parent()->remove_instr(instr);
        std::cout<<preheader->get_num_of_instr()<<std::endl;
    }
    for (size_t i = 0; i < loop_invariant.size(); ++i) {
        auto *instr=dynamic_cast<Instruction*>(loop_invariant[i]);
        preheader->add_instruction(instr);
        //instr->set_parent(preheader);
        std::cout<<preheader->get_num_of_instr()<<std::endl;   
    }

    // insert preheader br to header
    BranchInst::create_br(loop->get_header(), preheader);

    // insert preheader to parent loop
    if (loop->get_parent() != nullptr) {
        loop->get_parent()->add_block(preheader);
    }
}
