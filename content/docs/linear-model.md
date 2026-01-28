---
title: "线性回归模型"
weight: 20
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->

<div style="text-align: center; font-weight: 700; font-size: 18px;">线性回归模型</div>
<div style="text-align: center; color: #666; font-size: 14px; margin: 1em 0;">
   <span style="background-color: #f5f5f5; color: #999; padding: 0px 3px; border-radius: 4px; margin-right: 8px; font-size: 12px; border: 1px solid #eee;">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

# 线性模型介绍

## 从 “预测寿命” 读懂线性回归的核心逻辑
我们总在不经意间讨论寿命：“为什么有些老人明明不忌口，却能活到九十九？”，“坚持运动真的能延长寿命吗？”“遗传基因到底有多重要？”

这些问题的答案，藏在 “影响因素” 与 “寿命” 的关联里。而要把这种关联说清楚、算明白，**线性回归**就是最朴素也最强大的工具。它不是什么高深的 “算命神器”，而是帮我们从杂乱的生活数据中，找到规律的 “数据翻译官”。

这一章，我们就从 “预测寿命” 这个人人关心的话题切入，剥开线性回归的神秘外衣，看清它的核心逻辑。

## 线性回归到底在做什么？
先抛一个最简单的问题：“每周运动时间” 和 “预期寿命” 有什么关系？

假设我们统计了 100 个人的运动时长和最终寿命，把数据画成散点图：横轴是每周运动小时数，纵轴是寿命。你会发现一个模糊但明显的趋势 ——运动时间越长的人，寿命大概率也越长

| 世界卫生组织（WHO）推荐的成人每周运动时长：中等强度 2.5-5 小时，或高强度 1.25-2.5 小时，搭配 2 次力量训练，适用于 18-64 岁成年人。

线性回归要做的，就是在这些散点中，画一条 “最贴合” 的直线。

这条直线的方程可以写成：
