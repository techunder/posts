---
title: "非线性规划"
weight: 2
bookCollapseSection: false
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">非线性规划</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-06-15 | 更新时间：2026-06-15
</div>
{{< katex />}}

现实生活中，有些问题是非线性的，这就是非线性规划（Nonlinear Programming）

(关于基础概念和符号定义请看前文[线性规划（Linear Programming）](/docs/linear-programming/linear-programming/))

# 现实例子

老王是一名农夫，他想紧靠着屋墙围出一块长方形的地方养鸡。

他想围出尽可能大的地方，而手头上只有 8 米的篱笆，靠墙一侧不需要围栏。

请问他该如何设计长方形的边长才能围出最大面积的围栏？

<svg width="400" height="320" viewBox="0 0 10 8" style="background:#FFFFFF;">
  <!-- wall -->
  <line x1="0" y1="6" x2="10" y2="6" stroke="#333" stroke-width="0.12"/>
  <line x1="0.0" y1="6.2" x2="0.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="0.2" y1="6.2" x2="0.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="0.4" y1="6.2" x2="0.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="0.6" y1="6.2" x2="0.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="0.8" y1="6.2" x2="1.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="1.0" y1="6.2" x2="1.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="1.2" y1="6.2" x2="1.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="1.4" y1="6.2" x2="1.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="1.6" y1="6.2" x2="1.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="1.8" y1="6.2" x2="2.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="2.0" y1="6.2" x2="2.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="2.2" y1="6.2" x2="2.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="2.4" y1="6.2" x2="2.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="2.6" y1="6.2" x2="2.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="2.8" y1="6.2" x2="3.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="3.0" y1="6.2" x2="3.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="3.2" y1="6.2" x2="3.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="3.4" y1="6.2" x2="3.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="3.6" y1="6.2" x2="3.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="3.8" y1="6.2" x2="4.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="4.0" y1="6.2" x2="4.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="4.2" y1="6.2" x2="4.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="4.4" y1="6.2" x2="4.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="4.6" y1="6.2" x2="4.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="4.8" y1="6.2" x2="5.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="5.0" y1="6.2" x2="5.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="5.2" y1="6.2" x2="5.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="5.4" y1="6.2" x2="5.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="5.6" y1="6.2" x2="5.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="5.8" y1="6.2" x2="6.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="6.0" y1="6.2" x2="6.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="6.2" y1="6.2" x2="6.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="6.4" y1="6.2" x2="6.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="6.6" y1="6.2" x2="6.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="6.8" y1="6.2" x2="7.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="7.0" y1="6.2" x2="7.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="7.2" y1="6.2" x2="7.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="7.4" y1="6.2" x2="7.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="7.6" y1="6.2" x2="7.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="7.8" y1="6.2" x2="8.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="8.0" y1="6.2" x2="8.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="8.2" y1="6.2" x2="8.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="8.4" y1="6.2" x2="8.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="8.6" y1="6.2" x2="8.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="8.8" y1="6.2" x2="9.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="9.0" y1="6.2" x2="9.2" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="9.2" y1="6.2" x2="9.4" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="9.4" y1="6.2" x2="9.6" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="9.6" y1="6.2" x2="9.8" y2="6" stroke="#333" stroke-width="0.03"/>
  <line x1="9.8" y1="6.2" x2="10.0" y2="6" stroke="#333" stroke-width="0.03"/>
  <text x="4.7" y="6.8" font-size="0.4" fill="#333">Wall</text>
  <!-- length -->
  <line x1="3" y1="3" x2="7" y2="3" stroke="#333" stroke-width="0.05"/>
  <text x="4.9" y="2.8" font-size="0.4" fill="#333">x</text>
  <!-- width -->
  <line x1="3" y1="3" x2="3" y2="6" stroke="#333" stroke-width="0.05"/>
  <line x1="7" y1="3" x2="7" y2="6" stroke="#333" stroke-width="0.05"/>
  <text x="2.6" y="4.5" font-size="0.4" fill="#333">y</text>
  <text x="7.2" y="4.5" font-size="0.4" fill="#333">y</text>
  <!-- polygon filled -->
  <polygon 
    points="3,3 7,3 7,6 3,6" 
    fill="rgba(255, 230, 80, 0.4)" 
    stroke="red" 
    stroke-width="0"
  />
</svg>

# 数学表达

问题拆解如下：

- **决策变量**：设长方形靠墙的一边为长，长为 $x$ 米，宽为 $y$ 米，因为面积为 $xy$，所求就是 $argmax_{x,y}\left(xy\right)$

- **目标函数**：求面积的最大值（max），即 $max(xy)$

- **约束条件**：$x+2y=8$，$x \gt 0$，$y \gt 0$

> [!WARNING]
> 完整的数学表达为：$argmax_{x,y} \left(xy\right) \quad s.t. \quad x+2y=8, x>0, y>0$

> 因为目标函数为 $xy$，次数高于1，所以是非线性规划

# 数学求解

整理约束条件 $x+2y=8$ 得
```katex
x=8-2y
```

代入目标函数得
```katex
xy=(8-2y)y=-2y^2+8y
```
函数 $f(y)=-2y^2+8y$ 的图像是一条开口向下的抛物线

<svg width="500" height="500" viewBox="-12 -12 24 24" style="background:#FFFFFF;">
  <!-- x axis -->
  <line x1="-11" y1="0" x2="11" y2="0" stroke="#333" stroke-width="0.12"/>
  <!-- x axis arrow -->
  <line x1="10.5" y1="-0.2" x2="11" y2="0" stroke="#333" stroke-width="0.1"/>
  <line x1="10.5" y1="+0.2" x2="11" y2="0" stroke="#333" stroke-width="0.1"/>
  <!-- x auxilliary lines -->
  <line x1="-11" y1="-1"  x2="11" y2="-1"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-2"  x2="11" y2="-2"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-3"  x2="11" y2="-3"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-4"  x2="11" y2="-4"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-5"  x2="11" y2="-5"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-6"  x2="11" y2="-6"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-7"  x2="11" y2="-7"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-8"  x2="11" y2="-8"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-9"  x2="11" y2="-9"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-10" x2="11" y2="-10" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-11" x2="11" y2="-11" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="1"   x2="11" y2="1"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="2"   x2="11" y2="2"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="3"   x2="11" y2="3"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="4"   x2="11" y2="4"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="5"   x2="11" y2="5"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="6"   x2="11" y2="6"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="7"   x2="11" y2="7"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="8"   x2="11" y2="8"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="9"   x2="11" y2="9"   stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="10"  x2="11" y2="10"  stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="11"  x2="11" y2="11"  stroke="#999" stroke-width="0.01"/>
  <!-- y axis -->
  <line x1="0" y1="-11" x2="0" y2="11" stroke="#333" stroke-width="0.12"/>
  <!-- y axis arrow -->
  <line x1="0" y1="-11" x2="-0.2" y2="-10.5" stroke="#333" stroke-width="0.1"/>
  <line x1="0" y1="-11" x2="+0.2" y2="-10.5" stroke="#333" stroke-width="0.1"/>
  <!-- y auxilliary lines -->
  <line x1="-1" y1="-11"  x2="-1"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-2" y1="-11"  x2="-2"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-3" y1="-11"  x2="-3"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-4" y1="-11"  x2="-4"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-5" y1="-11"  x2="-5"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-6" y1="-11"  x2="-6"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-7" y1="-11"  x2="-7"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-8" y1="-11"  x2="-8"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-9" y1="-11"  x2="-9"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-10" y1="-11" x2="-10" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="-11" y1="-11" x2="-11" y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="1" y1="-11"   x2="1"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="2" y1="-11"   x2="2"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="3" y1="-11"   x2="3"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="4" y1="-11"   x2="4"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="5" y1="-11"   x2="5"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="6" y1="-11"   x2="6"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="7" y1="-11"   x2="7"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="8" y1="-11"   x2="8"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="9" y1="-11"   x2="9"   y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="10" y1="-11"  x2="10"  y2="11" stroke="#999" stroke-width="0.01"/>
  <line x1="11" y1="-11"  x2="11"  y2="11" stroke="#999" stroke-width="0.01"/>
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
    <text x="+11" y="0.7">y</text>
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
    <text y="-11" x="-0.9">f(y)</text>
  </g>
  <!-- path f(y)=-2y^2+8y -->
  <path d="M -1 10 Q 2 -26 5 10" stroke="#333" fill="none" stroke-width="0.06"/>
  <!-- point (2,8) -->
  <circle cx="2" cy="-8" r="0.10" fill="red" />
  <text x="1.3" y="-9" font-size="0.8" fill="#333">(2,8)</text>
</svg>

求这个函数的**导数**并让其等于 0 即可计算出抛物线的最值（因为开口向下，所以一定是最大值）

$f^'(y)=-2 \times 2y+8=0$ 得 $y=2$

当 $y=2$ 时，

$f(y) = -2y^2 + 8y = 8$

$x=8-2y=4$

也就是当长方形的长为 4 米，宽为 2 米时，鸡圈可达到最大面积 8 平方米。

# 程序求解

## 方法一：利用 Scipy

`Scipy` 有一个 [minimize](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html) 模块，可以很方便计算出非线性规划的最优解

```python
# pip install scipy
from scipy.optimize import minimize
import numpy as np

# 最小化目标函数：我们要最大化 xy，等价于最小化 -xy
def objective(x):
    return - (x[0] * x[1])  # x[0]=x, x[1]=y

# 等式约束：x + 2y = 8
def constraint(x):
    return x[0] + 2 * x[1] - 8

# 约束条件定义
cons = ({'type': 'eq', 'fun': constraint})

# 变量边界：x>0, y>0
bounds = ((1e-6, None), (1e-6, None))  # 用极小值代替严格>0

# 初始值（随便给一个满足约束的点）
x0 = np.array([2, 3])

# 求解
result = minimize(objective, x0, method='SLSQP', bounds=bounds, constraints=cons)

# 输出结果
print("求解状态：", result.success)
print("最优解 x =", round(result.x[0], 4))
print("最优解 y =", round(result.x[1], 4))
print("最大值 xy =", round(-result.fun, 4))
```

输出
```text
求解状态： True
最优解 x = 4.0
最优解 y = 2.0
最大值 xy = 8.0
```

## 方法一：利用 CVXPY

通过 [CVXPY](https://pypi.org/project/cvxpy/) 库也可以计算这种非线性规划问题，以更直观的方式通过表达式描述问题

```python
# pip install cvxpy
import cvxpy as cp

# 定义变量
x = cp.Variable(nonneg=True)
y = cp.Variable(nonneg=True)

# 目标函数
objective = cp.Maximize(x * y)

# 约束
constraints = [x + 2*y == 8]

# 构建问题
prob = cp.Problem(objective, constraints)

# 必须指定 solver=cp.SCS 且 qcp=True
prob.solve(qcp=True, solver=cp.SCS)

# 输出结果
print("最优解 x =", round(x.value, 4))
print("最优解 y =", round(y.value, 4))
print("最大值 xy =", round(prob.value, 4))
```

输出
```text
最优解 x = 4.0
最优解 y = 2.0
最大值 xy = 8.0
```
