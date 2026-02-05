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
得到$\boldsymbol{x}_i := [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1] = [x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8]$

为了后面表示的方便，我把$d$定义为特征维度（包括截距项系数$x_8=1$），即$d=8$。

我把样本数量定义为$N$，即$N=1000$。

把上面每一行的向量按行堆叠起来，就得到了特征矩阵$\boldsymbol{X}$（$N \times d = 1000 \times 8$），
```katex
\boldsymbol{X} := \begin{bmatrix} \boldsymbol{x}_1 \\\\ \boldsymbol{x}_2 \\\\ \vdots \\\\ \boldsymbol{x}_N \end{bmatrix} 
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

我们定义$\boldsymbol{\theta}$为要学习的权重系数向量（$d \times 1$），包含$w_1$到$w_7$以及截距项 $w_d=b$ 一共8个系数，
```katex
\boldsymbol{\theta}
:=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ b \end{bmatrix}
=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ w_d \end{bmatrix}
```

假设我们已经知道模型的参数$\boldsymbol{\theta}$，那么通过参数$\boldsymbol{\theta}$可以计算出数据集的预测值$\hat{\boldsymbol{y}}$（$N \times 1 = 1000 \times 1$），
```katex
\hat{\boldsymbol{y}}
:= \begin{bmatrix} 
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
:= \begin{bmatrix} y_1 \\\\ y_2 \\\\ \vdots \\\\ y_N \end{bmatrix}
```

## 最小化误差

当我们直接使用胡乱猜测的$\boldsymbol{\theta}$去计算预测寿命，效果当然是很不理想的，我们的目标是让计算机学习数据集的规律，得到符合数据规律的$\boldsymbol{\theta}$值。

计算机的自我学习过程是这样的，一开始我们胡乱地给$\boldsymbol{\theta}$赋予一个初始值，根据上面的公式计算出的预测值$\hat{\boldsymbol{y}} = \boldsymbol{X} \boldsymbol{\theta}$，然后和实际数据的目标值$\boldsymbol{y}$（即寿命）相比较，得到误差（这个误差也叫经验风险 empirical risk）。

我们的目标是最小化这个误差。所以接下来我们把这个误差以数学公式的方式表达出来，然后求其最小值就搞定了。

我们计划使用**均方误差**（Mean Squared Error）来作为经验风险的指标，公式为：

```katex
J(\boldsymbol{\theta}) := \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2
```

> 实际值$y_i$减去预测值$\hat{y}_i$得到误差，取其平方得到一个为正的误差的平方，再把所有记录的误差值的平方平均一下就得到平均误差，均方误差就因此而得名，代表平均平方误差。

$J(\boldsymbol{\theta})$就是我们的目标函数（也叫损失函数 loss function），接下来我们的目标是去想参数$\boldsymbol{\theta}$取什么值时函数$J(\boldsymbol{\theta})$的值最小，用数学表达就是：
```katex
\min_{\boldsymbol{\theta}} J(\boldsymbol{\theta}) := \min_{\boldsymbol{\theta}} \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2
```

## L2范数
上面我们得到的目标函数$J(\boldsymbol{\theta})$固然是好，但它是以循环历遍的方式求值，表达不够简洁，计算效率也不高，如果能用矩阵运算的方式来表示就更好了，于是我们想到了**L2范数**（欧几里得范数， L2 norm)，因为$\sum_{i=1}^{N} (y_i - \hat{y}_i)^2$这部分和L2范数的平方很像。

L2范数的定义是这样的：

假设有一个向量$\boldsymbol{z} := \begin{bmatrix} z_1 \\\\ z_2 \\\\ \vdots \\\\ z_N \end{bmatrix}$，它的L2范数被定义为：
```katex
||\boldsymbol{z}||_2 := \sqrt{\sum_{i=1}^{d} z_i^2}
```

那么L2范数的平方为：
```katex
||\boldsymbol{z}||_2^2 := \sum_{i=1}^{d} z_i^2
```

它有一个很简约的数学表示：
```katex
||\boldsymbol{z}||_2^2 
= \sum_{i=1}^{d} z_i^2
= [z_1, z_2, \cdots, z_N] \cdot
\begin{bmatrix} z_1 \\\\ z_2 \\\\ \vdots \\\\ z_N \end{bmatrix}
= \boldsymbol{z}^T \boldsymbol{z}
```

## 目标函数表示
回到我们的目标函数$J(\boldsymbol{\theta})$, 想象$z_i$就是$y_i - \hat{y}_i$，于是
```katex
\begin{aligned}
J(\boldsymbol{\theta}) 
&:= \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2 \\
&= \frac{1}{N} ||\boldsymbol{y} - \hat{\boldsymbol{y}}||_2^2 \\
&= \frac{1}{N} (\boldsymbol{y} - \hat{\boldsymbol{y}})^T (\boldsymbol{y} - \hat{\boldsymbol{y}})
\end{aligned}
```
> 这里用到了矩阵的转置和乘法, $$





---
todo

下一步，我们要解出权重系数$w$。根据线性回归的数学模型，我们可以得到解析解的公式：
```katex
w = (X^T X)^{-1} X^T y
```

接下来，可以开始通过Python代码实现解析解求解模型的权重系数了。代码如下
```python
import numpy as np
```