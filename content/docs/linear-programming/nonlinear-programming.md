---
title: "非线性规划"
weight: 2
bookCollapseSection: false
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">非线性规划</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-05-11 | 更新时间：2026-05-11
</div>
{{< katex />}}

现实生活中，有些问题是非线性的，这就是非线性规划（Nonlinear Programming）

# 现实例子

老王是一名农夫，他想靠着屋子的墙围出一块长方形的地方养鸡。

他手上只有 8 米的篱笆，但他想围出尽可能大的地方，靠墙一侧不需要围栏。

请问他该如何设计长方形的边长才能围出最大面积的围栏？

# 数学表达

问题拆解如下：

- **决策变量**：就是求解的目标（decision variables），对应上面的产品 A 的生产数量（设为 $x$）和产品 B 的生产数量（设为 $y$），本例就是求 $argmax_{x,y}\left(3x+5y\right)$

- **目标函数**：最大值（max）或最小值（min），本例中求 $max(3x+5y)$

- **约束条件**：本例是 $2x+y \le 10$，$x+2y \le 8$，$x \ge 0$，$y \ge 0$

> [!WARNING]
> 完整的数学表达为：$argmax_{x,y} xy, \quad s.t. \quad x+2y=8, x>0, y>0$


<svg width="100%" height="320" viewBox="-210 -60 420 320">
  <line x1="-200" y1="200" x2="200" y2="200" stroke="#aaa"/>
  <line x1="0" y1="-50" x2="0" y2="250" stroke="#aaa"/>
  <path d="M -150 225 Q 0 0 150 225" stroke="#f44" fill="none" stroke-width="2"/>
</svg>

Scipy

[minimize](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html)

```python
from scipy.optimize import minimize
import numpy as np

# 目标函数：我们要最大化 xy，等价于 最小化 -xy
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

CVXPY

```python
import cvxpy as cp

# 定义变量
x = cp.Variable(positive=True)
y = cp.Variable(positive=True)

# 目标：最大化 xy
objective = cp.Maximize(x * y)

# 约束
constraints = [x + 2*y == 8]

# 求解
prob = cp.Problem(objective, constraints)
prob.solve()

print("x =", round(x.value, 4))
print("y =", round(y.value, 4))
print("max =", round(prob.value, 4))
```
