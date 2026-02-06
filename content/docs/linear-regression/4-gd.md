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
  发布时间：2026-02-05 | 更新时间：2026-02-05
</div>

计算机学习数据中隐藏规律的方法，是通过最小化预测值与实际值之间的误差来实现的。

除了通过前文讲述的[最小二乘法](../3-lsm/)，还可以通过梯度下降实现，即通过多轮运算不断更新$\boldsymbol{\theta}$的值，使得误差逐渐变小，直至达到一个较小的阈值。

# 梯度下降法