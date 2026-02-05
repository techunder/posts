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

在[上一篇文章](../3-math/)，我们运用了高深的数学技巧，费尽千辛万苦求得了模型参数的最优解
```katex
\boldsymbol{\theta}^* = \left( \boldsymbol{X}^T \boldsymbol{X} \right)^{-1} \boldsymbol{X}^T \boldsymbol{y}
```
现在我们到了最激动人心的时刻，编写Python代码实现它。

# 解析解实现
