---
title: "AI Agent OpenMemory"
weight: 202
bookCollapseSection: true
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">AI Agent MemGPT</div>
<div class="page-info">
   <span class="original-tag">整理</span>
  发布时间：2026-07-06 | 更新时间：2026-07-06
</div>
{{< katex />}}

本文解读开源项目 [**OpenMemory**](https://github.com/CaviraOSS/OpenMemory) 的知识结构。

# 五层分区记忆

- 外显记忆（可主动口述、有意识回忆）
    - Episodic 情景记忆：带时间、场景的个人经历（海马体主导）
    - Semantic 语义记忆：客观事实、知识、偏好（新皮层存储）
- 内隐记忆（无意识、技能 / 条件反射）
    - Procedural 程序记忆：操作流程、习惯、技能（基底神经节）
    - Emotional 情绪条件记忆：事件附带情绪感受（杏仁核）
- 元认知记忆（高级人类独有）
    - Reflective 反思记忆：自我复盘、总结经验、修正认知（前额叶）

OpenMemory 直接把这五类脑内独立记忆系统，拆成五个隔离存储分区，每一层对应独立向量编码、独立遗忘衰减速率、独立检索逻辑。

---

# 参考资料
- **OpenMemory 项目**： [https://github.com/CaviraOSS/OpenMemory](https://github.com/CaviraOSS/OpenMemory) 
