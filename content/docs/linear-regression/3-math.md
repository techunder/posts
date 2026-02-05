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

我们先对变量做一下定义。

## 变量定义

[训练数据](../2-model/)的每一行可以表示为向量$[x_1, x_2, x_3, x_4, x_5, x_6, x_7]$的形式，其中$x_1$到$x_7$是样本的特征值，我们在后面添加一个固定的系数$x_8=1$作为与截距项相乘的系数（后面会看到这样做的好处），
得到$\boldsymbol{x}_i = [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1] = [x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8]$

为了后面表示的方便，我把$d$定义为特征维度（包括截距项系数$x_8=1$），即$d=8$。

我把样本数量定义为$N$，即$N=1000$。

把上面每一行的向量按行堆叠起来，就得到了特征矩阵$\boldsymbol{X}$（$N \times d = 1000 \times 8$），
```katex
\boldsymbol{X} = \begin{bmatrix} \boldsymbol{x}_1 \\\\ \boldsymbol{x}_2 \\\\ \vdots \\\\ \boldsymbol{x}_N \end{bmatrix} 
= \begin{bmatrix} 
x_{11} & x_{12} & \cdots & 1 \\\\ 
x_{21} & x_{22} & \cdots & 1 \\\\ 
\vdots & \vdots & \vdots & \vdots \\\\ 
x_{N1} & x_{N2} & \cdots & 1 
\end{bmatrix}
= \begin{bmatrix} 
x_{11} & x_{12} & \cdots & x_{1d} \\\\ 
x_{21} & x_{22} & \cdots & x_{2d} \\\\ 
\vdots & \vdots & \vdots & \vdots \\\\ 
x_{N1} & x_{N2} & \cdots & x_{Nd} 
\end{bmatrix}
```

我们定义$\boldsymbol{\theta}$为要学习的权重系数向量（$d \times 1$），包含$w_1$到$w_7$以及截距项$w_d = b$一共8个系数，
```katex
\boldsymbol{\theta}
=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ b \end{bmatrix}
=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ w_d \end{bmatrix}
```

假设我们已经知道模型的参数$\boldsymbol{\theta}$，那么通过参数$\boldsymbol{\theta}$可以计算出数据集的预测值$\hat{\boldsymbol{y}}$（$N \times 1 = 1000 \times 1$），
```katex
\hat{\boldsymbol{y}}
= \begin{bmatrix} 
x_{11} & x_{12} & \cdots & x_{1d} \\\\ 
x_{21} & x_{22} & \cdots & x_{2d} \\\\ 
\vdots & \vdots & \vdots & \vdots \\\\ 
x_{N1} & x_{N2} & \cdots & x_{Nd} 
\end{bmatrix}
\cdot
\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ w_d \end{bmatrix}
= \boldsymbol{X} \boldsymbol{\theta}
```

把每一行的$y$实际寿命值（称为 ground truth）组合起来也可以表示为一个向量的形式（$N \times 1 = 1000 \times 1$），
```katex
\boldsymbol{y} 
= \begin{bmatrix} y_1 \\\\ y_2 \\\\ \vdots \\\\ y_N \end{bmatrix}
```

## 经验风险最小化

当我们直接使用胡乱猜测的$\boldsymbol{\theta}$去计算预测寿命，效果当然是很不好的，我们的目标是学习数据集的数据，发现其规律，得到符合数据规律的$\boldsymbol{\theta}$的值。

为了让计算机能够通过自我学习，我们需要把通过当前胡乱猜测的$\boldsymbol{\theta}$计算出的预测值和实际数据的寿命值相比较，得到误差值（也叫经验风险 empirical risk）。

我们计划使用均方误差（MSE）来作为经验风险的指标。

---
todo

```katex

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