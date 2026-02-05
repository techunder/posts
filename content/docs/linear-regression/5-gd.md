---
title: "梯度下降"
weight: 50
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归：梯度下降</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

[前文](../3-math/)讲过，计算机学习数据中隐藏的规律的方式，是通过最小化预测值与实际值之间的误差来实现的。接下来我们通过梯度下降，以迭代的方式多轮运算不断更新$\boldsymbol{\theta}$的值，使得误差最小化。

# 梯度下降法