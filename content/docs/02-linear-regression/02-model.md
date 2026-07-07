---
title: "问题与建模"
weight: 20
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：问题与建模</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-02-04 | 更新时间：2026-05-25
</div>
{{< katex />}}

[上一篇文章](../1-concept/)，介绍了什么事线性回归模型，接下来考察一个具体的问题。

# 问题描述
假设我们通过对1000人进行了长期跟踪统计，得到一份包含寿命影响因素和最终寿命的数据集（模拟生成，字段见[多元线性回归模型](../1-concept/#多元线性回归模型)）：

{{< button href="/attachments/docs/02-linear-regression/lifespan_data_full.csv" >}}点击下载数据集 (.csv){{< /button >}}

{{% details title="生成测试数据集的 Python 代码" open=false %}}
```python
# Generate a Test Dataset for Linear Regression Model

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Set random seed for reproducibility
np.random.seed(42)

# == 1. Generate sample size (1000 samples, balance between efficiency and representativeness)
n_samples = 1000

# == 2. Generate 7 independent variables (simulate according to authoritative ranges)
parent_lifespan = np.random.normal(75, 5, n_samples)  # Parent average lifespan: 75±5 years
gender = np.random.randint(0, 2, n_samples)           # Gender: 0=male, 1=female
exercise_hours = np.random.uniform(0, 10, n_samples)  # Weekly exercise duration: 0-10 hours
smoking = np.random.randint(0, 2, n_samples)          # Smoking: 0=non-smoker, 1=smoker
diet_health = np.random.randint(0, 2, n_samples)      # Diet health: 0=unhealthy, 1=healthy
sleep_hours = np.random.uniform(5, 9, n_samples)      # Daily sleep duration: 5-9 hours
stress_level = np.random.randint(0, 3, n_samples)     # Stress level: 0=high, 1=moderate, 2=low

# == 3. Set true weights (core parameters)
true_b = 10  # Base lifespan value
true_w = np.array([
    0.4,    # Parent average lifespan weight
    6,      # Gender weight
    0.8,    # Weekly exercise duration weight
    -15,    # Smoking weight (negative, largest absolute value)
    9,      # Diet health weight
    1.3,    # Daily sleep duration weight
    7       # Stress/mental health weight
])

# == 4. Construct feature matrix X and dependent variable y
X = np.column_stack([
    parent_lifespan, gender, exercise_hours, 
    smoking, diet_health, sleep_hours, stress_level
])

# == 5. Calculate actual lifespan: y = b + X·w
y = true_b + np.dot(X, true_w)

# == 6. Wrap into DataFrame and save
data = pd.DataFrame({
    'parent_lifespan': parent_lifespan,
    'gender': gender,
    'exercise_hours': exercise_hours,
    'smoking': smoking,
    'diet_health': diet_health,
    'sleep_hours': sleep_hours,
    'stress_level': stress_level,
    'actual_lifespan': y
})
data.to_csv('./lifespan_data_full.csv', index=False)

# == 7. View dataset basic information
print("===== Dataset Basic Information =====")
print(f"Dataset Shape: {data.shape}")
print("\nFirst 5 Rows of the Dataset:")
print(data.head())
print("\nDataset Descriptive Statistics:")
print(data.describe())
```
{{% /details %}}

{{% details title="数据潜藏的规律" %}}
上面的数据是通过以下权重系数生成的，权重系数是这份数据隐藏的底层规律。线性回归的目标就是通过数据集学习到权重系数。请阅完后面的章节后，再回到这里对比自己计算的结果是否与此标准答案一致。

### 标准答案

$b=10$

$w_1=0.4, w_2=6, w_3=0.8, w_4=-15, w_5=9, w_6=1.3, w_7=7$
{{% /details %}}


数据集的前5行如下：
| 序号 | parent_lifespan | gender | exercise_hours | smoking | diet_health | sleep_hours | stress_level | actual_lifespan |
|------|-----------------|--------|----------------|---------|-------------|-------------|--------------|-----------------|
| 1    | 77.5            | 0      | 7.2            | 0       | 0           | 7.1         | 0            | 56.0            |
| 2    | 74.3            | 1      | 0.7            | 1       | 0           | 5.4         | 2            | 47.0            |
| 3    | 78.2            | 0      | 0.7            | 1       | 0           | 5.7         | 1            | 43.0            |
| 4    | 82.6            | 1      | 0.1            | 1       | 1           | 7.3         | 1            | 61.0            |
| 5    | 73.8            | 0      | 9.6            | 1       | 1           | 6.2         | 2            | 62.0            |

# 建立模型

我们已决定使用线性回归模型来表示特征与寿命的关系。

[上一篇文章](../1-concept/)中我们已经知道了模型公式
```katex
\hat{y} := w_1 x_1 + w_2 x_2 + w_3 x_3 + w_4 x_4 + w_5 x_5 + w_6 x_6 + w_7 x_7 + b
```

因为NumPy等Python库已实现了矩阵的乘法，为了方便利用库实现计算，我们使用矩阵表示模型公式。

权重参数加上截距项$b$可以表示为向量的形式（shape $8 \times 1$）：
```katex
\boldsymbol{w} := \begin{bmatrix} w_1 \\ w_2 \\ w_3 \\ w_4 \\ w_5 \\ w_6 \\ w_7 \\ b \end{bmatrix}
```

在特征后面加个常数1，也可表示为向量的形式（shape $1 \times 8$）：
```katex
\boldsymbol{x} := [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1]
```

> 加上1，是方便在矩阵运算时与截距项$b$结合

按矩阵的乘法法则，模型的预测值就可以写成：
```katex
\hat{y} 
:= [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1] \cdot \begin{bmatrix} w_1 \\ w_2 \\ w_3 \\ w_4 \\ w_5 \\ w_6 \\ w_7 \\ b \end{bmatrix}
= \boldsymbol{x} \boldsymbol{w}
```
> 上式展开后，你会发现和我们之前看到的公式$\hat{y} := w_1 x_1 + w_2 x_2 + w_3 x_3 + w_4 x_4 + w_5 x_5 + w_6 x_6 + w_7 x_7 + b$是一样的。

> 矩阵(shape $1 \times 8$)与矩阵(shape $8 \times 1$)相乘会得到一个($1 \times 1$)的标量。

所得到的简洁的矩阵相乘的形式就是我们模型的最终表示形式：
```katex
\fbox{$
\hat{y} = \boldsymbol{x} \boldsymbol{w}
$}
```

接下来可以开始求解模型的权重系数。

求解有两种方法，一种是**最小二乘法**求解，是以纯数学的方式求解答案；另一种是**梯度下降**法求解，以工程化的方式通过迭代来不断逼近最优解。

下一篇[最小二乘法](../3-lsm/)见。
