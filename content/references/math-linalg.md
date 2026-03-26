---
title: "线性代数 (Linear Algebra)"
weight: 20
bookToC: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Math Linear Algebra</div>
{{< katex />}}

# 几何体系
* **欧氏几何**：欧几里得几何，三角形内角和为180度、两点之间直线最短、过直线外一点有且只有一条平行线
* **非欧几何**：应用在球面/马鞍面等，有罗氏几何、椭圆几何等，球面上三角形内角和大于180度、马鞍面上内角和小于180度。
* **黎曼几何**：应用在球面/马鞍面等，广义相对论所用几何，计算时空弯曲。

# Matrix Transpose
矩阵转置
```katex
(\mathbf{a}+\mathbf{b})^T = \mathbf{a}^T + \mathbf{b}^T
```
```katex
(\mathbf{ab})^T = \mathbf{b}^T \mathbf{a}^T
```
```katex
(\mathbf{abc})^T = \mathbf{c}^T \mathbf{b}^T \mathbf{a}^T
```

# Matrix Equation
```katex
\mathbf{ax} = \mathbf{by} \\
\implies \mathbf{x} = \mathbf{a}^{-1} \mathbf{by}
```

# Matrix Calculus
```katex
    \frac{\partial}{\partial{\mathbf{a}}}
        \left( \mathbf{a}^T \mathbf{b} \right)
    = \mathbf{b}
```

```katex
    \frac{\partial}{\partial{\mathbf{a}}}
        \left( \mathbf{a}^T \mathbf{M} \mathbf{a} \right)
    = 2 \mathbf{Ma}
```

# $L_p$ Norm
$L_p$ 范数

let $\boldsymbol{z} = \begin{bmatrix} z_1 \\\\ z_2 \\\\ \vdots \\\\ z_d \end{bmatrix}$

```katex
\| \boldsymbol{z} \|_p = \left(\sum_{i=1}^{d} |z_i|^p \right)^{1/p}
```

## $L_1$ Norm
也称为曼哈顿距离
```katex
\| \boldsymbol{z} \|_1 = \sum_{i=1}^{d} |z_i|
```

## $L_2$ Norm
向量的的长度

```katex
\begin{aligned}
\| \boldsymbol{z} \|_2 \\
&= \sqrt{z_1^2 + z_2^2 + \dots + z_d^2} \\
&= \sqrt{\boldsymbol{z}^T \boldsymbol{z}}
\end{aligned}
```
<span style="color:orange;">没写下标默认就是 $L_2$</span>，即
```katex
\| \boldsymbol{z} \| = \| \boldsymbol{z} \|_2
```

## Squared $L_2$ Norm
```katex
\begin{aligned}
\| \boldsymbol{z} \|_2^2 = \boldsymbol{z}^T \boldsymbol{z} = \boldsymbol{z} \cdot \boldsymbol{z}
\end{aligned}
```
let $\mathbf{a}$ and $\mathbf{b}$ be two vectors in $\mathbb{R}^d$.

$\mathbf{a}^T \mathbf{b}$ is scalar, so $\mathbf{a}^T \mathbf{b} = (\mathbf{a}^T \mathbf{b})^T = \mathbf{b}^T \mathbf{a}$
```katex
\begin{aligned}
\| \mathbf{a} - \mathbf{b} \|_2^2 \\
&= (\mathbf{a} - \mathbf{b})^T(\mathbf{a} - \mathbf{b}) \\
&= \mathbf{a}^T \mathbf{a} - \mathbf{a}^T \mathbf{b} - \mathbf{b}^T \mathbf{a} + \mathbf{b}^T \mathbf{b} \\
&= \mathbf{a}^T \mathbf{a} - (\mathbf{a}^T \mathbf{b})^T - \mathbf{b}^T \mathbf{a} + \mathbf{b}^T \mathbf{b} \\
&= \mathbf{a}^T \mathbf{a} - \mathbf{b}^T \mathbf{a} - \mathbf{b}^T \mathbf{a} + \mathbf{b}^T \mathbf{b} \\
&= \mathbf{a}^T \mathbf{a} - 2\mathbf{b}^T \mathbf{a} + \mathbf{b}^T \mathbf{b} \\
&= \mathbf{a}^T \mathbf{a} - 2\mathbf{a}^T \mathbf{b} + \mathbf{b}^T \mathbf{b} \\
&= \| \mathbf{b} - \mathbf{a} \|_2^2
\end{aligned}
```

## $L_\infty$ Norm
```katex
\| \boldsymbol{z} \|_\infty = \max_{i=1}^{d} |z_i|
```