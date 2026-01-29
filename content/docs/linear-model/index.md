---
title: "线性回归模型"
weight: 20
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归模型</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

线性回归模型作为一种经典的机器学习模型，是接触机器学习的入门模型，也是理解其他更复杂模型的基础。虽然它简单，但所涉及的概念和数学原理，对后续学习其他模型都有重要意义。本文就让我们一道通过一个简单的例子，深入浅出地学习一下这个经典模型，把它的概念和底层数学原理也弄得明明白白。

# 什么是线性模型
---
我们都知道，人的寿命受很多因素的影响。比如：

- 遗传基因：遗传基因是影响寿命的最基本因素。
- 环境因素：天气、生活环境、压力环境等，都对寿命有影响。
- 个人因素：年龄、性别、体重、运动时间、饮食习惯等，也会影响寿命。

在影响因素与寿命的关联里，我们可以使用**线性回归**模型，通过因素“预测”寿命。
线性回归模型是最朴素也是最强大的工具，可以帮我们发现大量数据下，因素之间隐藏的相关关系。

## 一元线性回归模型
先抛一个最简单的问题：每周运动时间和预期寿命有什么关系？

假设我们统计了100个人的运动时长和最终寿命，把数据画成散点图：横轴是每周运动小时数，纵轴是寿命。你会发现一个模糊但明显的趋势 —— 运动时间越长的人，寿命大概率也越长

> 世界卫生组织（WHO）推荐的成人每周运动时长：中等强度 2.5-5 小时，或高强度 1.25-2.5 小时，搭配 2 次力量训练，适用于 18-64 岁成年人。

![每周运动时间和预期寿命的关系](images/exercise_hours_and_lifespan.png)

{{% details "生成模拟数据和图表的源代码" %}}
```python
import numpy as np
import matplotlib.pyplot as plt

# ---------------------- 解决中文显示问题 ----------------------
plt.rcParams['font.sans-serif'] = ['Noto Sans CJK JP', 'Droid Sans Fallback']
plt.rcParams['axes.unicode_minus'] = False  # 解决负号显示异常

# ---------------------- 1. 生成贴合WHO标准的模拟数据 ----------------------
np.random.seed(42)  # 固定随机种子，结果可复现
n_people = 100  # 100个样本
max_exercise = 5  # WHO推荐中等强度运动上限：5小时/周（300分钟）
mean_exercise = 2.5  # WHO推荐基础值：2.5小时/周（150分钟）

# 生成运动时长：正态分布（均值2.5，标准差1），更贴合大众实际分布
exercise_hours = np.random.normal(loc=mean_exercise, scale=1, size=n_people)
# 过滤异常值：运动时长≥0，且≤5小时
exercise_hours = np.clip(exercise_hours, 0, max_exercise)

# 生成寿命数据：基础寿命70岁 + 边际效益递减的运动收益 + 随机波动
base_lifespan = 70  # 基础寿命
# 运动收益：用平方根函数实现“边际效益递减”（运动越久，每小时收益越少）
exercise_benefit = 8 * np.sqrt(exercise_hours / max_exercise)  # 5小时时收益约8岁
# 随机噪声（正态分布），模拟个体差异
random_noise = np.random.normal(loc=0, scale=1.5, size=n_people)
lifespan = base_lifespan + exercise_benefit + random_noise

# ---------------------- 2. 绘制散点图 ----------------------
plt.figure(figsize=(10, 6))

# 绘制散点图
plt.scatter(
    exercise_hours, lifespan, 
    color='steelblue', alpha=0.7, s=50,
    label='个体数据'
)

# 绘制趋势线（更贴合边际效益递减的非线性趋势）
# 用多项式拟合（2次），比线性趋势更符合科学规律
z = np.polyfit(exercise_hours, lifespan, 1)
p = np.poly1d(z)
# 生成平滑的x轴数据，让趋势线更美观
x_smooth = np.linspace(0, max_exercise, 100)
plt.plot(
    x_smooth, p(x_smooth), 
    color='crimson', linewidth=2, 
    label='收益趋势线'
)

# 标注WHO推荐区间
plt.axvspan(2.5, 5, color='lightgreen', alpha=0.3, label='WHO推荐区间（2.5-5小时/周）')
plt.axvline(x=2.5, color='forestgreen', linestyle='--', alpha=0.8, label='WHO基础推荐值（2.5小时/周）')

# ---------------------- 3. 完善标注 ----------------------
plt.title('每周运动时长与寿命的关系（模拟数据）', fontsize=14, pad=15)
plt.xlabel('每周中等强度运动时长（小时）', fontsize=12)
plt.ylabel('寿命（岁）', fontsize=12)
plt.xlim(-0.2, max_exercise + 0.2)  # x轴范围
plt.ylim(68, 82)  # y轴范围
plt.grid(True, alpha=0.3)
plt.legend(loc='lower right')

# 显示图表
plt.tight_layout()
plt.show()

# 输出核心统计信息
corr = np.corrcoef(exercise_hours, lifespan)[0, 1]
print(f'运动时长与寿命的相关系数：{corr:.2f}（正相关，符合科学预期）')
print(f'平均运动时长：{np.mean(exercise_hours):.1f}小时/周（接近WHO基础推荐值2.5小时）')
print(f'平均寿命：{np.mean(lifespan):.1f}岁')
```
{{% /details %}}


> [!TIP]
> 线性回归要做的，就是在这些散点中，画一条最贴合的直线。

这条直线的方程可以写成：
```katex
\hat{y} = b + w \times x
```
- $y$：预期寿命
- $x$：每周运动小时数
- $b$：截距项
- $w$：权重系数

这里的两个参数，就是线性回归的核心：

$b$：截距项（bias），可以理解为 “基础寿命值” —— 哪怕一个人完全不运动，也能拥有的寿命基数；

$w$：权重系数（weight），代表 “运动时长对寿命的影响力度” —— 权重越大，说明运动对寿命的提升作用越明显。

放到生活里，这个方程就是一句大白话：你的基础寿命，加上运动带来的增益，就是你的预期寿命。

而当影响因素变多（比如遗传、饮食、吸烟），线性回归也能轻松应对 —— 只需要给每个因素分配一个权重，把它们的影响加起来就行。这就是多元线性回归，也是本文的核心模型。

## 多元线性回归模型
为了让模型有科学依据，参考《Nature》《柳叶刀》等顶刊的研究结论，筛选出7个影响寿命的核心因素：

| 影响因素 | 英文名| 数学代号 | 量化方式 |
|----------|----------|----------|----------|
| 父母平均寿命 | parent_lifespan | $x_1$ | 连续变量（岁），比如父母平均寿命75岁 |
| 性别 | gender | $x_2$ | 分类变量（0=男性，1=女性） |
| 每周中等强度运动时长 | exercise_hours | $x_3$ | 连续变量（小时），范围0~10小时 |
| 是否长期吸烟 | smoking | $x_4$ | 分类变量：0=不吸烟/戒烟超10年，1=长期吸烟 |
| 饮食健康程度 | diet_health | $x_5$ | 分类变量：0=高油高糖高盐，1=低脂低糖低盐清淡饮食 |
| 每日睡眠时长 | sleep_hours | $x_6$ | 连续变量（小时），范围5~9小时 |
| 压力/心理健康水平 | stress_level |	$x_7$ | 分类变量：0=长期高压，1=压力适中，2=低压力/社交支持充足 |

> 影响因素只有量化了后才能放到模型里计算。

上面的因素成为模型的自变量（或特征）。模型的目标是计算因变量$y$，即预期寿命（actual_lifespan）：

```katex
\hat{y} = b + w_1 \times x_1 + w_2 \times x_2 + w_3 \times x_3 + w_4 \times x_4 + w_5 \times x_5 + w_6 \times x_6 + w_7 \times x_7
```
如果把自变量（或特征）按向量的方式表示：
```katex
\boldsymbol{x} = [1, x_1, x_2, x_3, x_4, x_5, x_6, x_7]
```
权重参数也表示为：
```katex
\boldsymbol{w} = [b, w_1, w_2, w_3, w_4, w_5, w_6, w_7]
```
那么，模型的预测值就可以写成：
```katex
\hat{y} = \boldsymbol{w}^T \boldsymbol{x}
```
> [!TIP]
> $\boldsymbol{w}$ 就是我们想求解的权重系数，是模型的核心内容，也叫模型参数，通过训练数据由计算机自动计算出来。

# 一个完整的求解过程

## 题设
假设你通过对1000人进行了长期跟踪与统计（有当事人的同意），得到一份数据集（通过模拟生成）：

{{< button href="attachments/lifespan_data_full.csv" >}}点击下载数据集 (.csv){{< /button >}}
{{% details "生成数据集的源代码" %}}
```python
```
{{% /details %}}

数据集字段见前文"[多元线性回归模型](#多元线性回归模型)"，前5行示例如下：
| 序号 | parent_lifespan | gender | exercise_hours | smoking | diet_health | sleep_hours | stress_level | actual_lifespan |
|------|-----------------|--------|----------------|---------|-------------|-------------|--------------|-----------------|
| 1    | 77.5            | 0      | 7.2            | 0       | 0           | 7.1         | 0            | 56.0            |
| 2    | 74.3            | 1      | 0.7            | 1       | 0           | 5.4         | 2            | 47.0            |
| 3    | 78.2            | 0      | 0.7            | 1       | 0           | 5.7         | 1            | 43.0            |
| 4    | 82.6            | 1      | 0.1            | 1       | 1           | 7.3         | 1            | 61.0            |
| 5    | 73.8            | 0      | 9.6            | 1       | 1           | 6.2         | 2            | 62.0            |

当拿到这个数据集，我们决定使用线性回归模型训练和和预测数据。既然我们已经知道了模型的公式（见[多元线性回归模型](#多元线性回归模型)），就可以开始求解模型的权重系数了。

有两种方法可以求解模型的权重系数，一种是解析解求解，是以纯数学的方式求解答案，另一种是梯度下降法求解，以工程化的方式通过迭代优化来逼近最优解。

## 解析解求解权重
我们先来当一回数学家，用解析解求解模型的权重系数，这是本文最烧脑的地方，需要做一些矩阵的运算，一旦弄懂了，将会受益无穷。

我们先做一些变量的定义：
- $w$：权重系数向量（$8 \times 1$），包含截距项$b$和$w_1$到$w_7$共8个系数。
- $X$：特征矩阵（$1000 \times 8$），包含1000行样本，8列特征（包括截距项$x_0=1$）。
- $y$：实际寿命向量（$1000 \times 1$），包含1000个样本的实际寿命值。

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

## 梯度下降法求解权重

## 模型预测验证（推理）
所谓推理就是把前面学习到的模型用于对未知数据的预判

# 后话

## 哪种求解方法更优？
解析解求解方法更优，因为它直接给出了最优解，而梯度下降法需要迭代优化，可能会收敛到局部最优解。但梯度下降法的优势在于它可以处理大规模数据集，而解析解求解方法在数据集较大时会变得非常复杂。且当数据集包含噪声或异常值时，梯度下降法更稳定。