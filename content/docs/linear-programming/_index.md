---
title: "线性规划"
weight: 101
bookCollapseSection: false
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">线性规划</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-05-07 | 更新时间：2026-05-07
</div>
{{< katex />}}

**线性规划** （Linear Programming）在工程领域中随处可见，是在有限资源的情况寻找最优解的方法。

典型场景：

- 生产计划：有限原料下最大化利润
- 配送路线：最小化运输成本
- 投资组合：在风险约束下最大化收益
- 人力排班：满足需求下最小化人工成本

下面通过一个简单的例子说明线性规划的过程

# 题目

某工厂生产两种产品

- 产品A：利润 3万/件，消耗资源1：2单位，资源2：1单位
- 产品B：利润 5万/件，消耗资源1：1单位，资源2：2单位

资源1总量10单位，资源2总量8单位

请问应该如何安排生产，令利润最大化？

# 分析

线性规划通常把问题拆解如下：

- **决策变量**：就是要求解的目标，对应上面的产品A的生产数量（设为$x$）和产品B的生产数量（设为$y$），本例就是求$argmax_{x,y}\left(3x+5y\right)$
- **目标函数**：最大值（Max）或最小值（Min），本例中$Z=\left(3x+5y\right)$，求$Z$的最大值
- **约束条件**：本例是$2x+y \le 10$，$x+2y \le 8$，$x \ge 0$，$y \ge 0$

# 求解

## 

<svg width="400" height="400" viewBox="-10 -10 20 20" style="background:#f9f9f9;">
  <!-- x轴 -->
  <line x1="-9" y1="0" x2="9" y2="0" stroke="#333" stroke-width="0.2"/>
  <!-- y轴 -->
  <line x1="0" y1="-9" x2="0" y2="9" stroke="#333" stroke-width="0.2"/>
  <!-- 刻度 -->
  <g font-size="0.8" fill="#666">
    <text x="8.5" y="1">x</text>
    <text x="0.3" y="8.5">y</text>
    <!-- x刻度 -->
    <text x="-8" y="-0.5">-8</text>
    <text x="-6" y="-0.5">-6</text>
    <text x="-4" y="-0.5">-4</text>
    <text x="-2" y="-0.5">-2</text>
    <text x="2" y="-0.5">2</text>
    <text x="4" y="-0.5">4</text>
    <text x="6" y="-0.5">6</text>
    <text x="8" y="-0.5">8</text>
    <!-- y刻度 -->
    <text x="-1" y="-8">-8</text>
    <text x="-1" y="-6">-6</text>
    <text x="-1" y="-4">-4</text>
    <text x="-1" y="-2">-2</text>
    <text x="-1" y="2">2</text>
    <text x="-1" y="4">4</text>
    <text x="-1" y="6">6</text>
    <text x="-1" y="8">8</text>
  </g>
  <!-- 直线 y = 0.5x + 2 -->
  <line x1="-8" y1="-2" x2="8" y2="6" stroke="red" stroke-width="0.1"/>
  <text x="2" y="4" font-size="1" fill="red">y=0.5x+2</text>
</svg>
