---
title: "多Agent架构"
weight: 1
bookCollapseSection: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">多Agent架构</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-08-07 | 更新时间：2026-08-07
</div>
{{< katex />}}

多Agent架构就是联合多个Agent共同完成一个任务。

> 多Agent中的每个Agent本身依然可以跑Agent‑Loop（ReAct)。

# 为什么需要多Agent架构

多Agent相对单Agent的核心优势，分来两个角度展开：

- 克服LLM的能力上限角度：
    1. **专业化分工，注意力集中**，工具集、技能集最小化，system prompt极简。
    2. **上下文隔离**，每个子Agent拥有独立上下文，只输出中间结果，避免上下文窗口爆炸和污染。
    3. **互相纠偏**，可以引入独立的review/judge Agent做校验、辩论、纠错，主动发现幻觉与错误，避免单Agent的幻觉跑偏。

- 工程落地角度：
    1. **并行执行，缩短处理时长**。
    2. **容错与故障隔离**，单Agent崩溃只需重跑该子任务。
    3. **权限最小化控制**，可以给每个Agent需必要的最小权限。
    4. **模块化可扩展**，多Agent就像微服务架构，新Agent的加入不影响整体流程，能力扩展友好。

> [!NOTE]
> **幻觉**、**注意力分散**、**上下文窗口大小**是LLM的能力上限，Agent也需要像人类一样，团队协作才能完成复杂的任务。


# 多Agent协作范式

- **委派模式**（层级）：Manager Agent拆解任务，下发Worker Agent 执行，最后汇总结果；
- **辩论模式**（对抗）：对立Agent输出不同观点，judge仲裁，降低事实幻觉；
- **黑板模式**（共创）：多个Agent基于共享状态迭代创作；


## 辩论模式（MAD）

Multi‑Agent Debate

多个独立Agent带着不同立场/视角互相质疑、反驳、补漏洞，把隐藏假设、逻辑错误、幻觉暴露出来，最后收敛出更可靠结论。

> 单Agent自我反思很难推翻自己，会自我辩护、自圆其说。

**拓扑**：大多是带Judge/Orchestrator的星形拓扑；辩论选手之间可以点对点Mesh对话，但全程受调度Agent管控，极少完全无监管纯网状。

四大常见辩论变体：
 
### 二元对抗

Pro‑Con 正反方
 
**角色**：正方Agent、反方Agent、仲裁Agent

**流程**：
1. **开篇**：双方各自输出开篇立论；
2. **辩论**：多轮互相反驳，针对对方论据找漏洞；
3. **总结**：Judge看完整辩论记录，综合双方输出最终答案，不是简单选输赢，而是整合有效信息。

**示例**：

技术选型：是否在业务中引入 Rust 重构核心服务

1. 正方 Agent（Round‑1）：主张引入 Rust；论据：内存安全、高性能、减少程序崩溃。
2. 反方 Agent（Round‑1）：反对大规模引入 Rust；论据：人才缺口大，不能利用现有 Python/Go 生态积累，会导致开发效率下降，且带来迁移风险。
3. 正方反驳（Round‑2）：可以局部核心链路小范围试点，不是全量重写。
4. 反方反驳（Round‑2）：试点同样带来两套技术栈维护成本，运维复杂度上升。
5. Judge：不简单选 “用 / 不用”，输出结论：局部热点模块试点 Rust，其余维持 Go，配套人才培养计划，取得性能与开发效率的平衡。

> 注意：Agent 被 prompt 锁死立场。哪怕正方内心知道对方部分有理，它的任务依然是捍卫本方立场；求真交给 Judge，避免和稀泥（huò xī ní）。
