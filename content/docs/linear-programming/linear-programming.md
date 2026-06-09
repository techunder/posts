---
title: "线性规划"
weight: 1
bookCollapseSection: false
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">线性规划</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-05-07 | 更新时间：2026-06-08
</div>
{{< katex />}}

**线性规划**（Linear Programming）在工程领域中随处可见，是在有限资源的情况寻找最优解的方法。

> [!WARNING]
> 目标函数和限制条件都必须是线性方程 / 线性不等式（最高次项为1）才能称为线性规划

典型场景：

- 生产计划：有限原料下最大化利润
- 配送路线：最小化运输成本
- 投资组合：在风险约束下最大化收益
- 人力排班：满足需求下最小化人工成本

下面通过一个简单的例子说明

# 现实例子

某工厂生产两种产品

- 产品 A: 利润 3 万元/件，消耗资源1: 2 单位，消耗资源2: 1 单位
- 产品 B: 利润 5 万元/件，消耗资源1: 1 单位，消耗资源2: 2 单位

资源 1 总量 10 单位，资源 2 总量 8 单位

请问应该如何安排生产，令利润最大化？

# 数学表达

线性规划通常把问题拆解如下：

- **决策变量**：就是求解的目标（decision variables），对应上面的产品 A 的生产数量（设为 $x$）和产品 B 的生产数量（设为 $y$），本例就是求 $argmax_{x,y}\left(3x+5y\right)$
    > [!TIP]
    > $argmax_{x,y}\left(3x+5y\right)$ 表示 $x$ 和 $y$ 取何值时，函数 $f(x,y)=3x+5y$ 取得最大值

- **目标函数**：最大值（max）或最小值（min），本例中求 $max(3x+5y)$
    > [!TIP]
    > $max(3x+5y)$ 表示函数 $f(x,y)=3x+5y$ 的最大值

- **约束条件**：本例是 $2x+y \le 10$，$x+2y \le 8$，$x \ge 0$，$y \ge 0$

> [!WARNING]
> 完整的数学表达为：$argmax_{x,y}\left(3x+5y\right) \quad \text{s.t.} \quad 2x+y \le 10, x+2y \le 8, x \ge 0, y \ge 0$

> [!TIP]
> $\text{s.t.}$ 为 subject to 的缩写，意思为：约束于、受制于、满足于

# 单纯形法

单纯形法（Simplex Method）是 George Dantzig 在 1947 年发表的论文 "Maximization of a Linear Function of Variables Subject to Linear Inequalities" 表述的方法，这是线性规划的第一个通用算法。

下面给出通俗的解读。

核心思想是，**以决策变量作为坐标轴，按约束条件在坐标空间中划出一个可行的空间区域，然后移动目标函数等高线，在可行域内寻找是目标函数最优的点**。


按上面的例子，我们有两个决策变量，$x$ 和 $y$，我们画出以 $x$ 和 $y$ 为轴的平面直角坐标系。

## 可行域

接下在画出可行域

- 有约束条件 1：$2x+y \le 10$，画出直线 $y=-2x+10$（图中的<font color='green'>绿线</font>），取其下面的部分
- 有约束条件 2：$x+2y \le 8$，画出直线 $y=-0.5x+4$（图中的<font color='blue'>蓝线</font>），取其下面的部分
- 有约束条件 3：$x \ge 0$，即取 $y$ 轴右边的部分
- 有约束条件 4：$y \ge 0$，即取 $x$ 轴上面的部分

即可行域为由 $x$ 轴、$y$ 轴、直线 $y=-2x+10$、直线 $y=-0.5x+4$ 所围成的空间（图中<font color='orange'>黄色区域</font>），是一个凸四边形。

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
接下来我们看目标函数 $f(x,y)=3x+5y$，我们的目标是在约束条件下求函数 $f(x,y)$ 的最大值。

设最大值为 R，即 $R=3x+5y$ ，整理得 $y=-\frac{3}{5}x+\frac{R}{5}$。

也就是说，$R$ 无论最终取什么值，解一定落在上面这条直线上，而这条直线的斜率固定为 $-\frac{3}{5}$，截距为$\frac{R}{5}$。

如果我们保持直线斜率不变，在与可行域有相交的范围内移动直线 $y=-\frac{3}{5}x + \frac{R}{5}$（图中的<font color='red'>红线</font>），使其与 $y$ 轴的截距 $\frac{R}{5}$ 尽可能大，我们将得到最优解 $R$。

我们在原点 (0,0) 开始向右上方移动该直线（图中的<font color='red'>红色虚线</font>所示），发现直线与 $y$ 轴的截距越来越大，当直线通过点 (4,2) 时，截距达到最大值，直线与可行域恰恰相交于可行域凸四边形的一个顶点上。

该顶点为直线 $y=-2x+10$ 与直线 $y=-0.5x+4$ 的交点，解以这个两个方程组成的二元一次函数，得到交点为 (4,2)。

把点 (4,2) 代入方程 $R=3x+5y$ 就得到了 $R$ 的最大值 22。

即当产品 A 的生产数量为 4，产品 B 的生产数量为 2 时，可以获得最大利润 22 万元。

以上只是形象化的求解过程，因为**线性规划的目标函数和约束条件都是线性的，最优解必定出现在可行域凸多边形的边界顶点上**，所以也可以直接把可行域凸多边形的各个顶点直接代入目标函数，直接找出最大值。

# 程序求解


## 方法一：利用 Scipy

`Scipy` 有一个 [`linprog`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.linprog.html) 模块，可以很方便计算出线性规划的最优解。

只需要给出**目标函数系数**、**约束条件系数**和**目标变量取值范围**。

### 1. 目标函数系数 c

前面例子的目标函数为 $f(x,y)=3x+5y$，求最大值，即求 $max(3x+5y)$。

但 `Scipy` 是固定计算最小值的，我们需要把目标函数转换成求最小值。

把系数取负号（赚得最多=亏得最少），即 $f(x,y)=-3x-5y$，求 $min(-3x-5y)$

所以得到目标函数的系数为
```python
c = [-3, -5]
```

### 2. 约束条件系数 $A_{ub}$ $b_{ub}$

`Scipy` 要求约束条件必须为 $\le$ 的形式。

本例的约束条件有

- $2x+y \le 10$
- $x+2y \le 8$

已满足 $\le$ 的形式，无需再化解。

所以约束条件系数为
```python
A_ub = [[2, 1],   # 不等约束矩阵
        [1, 2]]
b_ub = [10, 8]    # 不等约束上限
```

> 本例的约束条件为不等约束（$\le$），如果是相等约束，则使用 $A_{eq}$ 和 $b_{eq}$ 参数，写法类似，详情参数参考 [API 文档](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.linprog.html) 

### 3. 目标变量取值范围 bounds

我们再看看目标变量的取值范围。

本例中

- $x \ge $0
- $y \ge 0$

所以目标变量 $x$ 和 $y$ 的取值范围为
```python
# None 表示没有限制
bounds = [(0, None), (0, None)]
```

### 4. 完整 Python 代码

```python
# pip install scipy
from scipy.optimize import linprog

# 目标函数系数（scipy是最小化，所以利润取负）
c = [-3, -5]

# 约束矩阵（不等式约束 ≤）
A_ub = [[2, 1],   # 约束条件系数1
        [1, 2]]   # 约束条件系数2
b_ub = [10, 8]    # 约束上限

# 目标变量的取值范围
bounds = [(0, None), (0, None)]

result = linprog(c, A_ub=A_ub, b_ub=b_ub, bounds=bounds)
print(f"产品 A: {result.x[0]: .2f} 件")
print(f"产品 B: {result.x[1]: .2f} 件")
print(f"最大利润: {-result.fun: .2f} 万元")
```

输出
```text
产品 A:  4.00 件
产品 B:  2.00 件
最大利润:  22.00 万元
```

## 方法二：利用 PuLP

通过 [`PuLP`](https://pypi.org/project/PuLP/) 库计算线性规划的最优解更直观，
只需要定义目标变量，然后组装目标函数和约束条件的表达式即可。

```python
# pip install pulp
from pulp import LpProblem, LpMaximize, LpVariable, value

# 定义问题
prob = LpProblem("生产计划", LpMaximize) # LpMaximize 表示求最大值
x1 = LpVariable("产品 A", 0)  # x1 ≥ 0
x2 = LpVariable("产品 B", 0)  # x2 ≥ 0

# 目标函数
prob += 3*x1 + 5*x2     # 利润

# 约束
prob += 2*x1 + x2 <= 10 # 资源1
prob += x1 + 2*x2 <= 8  # 资源2

# 求解
prob.solve()
print(f"产品 A: {value(x1):.2f} 件")
print(f"产品 B: {value(x2):.2f} 件")
print(f"最大利润: {value(prob.objective):.2f} 万元")
```

输出
```text
产品 A: 4.00 件
产品 B: 2.00 件
最大利润: 22.00 万元
```

# 结语

本文主要讲解了线性规划的数学原理和程序通用解法。现实生活中，有还有很多问题是非线性的，这就会用到下一篇的[非线性规划（Nonlinear Programming）](/docs/linear-programming/nonlinear-programming/)
