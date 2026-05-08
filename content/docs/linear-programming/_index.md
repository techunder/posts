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

**线性规划**（Linear Programming）在工程领域中随处可见，是在有限资源的情况寻找最优解的方法。

典型场景：

- 生产计划：有限原料下最大化利润
- 配送路线：最小化运输成本
- 投资组合：在风险约束下最大化收益
- 人力排班：满足需求下最小化人工成本

下面通过一个简单的例子说明

# 题目

某工厂生产两种产品

- 产品 A：利润 3 万元/件，消耗资源 1：2 单位，资源 2：1 单位
- 产品 B：利润 5 万元/件，消耗资源 1：1 单位，资源 2：2 单位

资源 1 总量 10 单位，资源 2 总量 8 单位

请问应该如何安排生产，令利润最大化？

# 分析

线性规划通常把问题拆解如下：

- **决策变量**：就是求解的目标，对应上面的产品 A 的生产数量（设为 $x$）和产品 B 的生产数量（设为 $y$），本例就是求 $argmax_{x,y}\left(3x+5y\right)$
- **目标函数**：最大值（Max）或最小值（Min），本例中 $R=3x+5y$，求 $R$ 的最大值
- **约束条件**：本例是 $2x+y \le 10$，$x+2y \le 8$，$x \ge 0$，$y \ge 0$

# 单纯形法（Simplex Method）

这个是 George Dantzig 在 1947 年发表的论文 "Maximization of a Linear Function of Variables Subject to Linear Inequalities" 表述的方法，这是线性规划的第一个通用算法。

下面给出通俗的解读。

核心思想是，**以决策变量作为坐标轴，按约束条件在坐标空间中划出一个可行的空间区域，然后移动目标函数等高线，在可行域内寻找是目标函数最优的点**。


按上面的例子，我们有两个决策变量，$x$ 和 $y$，我们画出以 $x$ 和 $y$ 为轴的平面直角坐标系。

## 可行域

接下在画出可行域

- 有约束条件 1：$2x+y \le 10$，画出直线 $y=-2x+10$（图中的绿线），取其下面的部分
- 有约束条件 2：$x+2y \le 8$，画出直线 $y=-0.5x+4$（图中的蓝线），取其下面的部分
- 有约束条件 3：$x \ge 0$，即取 $y$ 轴右边的部分
- 有约束条件 4：$y \ge 0$，即取 $x$ 轴上面的部分

即可行域为由 $x$ 轴、$y$ 轴、直线 $y=-2x+10$、直线 $y=-0.5x+4$ 所围成的空间（图中黄色区域），是一个凸四边形。

<svg width="500" height="500" viewBox="-12 -12 24 24" style="background:#FFFFFF;">
  <!-- x axis -->
  <line x1="-11" y1="0" x2="11" y2="0" stroke="#333" stroke-width="0.12"/>
  <!-- x axis arrow -->
  <line x1="10.5" y1="-0.2" x2="11" y2="0" stroke="#333" stroke-width="0.1"/>
  <line x1="10.5" y1="+0.2" x2="11" y2="0" stroke="#333" stroke-width="0.1"/>
  <!-- x auxilliary lines -->
  <line x1="-11" y1="-1" x2="11" y2="-1" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-2" x2="11" y2="-2" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-3" x2="11" y2="-3" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-4" x2="11" y2="-4" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-5" x2="11" y2="-5" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-6" x2="11" y2="-6" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-7" x2="11" y2="-7" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-8" x2="11" y2="-8" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-9" x2="11" y2="-9" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-10" x2="11" y2="-10" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-11" x2="11" y2="-11" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="1" x2="11" y2="1" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="2" x2="11" y2="2" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="3" x2="11" y2="3" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="4" x2="11" y2="4" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="5" x2="11" y2="5" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="6" x2="11" y2="6" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="7" x2="11" y2="7" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="8" x2="11" y2="8" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="9" x2="11" y2="9" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="10" x2="11" y2="10" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="11" x2="11" y2="11" stroke="#999" stroke-width="0.01"/>
  <!-- y axis -->
  <line x1="0" y1="-11" x2="0" y2="11" stroke="#333" stroke-width="0.12"/>
  <!-- y axis arrow -->
  <line x1="0" y1="-11" x2="-0.2" y2="-10.5" stroke="#333" stroke-width="0.1"/>
  <line x1="0" y1="-11" x2="+0.2" y2="-10.5" stroke="#333" stroke-width="0.1"/>
  <!-- y auxilliary lines -->
  <line x1="-1" y1="-11" x2="-1" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-2" y1="-11" x2="-2" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-3" y1="-11" x2="-3" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-4" y1="-11" x2="-4" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-5" y1="-11" x2="-5" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-6" y1="-11" x2="-6" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-7" y1="-11" x2="-7" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-8" y1="-11" x2="-8" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-9" y1="-11" x2="-9" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-10" y1="-11" x2="-10" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-11" x2="-11" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="1" y1="-11" x2="1" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="2" y1="-11" x2="2" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="3" y1="-11" x2="3" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="4" y1="-11" x2="4" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="5" y1="-11" x2="5" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="6" y1="-11" x2="6" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="7" y1="-11" x2="7" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="8" y1="-11" x2="8" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="9" y1="-11" x2="9" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="10" y1="-11" x2="10" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="11" y1="-11" x2="11" y2="11" stroke="#999" stroke-width="0.01"/>
  <!-- scale -->
  <g font-size="0.5" fill="#666">
    <!-- x scale -->
    <text x="-10" y="0.7">-10</text>
    <text x="-9"  y="0.7">-9</text>
    <text x="-8"  y="0.7">-8</text>
    <text x="-7"  y="0.7">-7</text>
    <text x="-6"  y="0.7">-6</text>
    <text x="-5"  y="0.7">-5</text>
    <text x="-4"  y="0.7">-4</text>
    <text x="-3"  y="0.7">-3</text>
    <text x="-2"  y="0.7">-2</text>
    <text x="-1"  y="0.7">-1</text>
    <text x="+0"  y="0.7">0</text>
    <text x="+1"  y="0.7">1</text>
    <text x="+2"  y="0.7">2</text>
    <text x="+3"  y="0.7">3</text>
    <text x="+4"  y="0.7">4</text>
    <text x="+5"  y="0.7">5</text>
    <text x="+6"  y="0.7">6</text>
    <text x="+7"  y="0.7">7</text>
    <text x="+8"  y="0.7">8</text>
    <text x="+9"  y="0.7">9</text>
    <text x="+10" y="0.7">10</text>
    <text x="+11" y="0.7">x</text>
    <!-- y scale -->
    <text y="+10" x="-0.9">-10</text>
    <text y="+9"  x="-0.9">-9</text>
    <text y="+8"  x="-0.9">-8</text>
    <text y="+7"  x="-0.9">-7</text>
    <text y="+6"  x="-0.9">-6</text>
    <text y="+5"  x="-0.9">-5</text>
    <text y="+4"  x="-0.9">-4</text>
    <text y="+3"  x="-0.9">-3</text>
    <text y="+2"  x="-0.9">-2</text>
    <text y="+1"  x="-0.9">-1</text>
    <text y="-1"  x="-0.9">1</text>
    <text y="-2"  x="-0.9">2</text>
    <text y="-3"  x="-0.9">3</text>
    <text y="-4"  x="-0.9">4</text>
    <text y="-5"  x="-0.9">5</text>
    <text y="-6"  x="-0.9">6</text>
    <text y="-7"  x="-0.9">7</text>
    <text y="-8"  x="-0.9">8</text>
    <text y="-9"  x="-0.9">9</text>
    <text y="-10" x="-0.9">10</text>
    <text y="-11" x="-0.9">y</text>
  </g>
  <!-- line y = -2x + 10 -->
  <text x="3" y="-5" font-size="0.8" fill="green">y=-2x+10</text>
  <line x1="-0.5" y1="-11" x2="6" y2="2" stroke="green" stroke-width="0.1"/>
  <!-- line y = -2x + 10 -->
  <text x="7" y="-1" font-size="0.8" fill="blue">y=-0.5x+4</text>
  <line x1="-2" y1="-5" x2="10" y2="1" stroke="blue" stroke-width="0.1"/>
  <!-- polygon filled -->
  <polygon 
    points="0,0 5,0 4,-2 0,-4" 
    fill="rgba(255, 230, 80, 0.4)" 
    stroke="red" 
    stroke-width="0"
  />
  <!-- point (4,2) -->
  <text x="4" y="-2.3" font-size="0.8" fill="#333">(4,2)</text>
  <!-- line y = -(3/5)x + R/5 -->
  <text x="4" y="5.5" font-size="0.8" fill="red">y = -(3/5)x + R/5</text>
  <line x1="-7" y1="-4.2" x2="7.5" y2="4.5" stroke="red" stroke-width="0.1"/>
  <line x1="-5" y1="-7.4" x2="10" y2="1.6" stroke="red" stroke-width="0.1"/>
  <!-- vertical line of y = -(3/5)x + R/5-->
  <line x1="2.0588" y1="1.2353" x2="4" y2="-2" stroke="red" stroke-dasharray="0.2 0.2" stroke-width="0.05"/>
  <!-- its arrow -->
  <line x1="3.64" y1="-1.68" x2="4" y2="-2" stroke="red" stroke-width="0.05"/>
  <line x1="3.9" y1="-1.5" x2="4" y2="-2" stroke="red" stroke-width="0.05"/>
</svg>

## 目标直线
接下来我们看目标函数 $R=3x+5y$，我们的目标是求 $R$ 在约束条件下的最大值。

上式整理得 $y=-\frac{3}{5}x+\frac{R}{5}$。

可以看出，因为 $R$ 无论最终取什么值，它会是一个常数，也就是说最优解在斜率为 $-\frac{3}{5}$ 的一条直线上。

如果我们保持斜率不变，在与可行域有相交的范围内移动直线 $y=-\frac{3}{5}x + \frac{R}{5}$，使其与 $y$ 轴的截距 $\frac{R}{5}$ 最大，我们将得到最优解 $R$。

我们在原点 (0,0) 开始向右上方移动该直线，发现直线与 $y$ 轴的截距越来越大，最后当直线通过点 (4,2) 时，截距达到最大值，这个点恰恰是可行域凸四边形的一个顶点。

把点 (4,2) 代入方程 $R=3x+5y$ 就得到了 $R$ 的最大值 22。

即当产品 A 的生产数量为 4，产品 B 的生产数量为 2 时，可以获得最大利润 22 万元。

以上只是形象化的求解过程，因为**线性规划的目标函数是线性的，在凸多边形可行域上，最优解必定出现在边界顶点**，所以也可以直接把可行域凸多边形的各个顶点直接代入目标函数，找出最大值即可。

# 程序求解

## 方法一：scipy
```python
from scipy.optimize import linprog
import numpy as np

# 目标函数系数（scipy是最小化，所以利润取负）
c = [-3, -5]

# 约束矩阵（不等式约束 ≤）
A_ub = [[2, 1],   # 资源1
        [1, 2]]   # 资源2
b_ub = [10, 8]    # 资源上限

# 变量非负（默认，所以可以省略）
bounds = [(0, None), (0, None)]

result = linprog(c, A_ub=A_ub, b_ub=b_ub, bounds=bounds)
print(f"产品A: {result.x[0]\:.2f} 件")
print(f"产品B: {result.x[1]\:.2f} 件")
print(f"最大利润: {-result.fun:.2f} 万元")
```
输出
```text
```

## 方法二：PuLP
```python
# pip install pulp
from pulp import LpProblem, LpMaximize, LpVariable, lpSum, LpStatus

# 定义问题
prob = LpProblem("生产计划", LpMaximize)
x1 = LpVariable("产品A", 0)   # x1 ≥ 0
x2 = LpVariable("产品B", 0)  # x2 ≥ 0

# 目标函数
prob += 3*x1 + 5*x2, "利润"

# 约束
prob += 2*x1 + x2 <= 10, "资源1"
prob += x1 + 2*x2 <= 8, "资源2"

# 求解
prob.solve()
print(f"产品A: {value(x1):.2f} 件")
print(f"产品B: {value(x2):.2f} 件")
print(f"最大利润: {value(prob.objective):.2f} 万元")
```
输出
```text
```
