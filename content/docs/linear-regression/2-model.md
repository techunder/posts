---
title: "建模"
weight: 20
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：建模</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

# 问题描述
假设我们通过对1000人进行了长期跟踪与统计，得到一份包含寿命影响因素和最终寿命的数据集（模拟生成，字段见[多元线性回归模型](#多元线性回归模型)）：

{{< button href="/attachments/docs/linear-regression/lifespan_data_full.csv" >}}点击下载数据集 (.csv){{< /button >}}
{{% details "代码：生成模拟数据（阅读过程无需理解这份代码）" %}}
```python
```
{{% /details %}}

数据集的前5行如下：
| 序号 | parent_lifespan | gender | exercise_hours | smoking | diet_health | sleep_hours | stress_level | actual_lifespan |
|------|-----------------|--------|----------------|---------|-------------|-------------|--------------|-----------------|
| 1    | 77.5            | 0      | 7.2            | 0       | 0           | 7.1         | 0            | 56.0            |
| 2    | 74.3            | 1      | 0.7            | 1       | 0           | 5.4         | 2            | 47.0            |
| 3    | 78.2            | 0      | 0.7            | 1       | 0           | 5.7         | 1            | 43.0            |
| 4    | 82.6            | 1      | 0.1            | 1       | 1           | 7.3         | 1            | 61.0            |
| 5    | 73.8            | 0      | 9.6            | 1       | 1           | 6.2         | 2            | 62.0            |

拿到这个数据集后，我们决定使用线性回归模型来表示特征与寿命的关系。我们已经知道了模型公式$\hat{y} = \boldsymbol{w} \boldsymbol{x}$，接下来可以开始求解模型的权重系数了。

有两种方法，一种是**解析解**求解，是以纯数学的方式求解答案；另一种是**梯度下降**法求解，以工程化的方式通过迭代来不断逼近最优解。
