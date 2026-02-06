---
title: "问题与建模"
weight: 20
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：问题与建模</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

经过[上一篇文章](../1-concept/)，我们对线性回归模型有了个初步的印象，接下来我们考察一个具体的问题。

# 问题描述
假设我们通过对1000人进行了长期跟踪与统计，得到一份包含寿命影响因素和最终寿命的数据集（模拟生成，字段见上一篇的<a href="../1-concept/#多元线性回归模型" target="_blank" rel="noopener noreferrer">多元线性回归模型</a>
）：

{{< button href="/attachments/docs/linear-regression/lifespan_data_full.csv" >}}点击下载数据集 (.csv){{< /button >}}

数据集的前5行如下：
| 序号 | parent_lifespan | gender | exercise_hours | smoking | diet_health | sleep_hours | stress_level | actual_lifespan |
|------|-----------------|--------|----------------|---------|-------------|-------------|--------------|-----------------|
| 1    | 77.5            | 0      | 7.2            | 0       | 0           | 7.1         | 0            | 56.0            |
| 2    | 74.3            | 1      | 0.7            | 1       | 0           | 5.4         | 2            | 47.0            |
| 3    | 78.2            | 0      | 0.7            | 1       | 0           | 5.7         | 1            | 43.0            |
| 4    | 82.6            | 1      | 0.1            | 1       | 1           | 7.3         | 1            | 61.0            |
| 5    | 73.8            | 0      | 9.6            | 1       | 1           | 6.2         | 2            | 62.0            |

# 建立模型
拿到这个数据集后，我们决定使用线性回归模型来表示特征与寿命的关系。

我们已经知道了模型公式
```katex
\hat{y} := w_1 x_1 + w_2 x_2 + w_3 x_3 + w_4 x_4 + w_5 x_5 + w_6 x_6 + w_7 x_7 + b
```

因为numpy等Python库已实现了矩阵的乘法，为了更好地利用这些库实现计算，我们接下来使用矩阵表示以上的模型公式。

在特征后面加个常数1，可表示为向量的形式（$1 \times 8$）：
```katex
\boldsymbol{x} := [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1]
```

权重参数加上截距项$b$也表示为向量的形式（$8 \times 1$）：
```katex
\boldsymbol{w} := \begin{bmatrix} w_1 \\ w_2 \\ w_3 \\ w_4 \\ w_5 \\ w_6 \\ w_7 \\ b \end{bmatrix}
```

按矩阵的乘法法则，模型的预测值就可以写成：
```katex
\hat{y} 
:= [x_1, x_2, x_3, x_4, x_5, x_6, x_7, 1] \cdot \begin{bmatrix} w_1 \\ w_2 \\ w_3 \\ w_4 \\ w_5 \\ w_6 \\ w_7 \\ b \end{bmatrix}
= \boldsymbol{x} \boldsymbol{w}
```

> 矩阵($1 \times 8$)与矩阵($8 \times 1$)相乘会得到一个($1 \times 1$)的标量。

其中的简洁矩阵相乘的形式就是我们模型的最终表示形式：
```katex
\fbox{$
\hat{y} = \boldsymbol{x} \boldsymbol{w}
$}
```

接下来可以开始求解模型的权重系数了。

求解有两种方法，一种是**最小二乘法**求解，是以纯数学的方式求解答案；另一种是**梯度下降**法求解，以工程化的方式通过迭代来不断逼近最优解。

> 关注网页底部公众号，发送"xwne"可获取可直接运行的生成以上测试集数据的源代码。