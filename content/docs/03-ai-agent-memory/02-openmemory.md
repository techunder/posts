---
title: "AI Agent OpenMemory"
weight: 202
bookCollapseSection: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">AI Agent MemGPT</div>
<div class="page-info">
   <span class="organized-tag">整理</span>
  发布时间：2026-07-06 | 更新时间：2026-07-06
</div>
{{< katex />}}

本文解读开源项目 [**OpenMemory**](https://github.com/CaviraOSS/OpenMemory) 的知识结构。

# 分区记忆

OpenMemory 是**数字化复刻了生物脑记忆系统**，按标准认知心理学对人类的长时记忆划分为 Episodic、Semantic、Procedural、Emotional、Reflective 五层记忆：

- **外显记忆**（可主动口述、有意识回忆）
    - **Episodic 情景记忆**：带时间、场景的个人经历（**海马体主导**）
    - **Semantic 语义记忆**：客观事实、知识、偏好（**新皮层存储**）
- 内隐记忆（无意识、技能 / 条件反射）
    - **Procedural 程序记忆**：操作流程、习惯、技能（**基底神经节**）
    - **Emotional 情绪记忆**：事件附带情绪感受（**杏仁核**）
- 元认知记忆（人类独有）
    - **Reflective 反思记忆**：自我复盘、总结经验、修正认知（**前额叶**）

OpenMemory 直接把这五类脑内独立记忆系统，拆成五个**隔离存储分区**，每一层对应**独立向量编码**、**独立遗忘衰减速率**、**独立检索逻辑**。

> 人类大脑机构请参考[**大脑组成**](/docs/98-biology/97-nervous-sys/#%E5%A4%A7%E8%84%91%E7%BB%84%E6%88%90)

{{% details title="**1. Episodic 情景记忆**（对应人脑自传事件记忆）" open=false %}}

**心理学依据**

Tulving 1972 年提出，「精神时间旅行」，存储绑定时间、上下文、对话内容，依赖**海马体**时序编码，人能回忆 “那天发生了什么完整过程”。

**工程设计**

- 存储：时间戳、事件时序、原始对话内容、会话 ID，不压缩原文；
- 检索：支持时间区间过滤、事件时序检索，还原完整聊天上下文；
- 遗忘：衰减速度中等，近期对话保留完整，久远会话自动提炼下沉至语义层；

**业务例子**

昨天和用户聊代码报错、上周一起梳理项目需求的完整对话。

> 对应 MemGPT：Recall Memory。

{{% /details %}}

{{% details title="**2. Semantic 语义记忆**（客观事实长期知识库）" open=false %}}

**心理学依据**

脱离场景的纯粹知识、客观事实、用户固定偏好，无需回忆事件就能直接 “知道”。长期存储在**大脑新皮层**，遗忘最慢、权重最高。

**工程设计**

- 存储：结构化事实、静态知识、用户偏好；
- 特性：冲突检测（用户信息更新自动覆盖旧事实）；
- 遗忘：五层里衰减最慢，长期置顶；

**业务例子**

代码编码规范、性能最佳实践、用户不吃香菜、编程语言偏好 Python。

> 对应 MemGPT：Core Memory + Archival Memory 合并能力。

{{% /details %}}

{{% details title="**3. Procedural 程序记忆**（技能/流程内隐记忆）" open=false %}}

**心理学依据**

非陈述性内隐记忆，“怎么做”。例如骑车、游泳、穿裤子、固定工作流程，无需刻意复述，重复使用会强化记忆强度。保存在**基底神经节**。

**工程设计**

- 存储：任务步骤、工具调用流程、固定操作习惯；
- 机制：重复执行同类任务自动强化记忆权重；
- 遗忘：低频流程快速衰减，高频操作长期保留；

**业务例子**

爬虫标准流程、Hermes Agent 调用 MCP 的固定步骤；

> MemGPT 无对应分层，是 OpenMemory 独有的工程扩展。

{{% /details %}}

{{% details title="**4. Emotional 情绪记忆**（情绪条件记忆）" open=false %}}

**心理学依据**

**杏仁核**绑定事件情绪，同样一件事，带强烈情绪的记忆留存更久；情绪会影响检索优先级，负面/正面感受作为记忆权重加成。

**工程设计**

- 存储：用户沟通情绪、语气偏好、敏感话题、正负反馈；
- 机制：高情绪权重记忆检索优先展示；
- 遗忘：情绪强度越高，遗忘曲线衰减越慢；

**业务例子**

用户讨厌被催促、遇到报错会烦躁、喜欢简洁回答。

> MemGPT 的三层记忆完全缺失情绪维度。

{{% /details %}}

{{% details title="**5. Reflective 反思记忆**（元认知复盘记忆）" open=false %}}

**心理学依据**

**前额叶**高级元认知，人类独有的自我复盘：总结过往错误、提炼经验、修正自身行为策略，属于对 “记忆的记忆”。

**工程设计**

- 存储：Agent 自我反思总结、历史失误、优化方案、长期经验沉淀；
- 机制：每次对话结束自动生成反思条目存入本层；
- 检索：做长期规划、复杂任务时优先调取；

**业务例子**

上次给用户方案太复杂被否决、以后优先输出极简代码、避开冗余解释。

> MemGPT 体系无独立反思分区，反思逻辑需要开发者自行实现。

{{% /details %}}

---

# 整体流程

1. 输入内容
2. 判断记忆类型：Episodic/Semantic/Procedural/Emotional/Reflective
3. 存入不同 memory sector
4. 生成 embedding + 关键词 + 元数据 + 时间信息
5. 建立记忆之间的关联图（Hierarchical Storage Graph / Temporal Graph）
6. 查询时综合：语义相似度（Relevance）+ 关键词 + 最近性（Recency/Decay）+ 重要性（Importance/Recalled） + 关联路径
7. 被召回的记忆会被强化；长期不用的记忆会衰减

有几个特点：

- **长期记忆不是聊天记录**  
    聊天记录是 raw log，memory 是被筛选、结构化、可召回、可衰减的信息。
- **记忆有类型**  
    情景（Episodic）/ 语义（Semantic）/ 程序（Procedural）/ 情绪（Emotional）/ 反思（Reflective）。
- **时间是一等公民**  
    sequence/created_at/recalled_at/valid_from/valid_to，不是简单的覆盖。
- **记忆会强化和遗忘**  
    经常被查到的记忆 salience 提升；长期不用的记忆衰减。
- **召回应可解释**  
    不只是返回“这个向量最相似”，还应该能解释哪些 memory 被命中、分数来自哪里、是否通过关联图扩展出来、为什么它排在前面。

核心概念可以参考文档：[Concepts](https://github.com/CaviraOSS/OpenMemory/blob/main/docs/concepts.md)

# SimHash and Hamming distance

**SimHash** (Similar Hash) 是一种局部敏感哈希（LSH, Locality Sensitive Hashing）。

核心特性：**相似内容 → 哈希值相似**；完全不同内容 → 哈希差异大。

> 普通哈希（MD5、SHA256）：输入微小改动，输出完全随机雪崩

```text
text → 分词 + 权重
vec = 64-bit 0
for word in words:
    h = hash64(word)
    for i in 0~63:
        if bit_i(h) == 1: vec[i] += weight
        else: vec[i] -= weight
simhash_bits[i] = 1 if vec[i]>0 else 0
```
> 其中 hash64() 可以是 MD5 的前 64-bit 或 后 64-bit（性能较差），也可以是 MurmurHash64 / CityHash64 / XXHash64

相似度判断：**汉明距离**（Hamming distance）。

**定义**：两个等长二进制串对应位置上不同比特的数量

> 例：1011 vs 1001 → Hamming distance = 1

两个 simhash 指纹对比，统计相同位置 bit 值不相等的数量 = 汉明距离。

以 64 位 simhash 经验阈值为例：
- 汉明距离 ≤3：高度相似（几乎同一篇，仅少量修改）
- 汉明距离 ≤5：近似文本
- 距离越大，内容差异越大

# 参考资料
- **OpenMemory 项目**： [https://github.com/CaviraOSS/OpenMemory](https://github.com/CaviraOSS/OpenMemory) 
