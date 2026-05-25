---
title: "梯度下降"
weight: 40
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：梯度下降</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-02-05 | 更新时间：2026-02-25
</div>

计算机学习数据中隐藏的规律的方法，是通过最小化预测值与实际值之间的误差来实现的。

除了通过前文讲述的[最小二乘法](../3-lsm/)，还可以通过**梯度下降**（Gradient Descent）实现，即通过多轮运算不断更新模型参数 $\boldsymbol{\theta}$ 的值，使得误差逐渐变小，直至达到一个较小的阈值。

# 什么是梯度下降

> [!TIP]
> 当你站在高山的顶部，想以最快的速度下山，那么最快的方式是朝着最陡的方向行进

预测值与实际值之间的误差就是一座名为“误差”的高山，误差越大，山越高。

使用不同的模型参数，会得到不同的误差，相当于位于高山的不同位置。

你想通过改变模型参数，以最快的速度下山。

梯度下降，就是朝着令误差函数减小最快的方向更新参数，沿着最陡峭的方向下山。

![梯度下降](/images/docs/linear-regression/mountain-descent.png)

# 梯度下降算法

梯度下降算法的核心思想是沿着损失函数梯度的负方向迭代更新参数，以达到损失函数的最小值。具体步骤如下：

设 $\epsilon_k > 0$ 为学习率（决定每次更新的步长），$k$ 为迭代计数器，$k = 1,2,\dots$
* **初始化**：随机初始化参数 $\boldsymbol{\theta}$
* **迭代更新**：当未收敛时：
    * 从训练集中选取 $m$ 个样本 $\left \\{ \boldsymbol{x} _1, \cdots , \boldsymbol{x} _m \right \\}$ 及对应的标签 $\left \\{ y_1, \cdots , y_m \right \\}$
    * 计算梯度 $\boldsymbol{g} \leftarrow \nabla_{\boldsymbol{\theta}} \frac{1}{m} \sum_{i=1}^m L(f(\boldsymbol{x} _{i},\boldsymbol{\theta}), y _{i})$，其中 $L$ 为损失函数，用于衡量单个样本的预测值 $f(\boldsymbol{x} _{i},\boldsymbol{\theta})$ 与真实标签 $y _{i}$ 之间的误差。在线性回归中，常用的损失函数是均方误差损失
    * 计算更新 $\boldsymbol{\theta} \leftarrow \boldsymbol{\theta} - \epsilon_k \boldsymbol{g}$

# 计算梯度

回到前面的例子，因为训练数据规模不大（$N=1000$），我们把所有样本数据作为一个批次去训练。

均方误差损失函数为
```katex
J(\boldsymbol{\theta}) 
:= \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2
= \frac{1}{N} \sum_{i=1}^{N} (y_i - \boldsymbol{x}_i \boldsymbol{\theta})^2
```

> 其中各个符号的定义请见[上一篇文章](../3-lsm/#变量定义)

对各个参数取**偏导数**（Partial Derivative），便可以得到梯度$\boldsymbol{g}$
```katex
\begin{aligned}
\boldsymbol{g} := \nabla_{\boldsymbol{\theta}} J(\boldsymbol{\theta}) \\
&= \nabla_{\boldsymbol{\theta}} \frac{1}{N} \sum_{i=1}^{N} (y_i - \boldsymbol{x}_i \boldsymbol{\theta})^2 \\
&= \frac{1}{N} \sum_{i=1}^{N} \nabla_{\boldsymbol{\theta}} (y_i - \boldsymbol{x}_i \boldsymbol{\theta})^2 \\
&= \frac{1}{N} \sum_{i=1}^{N} -2(y_i - \boldsymbol{x}_i \boldsymbol{\theta}) \boldsymbol{x}_i \\
&= \frac{2}{N} \sum_{i=1}^{N} (\boldsymbol{x}_i \boldsymbol{\theta} - y_i) \boldsymbol{x}_i \\
\end{aligned}
```

得到的梯度$\boldsymbol{g}$是一个向量（shape $d \times 1$），其中的每一个值都分别代表$w_1$ ~ $w_d$的梯度。

# 代码实现
```python
# Using Gradient Descent (GD) to Solve Linear Regression

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Set random seed for reproducibility
np.random.seed(42)

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

# ===================== 第三步：梯度下降法求解权重 =====================
def gradient_descent(X, y, learning_rate=0.0001, epochs=150000, tol=1e-6):
    """
    梯度下降法求解线性回归参数
    参数：
        X：未添加截距项的特征矩阵
        y：因变量
        learning_rate：学习率
        epochs：最大迭代次数
        tol：收敛阈值
    返回：截距b，权重w，损失历史
    """
    n_samples, n_features = X.shape
    # 初始化权重（随机正态分布）
    w = np.random.randn(n_features)
    b = np.random.randn()
    loss_history = []  # 记录损失变化
    
    for epoch in range(epochs):
        # 前向预测：y_pred = b + X·w
        y_pred = b + np.dot(X, w)
        # 计算均方误差损失
        loss = np.mean((y_pred - y) ** 2)
        loss_history.append(loss)
        
        # 计算梯度
        dw = (2 / n_samples) * np.dot(X.T, (y_pred - y))  # 权重梯度
        db = (2 / n_samples) * np.sum(y_pred - y)         # 截距梯度
        
        # 更新参数
        w -= learning_rate * dw
        b -= learning_rate * db
        
        # 收敛判断
        if epoch > 0 and abs(loss_history[-1] - loss_history[-2]) < tol:
            print(f"\n梯度下降在第{epoch}轮收敛！")
            break
    
    return b, w, loss_history

# 求解梯度下降解
b, w, loss_history = gradient_descent(X, y, learning_rate=0.0001, epochs=150000)
print("\n===== Linear Regression Solution =====")
print(f"Intercept (bias): {b:.4f}")
print(f"Weights: {np.round(w, 4)}")

# 绘制梯度下降损失曲线（科普可视化）
plt.figure(figsize=(10, 4))
plt.plot(loss_history, color='blue', linewidth=1)
plt.title('Gradient Descent Loss Curve (MSE)', fontsize=12)
plt.xlabel('Iterations', fontsize=10)
plt.ylabel('Loss (MSE)', fontsize=10)
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig('lr-4-gd.png', dpi=150, bbox_inches='tight')
plt.show()
print("Image was saved as 'lr-4-gd.png'")
```

注意到计算梯度的代码
```python
# 计算梯度
dw = (2 / n_samples) * np.dot(X.T, (y_pred - y))  # 权重梯度
db = (2 / n_samples) * np.sum(y_pred - y)         # 截距梯度
```
与上面的梯度计算公式
```katex
\boldsymbol{g}
= \frac{2}{N} \sum_{i=1}^{N} (\boldsymbol{x}_i \boldsymbol{\theta} - y_i) \boldsymbol{x}_i \\
```
是一致的，都是每一个数据样本的特征值$\times$（预测值与真实值的差）再求和。

程序输出：
```text
梯度下降在第100511轮收敛！

===== Linear Regression Solution =====
Intercept (bias): 1.3568
Weights: [  0.4948   6.0379   0.8301 -14.781    8.9308   1.4749   7.0404]
Image was saved as 'gradient-descent.png'
```
![训练过程损失变化](/images/docs/linear-regression/gradient-descent.png)

最后的学习结果并没有与[标准答案](../2-model/#标准答案)的一致，这体现了梯度下降的一个特点，**相对接近而不是精确还原**。

与前的最小二乘法相比，梯度下降法的优势在于它可以处理大规模数据集，特别地当数据集包含噪声或异常值时，梯度下降法更稳定，但梯度下降过程中可能会落入局部最优解（山腰上的某个坑洼区域）而止步不前，此时可以调整参数$\boldsymbol{\theta}$的初始值或学习率$\epsilon_k$的大小多次尝试。
