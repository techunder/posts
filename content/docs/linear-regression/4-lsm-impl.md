---
title: "解析解实现"
weight: 40
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：解析解实现</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

在[上一篇文章](../3-lsm/)，我们运用了高深的数学技巧，费尽千辛万苦求得了模型参数的最优解
```katex
\boldsymbol{\theta}^* = \left( \boldsymbol{X}^T \boldsymbol{X} \right)^{-1} \boldsymbol{X}^T \boldsymbol{y}
```
现在我们到了最激动人心的时刻，编写Python代码实现它。

# 导入测试集
在[建模](../2-model/)一篇中，我们提供了[数据集](/attachments/docs/linear-regression/lifespan_data_full.csv)，现在请把它下载到本地，并导入到Python程序中。

```python
import numpy as np
import pandas as pd

# 读取CSV文件
df = pd.read_csv('lifespan_data_full.csv')

# 转换为NumPy数组
X = df[['parent_lifespan', 'gender', 'exercise_hours', 'smoking', 'diet_health', 'sleep_hours', 'stress_level']].values
y = df['actual_lifespan'].values
```

我们已经导入了测试集，现在我们可以直接使用它。
