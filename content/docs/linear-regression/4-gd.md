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

## 什么是梯度下降

> [!TIP]
> 当你站在高山的顶部，想以最快的速度下山，那么最快的方式是朝着最陡的方向行进

预测值与实际值之间的误差就是一座名为“误差”的高山，误差越大，山越高。

使用不同的模型参数，会得到不同的误差，相当于位于高山的不同位置。

你想通过改变模型参数，以最快的速度下山。

梯度下降，就是朝着令误差函数减小最快的方向更新参数，沿着最陡峭的方向下山。

![梯度下降](/images/docs/linear-regression/gradient-descent.png)

