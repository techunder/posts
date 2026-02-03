---
title: "解析解"
weight: 30
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：解析解</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

在[上一篇文章](../2-model/)，我们建立了线性回归模型，接下来我们要当一回数学家了。

本文计划使用最小二乘法的解析解求权重系数。

这是线性回归模型最烧脑的地方，需要做一些矩阵的运算，一旦弄懂了，将会受益无穷。

来，都看到这了，别退缩 ~

# 解析解

我们先对变量做一下定义：

-----todo

- $\boldsymbol{w}$：权重系数向量（$8 \times 1$），包含截距项$b$和$w_1$到$w_7$共8个系数。
- $\boldsymbol{X}$：特征矩阵（$1000 \times 8$），包含1000行样本，8列特征（包括截距项$x_0=1$）。
- $\boldsymbol{y}$：实际寿命向量（$1000 \times 1$），包含1000个样本的实际寿命值。

因为我们的模型公式是：
```katex
\hat{y} = \boldsymbol{w}^T \boldsymbol{x}
```
我们可以将其写成矩阵形式：
```katex
\hat{y} = X w
```
这为通过未知数$w$计算出来的预期寿命$\hat{y}$，但和真实的实际寿命$y$之间存在误差。我们的目标是通过最小化这个误差来求解最优的权重系数$w$。

误差通过均方误差（MSE）来计算：
```katex
MSE = \frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2
```

下一步，我们要解出权重系数$w$。根据线性回归的数学模型，我们可以得到解析解的公式：
```katex
w = (X^T X)^{-1} X^T y
```

接下来，可以开始通过Python代码实现解析解求解模型的权重系数了。代码如下
```python
import numpy as np

# 读取数据集
data = np.genfromtxt('lifespan_data_full.csv', delimiter=',', skip_header=1)

# 提取特征和目标变量
X = data[:, :-1]  # 所有列 кроме最后一列
y = data[:, -1]   # 最后一列

# 添加截距项
X = np.column_stack((np.ones(len(X)), X))

# 计算权重系数
w = np.linalg.inv(X.T @ X) @ X.T @ y

print("权重系数:", w)
```