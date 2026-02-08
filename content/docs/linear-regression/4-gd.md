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

除了通过前文讲述的[最小二乘法](../3-lsm/)，还可以通过**梯度下降**实现，即通过多轮运算不断更新模型参数 $\boldsymbol{\theta}$ 的值，使得误差逐渐变小，直至达到一个较小的阈值。

## 什么是梯度下降
之所以叫梯度下降，是因为每次更新参数时，都是朝着令误差函数减小最快的方向进行，形如从误差这座高山的高处，沿着最陡峭的方向下山（这样下山速度最快），最终到达谷底。

![梯度下降](/images/docs/linear-regression/gradient-descent.png)

那什么是梯度呢？其实就是通俗来讲就是斜率。当你站在一处高山的某处，想象你站着一个有$x$轴、$y$轴、$z$轴的坐标系统中，你环顾四周，寻找水平方向的$x$轴和$y$轴
