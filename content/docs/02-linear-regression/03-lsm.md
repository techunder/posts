---
title: "最小二乘法"
weight: 30
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：最小二乘法</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-02-06 | 更新时间：2026-05-25
</div>
{{< katex />}}

在[上一篇文章](../2-model/)，我们建立了线性回归模型，接下来我们要当一回数学家了。

本文计划使用**最小二乘法** (Least Squares Method) 的解析解求权重系数。

最小二乘法是通过**计算误差平方和的最小值**来求解模型参数的方法。

这是线性回归模型最烧脑的地方，需要做一些矩阵的运算，一旦弄懂了，将会受益无穷。

来，都看到这了，别退缩 ~

我们先对变量做一下定义。

# 变量定义

[训练数据](../2-model/)的每一行可以表示为向量$[x_1, x_2, x_3, x_4, x_5, x_6, x_7]$的形式，其中$x_1$ ~ $x_7$是样本的特征值，我们在后面添加一个固定的$x_8=1$作为与截距项相乘的系数（后面会看到这样做的好处），
得到$\boldsymbol{x}_i := [x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8] = [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1]$

为了表示的方便，我把$d$定义为特征维度（包括截距项系数$x_8=1$），即$d=8$。

我把样本数量定义为$N$，本训练数据集$N=1000$。

把上面每一行的向量按行堆叠起来，就得到了特征矩阵$\boldsymbol{X}$（shape $N \times d = 1000 \times 8$），
```katex
\boldsymbol{X} 
:= \begin{bmatrix} 
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
= \begin{bmatrix} \boldsymbol{x}_1 \\\\ 
\boldsymbol{x}_2 \\\\ 
\vdots \\\\ 
\boldsymbol{x}_N 
\end{bmatrix} 
```

我们定义$\boldsymbol{\theta}$为要学习的权重系数向量（shape $d \times 1$），包含$w_1$ ~ $w_7$以及截距项 $w_d=b$ 一共8个系数，
```katex
\boldsymbol{\theta}
:=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ b \end{bmatrix}
=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ w_d \end{bmatrix}
```

假设我们已经知道模型的参数$\boldsymbol{\theta}$，那么通过参数$\boldsymbol{\theta}$可以计算出数据集的预测值$\hat{\boldsymbol{y}}$（shape $N \times 1 = 1000 \times 1$），
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

把每一行的$y$实际寿命值（称为 ground truth）组合起来也可以表示为一个向量的形式（shape $N \times 1 = 1000 \times 1$），
```katex
\boldsymbol{y} 
:= \begin{bmatrix} y_1 \\\\ y_2 \\\\ \vdots \\\\ y_N \end{bmatrix}
```

# 最小化误差

当我们直接使用胡乱猜测的$\boldsymbol{\theta}$去计算预测寿命，效果当然是不理想的，我们的目标是让计算机学习数据集的规律，得到符合数据规律的$\boldsymbol{\theta}$值。

计算机的自我学习过程是这样的，一开始我们胡乱地给$\boldsymbol{\theta}$赋予一个初始值，根据上面的公式计算出的预测值$\hat{\boldsymbol{y}} = \boldsymbol{X} \boldsymbol{\theta}$，然后和实际数据的目标值$\boldsymbol{y}$（即寿命）相比较，得到误差（这个误差也叫经验风险 empirical risk）。

我们的目标是最小化这个误差。所以接下来我们把这个误差以数学公式的方式表达出来，然后求其最小值就搞定了。

我们使用**均方误差**（Mean Squared Error）来作为经验风险的指标，公式为：

```katex
J(\boldsymbol{\theta}) := \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2
```

> 实际值$y_i$减去预测值$\hat{y}_i$得到误差，取其平方得到一个为正的误差的平方，再把所有记录的误差值的平方平均一下就得到平均误差，均方误差由此得名，代表平均平方误差。

$J(\boldsymbol{\theta})$就是我们的目标函数（也叫损失函数 loss function），接下来我们是去想，当参数$\boldsymbol{\theta}$取什么值时函数$J(\boldsymbol{\theta})$的值最小，用数学表达就是：
```katex
\min_{\boldsymbol{\theta}} J(\boldsymbol{\theta}) := \min_{\boldsymbol{\theta}} \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2
```

# L2范数
上面我们得到的目标函数$J(\boldsymbol{\theta})$是以循环历遍的方式求值的，表达不简洁，计算效率不高，如果能用矩阵运算的方式来表示就好了。

> [!TIP]
> 在机器学习领域，如果能够以矩阵形式表达，通常可以大大提升计算效率，且公式会很简约

于是我们想到了**L2范数**（欧几里得范数 L2 norm)，因为$\sum_{i=1}^{N} (y_i - \hat{y}_i)^2$这部分和L2范数的平方很像。

向量$\boldsymbol{z} := \begin{bmatrix} z_1 \\\\ z_2 \\\\ \vdots \\\\ z_N \end{bmatrix}$的L2范数被定义为：
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

# 目标函数
回到我们的目标函数$J(\boldsymbol{\theta})$, 想象$z_i$就是$y_i - \hat{y}_i$，于是
```katex
\begin{aligned}
J(\boldsymbol{\theta}) 
&:= \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2 \\
&= \frac{1}{N} ||\boldsymbol{y} - \hat{\boldsymbol{y}}||_2^2 \\
&= \frac{1}{N} (\boldsymbol{y} - \hat{\boldsymbol{y}})^T (\boldsymbol{y} - \hat{\boldsymbol{y}}) \\
&= \frac{1}{N} (\boldsymbol{y} - \boldsymbol{X} \boldsymbol{\theta})^T (\boldsymbol{y} - \boldsymbol{X} \boldsymbol{\theta}) \\
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - \boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta} - (\boldsymbol{X} \boldsymbol{\theta})^T \boldsymbol{y} + (\boldsymbol{X} \boldsymbol{\theta})^T \boldsymbol{X} \boldsymbol{\theta} \right) \\
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - \boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta} - \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{y} + \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta} \right) \\
\end{aligned}
```
> 这里用到了矩阵乘法的转置公式 $(\boldsymbol{A}\boldsymbol{B})^T = \boldsymbol{B}^T \boldsymbol{A}^T$

这里我们分析一下其中一项 $\boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta}$ 的形状，

$\boldsymbol{y}$是($N \times 1$)的列向量，$\boldsymbol{y}^T$是($1 \times N$)的行向量，

$\boldsymbol{X}$是($N \times d$)的矩阵，

$\boldsymbol{\theta}$是($d \times 1$)的列向量，

所以$\boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta}$得($1 \times N$)($N \times d$)($d \times 1$)=($1 \times 1$)，是一个标量。

而标量的转置等于它本身，于是
```katex
\boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta} = (\boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta})^T = \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{y}
```
> 这里用到了矩阵乘法的转置公式 $(\boldsymbol{A}\boldsymbol{B}\boldsymbol{C})^T = \boldsymbol{C}^T \boldsymbol{B}^T \boldsymbol{A}^T$

代入回目标函数，我们有：
```katex
\begin{aligned}
J(\boldsymbol{\theta}) 
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - \boldsymbol{y}^T \boldsymbol{X} \boldsymbol{\theta} - \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{y} + \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta} \right) \\
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{y} - \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{y} + \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta} \right) \\
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - 2 \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{y} + \boldsymbol{\theta}^T \boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta} \right)
\end{aligned}
```

# 求解最优值
终于到最后一步了，仔细看看这个函数，它是关于$\boldsymbol{\theta}$的二次函数，这个函数的值永远 $\ge 0$（均方误差的最小值为零）。

要计算这样一个二次函数的最小值，最简单的方法是对其关于自变量 $\boldsymbol{\theta}$ 求导，并设导数为 0，就会得到最优解。

对 $J(\boldsymbol{\theta})$ 关于 $\boldsymbol{\theta}$ 求导，得到：
```katex
\nabla_{\boldsymbol{\theta}} J(\boldsymbol{\theta})
= \frac{1}{N} \left( -2\boldsymbol{X}^T \boldsymbol{y} + 2\boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta} \right)
```
> 这里用到矩阵的求导公式 $\frac{\partial}{\partial{\boldsymbol{A}}} \left( \boldsymbol{A}^T \boldsymbol{B} \right) = \boldsymbol{B}$，以及 $\frac{\partial}{\partial{\boldsymbol{A}}} \left( \boldsymbol{A}^T \boldsymbol{B} \boldsymbol{A} \right) = 2\boldsymbol{B} \boldsymbol{A}$

设导数为0，即可得到最优解 $\boldsymbol{\theta}^*$：
```katex
\nabla_{\boldsymbol{\theta}} J(\boldsymbol{\theta}^*) = 0
```
```katex
\frac{1}{N} \left( -2\boldsymbol{X}^T \boldsymbol{y} + 2\boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta}^* \right) = 0
```
```katex
\boldsymbol{X}^T \boldsymbol{X} \boldsymbol{\theta}^* = \boldsymbol{X}^T \boldsymbol{y}
```
```katex
\fbox{$
\boldsymbol{\theta}^* = \left( \boldsymbol{X}^T \boldsymbol{X} \right)^{-1} \boldsymbol{X}^T \boldsymbol{y}
$}
```

至此，大功告成，如果你一直跟到这里，那么恭喜你，你已经掌握了线性回归的最小二乘法解析解的完整数学推理过程。如果还没有完全理解，请多花点时间重新仔细阅读上面的内容。

现在请静下心来，欣赏一下最后这个优美的方框内的公式。

后面的路就简单了，只需要编写代码，代入公式就可以实现了。

# 代码实现

在[问题与建模](../2-model/)一篇中，我们提供了[数据集](/attachments/docs/02-linear-regression/lifespan_data_full.csv)，现在请把它下载到本地。

我们的思路是，读取数据集，将其转换为NumPy数组，然后代入前面推导的最小二乘法最优解公式。

1. 导入依赖包。
我们使用到了NumPy和Pandas这两个Python库。
```python
import numpy as np
import pandas as pd
```

2. 数据装载。
读取数据集，提取特征矩阵和目标列。为了方便后续的模型评估，我们将前900个样本用于训练，后100个样本用于模型评估。
```python
# 读取CSV文件
df = pd.read_csv('lifespan_data_full.csv')

# 提出特征矩阵
X0 = df[['parent_lifespan', 'gender', 'exercise_hours', \
        'smoking', 'diet_health', 'sleep_hours', 'stress_level']].values

# 提出目标列
y0 = df['actual_lifespan'].values

# 使用前900个样本进行训练（保留后100个样本用于模型评估）
X = X0[0:900]
y = y0[0:900]
```

3. 为特征矩阵拼接偏置项系数1。
对应公式中红色的部分：
$\left( 
\boldsymbol{X}^T 
\color{red}
\boldsymbol{X} 
\color{black}
\right)^{-1} 
\boldsymbol{X}^T 
\boldsymbol{y}$
```python
# 原始特征矩阵加上偏置项系数列（全1）
X_with_bias = np.column_stack([X, np.ones(len(X))])
```

4. 特征矩阵转置。
对应公式中红色的部分：
$\left( 
\color{red}
\boldsymbol{X}^T 
\color{black}
\boldsymbol{X} 
\right)^{-1} 
\color{red}
\boldsymbol{X}^T 
\color{black}
\boldsymbol{y}$
```python
# 计算 X^T
X_T = X_with_bias.T
```

5. 计算 $\boldsymbol{X}^T \boldsymbol{X}$。
对应公式中红色的部分：
$\left( 
\color{red}
\boldsymbol{X}^T 
\boldsymbol{X} 
\color{black}
\right)^{-1} 
\boldsymbol{X}^T 
\boldsymbol{y}$
```python
# 计算 X^T X
X_T_X = X_T @ X_with_bias
```

6. 求 $\boldsymbol{X}^T \boldsymbol{X}$ 的逆矩阵。
这是最小二乘法解析解最关键的部分，NumPy提供了`linalg.inv`函数可以直接使用。
对应公式中红色的部分：
$\color{red}
\left( 
\boldsymbol{X}^T 
\boldsymbol{X} 
\right)^{-1} 
\color{black}
\boldsymbol{X}^T 
\boldsymbol{y}$
```python
# 检查 X^T X 是否可逆
if np.linalg.matrix_rank(X_T_X) != X_T_X.shape[0]:
    raise ValueError("X^TX matrix is not invertible!")

# 计算 (X^T X)^{-1}
INV = np.linalg.inv(X_T_X)
```

> 矩阵只有秩等于其阶数时才可逆。这里我们使用了NumPy的`linalg.matrix_rank`函数来计算矩阵的秩，来判断矩阵是否可逆。

7. 计算出最优解。
$\boldsymbol{\theta}^* = 
\color{red}
\left( 
\boldsymbol{X}^T 
\boldsymbol{X} 
\right)^{-1} 
\boldsymbol{X}^T 
\boldsymbol{y}
\color{black}$
```python
theta = INV @ X_T @ y
```

8. 提取权重和偏置项。
```python
b = theta[-1]  # 偏置项（截距）
w = theta[:-1]  # 权重系数
print("偏置项:", b)
print("权重系数:", w)
```

{{% details title="完整 Python 代码" open=false %}}
```python
# Using Least Squares Method (LSM) to Solve Linear Regression

import numpy as np
import pandas as pd

# read the CSV file
df = pd.read_csv('lifespan_data_full.csv')

# show the first 5 rows of the dataframe
print(df.head())

# extract the features and target variable
X0 = df[['parent_lifespan', 'gender', 'exercise_hours', \
        'smoking', 'diet_health', 'sleep_hours', 'stress_level']].values
y0 = df['actual_lifespan'].values

# use the first 900 samples for training (100 samples are left for model evaluation)
X = X0[0:900]
y = y0[0:900]

# append bias (1 column of ones)
X_with_bias = np.column_stack([X, np.ones(len(X))])

# calculate X^T
X_T = X_with_bias.T

# calculate X^T X
X_T_X = X_T @ X_with_bias

# check if X^T X is invertible
if np.linalg.matrix_rank(X_T_X) != X_T_X.shape[0]:
    raise ValueError("X^TX matrix is not invertible!")

# calculate (X^T X)^{-1}
theta = np.linalg.inv(X_T_X) @ X_T @ y

# extract the weights and intercept
w = theta[:-1]  # weights
b = theta[-1]  # intercept (bias)

# print the weights and intercept
print("\n===== Linear Regression Solution =====")
print(f"Intercept (bias): {b:.4f}")
print(f"Weights: {np.round(w, 4)}")
```
{{% /details %}}

现在可以回到[问题与建模](../2-model/)一章查看生成数据所用的权重系数$\boldsymbol{w}$和偏置项$b$，看看你计算出来的结果是否和[标准答案](../2-model/#标准答案)一致。

上面代码的输出为
```text
===== Linear Regression Solution =====
Intercept (bias): 10.0000
Weights: [  0.4   6.    0.8 -15.    9.    1.3   7. ]
```

与标准答案一致的。

上面的计算过程是否非常精准而优雅？但现实中，由于数据噪声（由异常数据、采样精度等引起），矩阵$\boldsymbol{X}^T \boldsymbol{X}$可能不可逆，无法直接计算，且由于高维多特征数据的最小二乘法的计算复杂度非常高 - $O(d^3)$，这就要用到下一篇介绍的**梯度下降**方法 - 算法复杂度仅为 $O(nd)$。
