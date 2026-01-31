---
title: "深度学习公式"
weight: 30
bookToC: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Deep Learning</div>
{{< katex />}}

IIT CS577

# Notations
Let $i=1,2,\dots,N$ (the sample index)

* Samples $\boldsymbol{x}_i \in \mathcal{X}$ ($\mathbb{R}^d$)
* Dataset $\boldsymbol{X} = \begin{bmatrix} \boldsymbol{x}_1 \\\\ \boldsymbol{x}_2 \\\\ \vdots \\\\ \boldsymbol{x}_N \end{bmatrix}$
* Labels $y_i \in \mathcal{Y}$
* Model params $\boldsymbol{\theta} \in \Theta$ (weights, intercept)
* Prediction $\hat{y} = f(\boldsymbol{x}, \boldsymbol{\theta})$
* Loss $L(\hat{y}, y) = (\hat{y} - y)^2$ ($y$ is the ground true)
* Empirical risk minimization (ERM) $min_{\boldsymbol{\theta} \in \Theta} J(\boldsymbol{\theta}) := \frac{1}{N} \sum_{i=1}^N L(\hat{y_i}, y_i)$
* Population risk minimization (PRM) $min_{\boldsymbol{\theta} \in \Theta} J(\boldsymbol{\theta}) := \mathbb{E}_{(\boldsymbol{x}, y) \sim \mathcal{D}}[L(\hat{y}, y)]$

# Linear Algebra

## Matrix Transpose
```katex
(\mathbf{a}+\mathbf{b})^T = \mathbf{a}^T + \mathbf{b}^T
```
```katex
(\mathbf{ab})^T = \mathbf{b}^T \mathbf{a}^T
```
```katex
(\mathbf{abc})^T = \mathbf{c}^T \mathbf{b}^T \mathbf{a}^T
```

## Matrix Equation
```katex
\mathbf{ax} = \mathbf{by} \\
\mathbf{x} = \mathbf{a}^{-1} \mathbf{by}
```

## Matrix Calculus
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

## Squared L2 Norm

let $\boldsymbol{z} = \begin{bmatrix} z_1 \\\\ z_2 \\\\ \vdots \\\\ z_d \end{bmatrix}$

```katex
\begin{aligned}
\| \boldsymbol{z} \|_2^2 \\
&= \left({\sqrt{z_1^2 + z_2^2 + \dots + z_d^2}}\right)^2 \\
&= z_1^2 + z_2^2 + \dots + z_d^2  \\
&= \boldsymbol{z}^T \boldsymbol{z}
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

# Gradients
* Given $f: \mathbb{R}^d \to \mathbb{R}$ differentiable, let $\boldsymbol{x}=[x_1,\dots,x_d]^T$, the gradient is
```katex  
\color{red}
\nabla_{\boldsymbol{x}} f(\boldsymbol{x})=[\frac{\partial f(\boldsymbol{x})}{\partial x_1},\dots,\frac{\partial f(\boldsymbol{x})}{\partial x_d}]^T
```
(partial derivate as a column vector)
* Locally direction of most decrease is $-\nabla_{\boldsymbol{x}} f(\boldsymbol{x})$
* Necessary condition for local minimality: If $ \boldsymbol{x}^* $ is a local minimum of $f$, then $\nabla_{\boldsymbol{x}} f(\boldsymbol{x}^*) = 0$

# Linear Regression
Notation:
* Parameter: $\boldsymbol{w}=\begin{bmatrix} w_1 \\\\ w_2 \\\\ \vdots \\\\ w_d \end{bmatrix}$
* Parameter: $\boldsymbol{\theta}=\begin{bmatrix} b \\\\ w_1 \\\\ w_2 \\\\ \vdots \\\\ w_d \end{bmatrix}$
* Data: $\boldsymbol{x}_i = [x_1, x_2, \dots, x_d]$
* Data: $\tilde{\boldsymbol{x}}_i = [1, x_1, x_2, \dots, x_d]$
* Dataset: $\boldsymbol{X} = \begin{bmatrix} \boldsymbol{x}_1 \\\\ \boldsymbol{x}_2 \\\\ \vdots \\\\ \boldsymbol{x}_N \end{bmatrix}$
* Dataset: $\tilde{\boldsymbol{X}} = \begin{bmatrix} \tilde{\boldsymbol{x}}_1 \\\\ \tilde{\boldsymbol{x}}_2 \\\\ \vdots \\\\ \tilde{\boldsymbol{x}}_N \end{bmatrix}$
* Prediction: $\hat{y}_i = f(\boldsymbol{x}_i, \boldsymbol{\theta}) = b + \boldsymbol{x}_i \boldsymbol{w} = \tilde{\boldsymbol{x}}_i \boldsymbol{\theta}$
* Ground truth: $\boldsymbol{y} = \begin{bmatrix} y_1 \\\\ y_2 \\\\ \vdots \\\\ y_N \end{bmatrix}$

Calculate EMR $min_{\boldsymbol{\theta}} J(\boldsymbol{\theta})$:
```katex
\begin{aligned}
J(\boldsymbol{\theta}) 
&= \frac{1}{N} \sum_{i=1}^N (y_i - f(\tilde{\boldsymbol{x}}_i;\boldsymbol{\theta}))^2 \\
&= \frac{1}{N} \left\| \begin{bmatrix} y_1 - f(\tilde{\boldsymbol{x}}_1;\boldsymbol{\theta}) \\ y_2 - f(\tilde{\boldsymbol{x}}_2;\boldsymbol{\theta}) \\ \vdots \\ y_N - f(\tilde{\boldsymbol{x}}_N;\boldsymbol{\theta}) \end{bmatrix} \right\|_2^2 \\
&= \frac{1}{N} \left\| \boldsymbol{y} - \tilde{\boldsymbol{X}} \boldsymbol{\theta} \right\|_2^2 \\
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - 2(\tilde{\boldsymbol{X}} \boldsymbol{\theta})^T \boldsymbol{y} + (\tilde{\boldsymbol{X}} \boldsymbol{\theta})^T \tilde{\boldsymbol{X}} \boldsymbol{\theta} \right) \\
&= \frac{1}{N} \left( \boldsymbol{y}^T \boldsymbol{y} - 2\boldsymbol{\theta}^T \tilde{\boldsymbol{X}}^T \boldsymbol{y} + \boldsymbol{\theta}^T \tilde{\boldsymbol{X}}^T \tilde{\boldsymbol{X}} \boldsymbol{\theta} \right)
\end{aligned}
```
To find the least squares solution, taking the derivative and set it to zero:
```katex
\nabla_{\boldsymbol{\theta}} J(\boldsymbol{\theta})
= \frac{1}{N} \left( -2\tilde{\boldsymbol{X}}^T \boldsymbol{y} + 2\tilde{\boldsymbol{X}}^T \tilde{\boldsymbol{X}} \boldsymbol{\theta} \right) = 0
```
```katex
\tilde{\boldsymbol{X}}^T \tilde{\boldsymbol{X}} \boldsymbol{\theta}
= \tilde{\boldsymbol{X}}^T \boldsymbol{y} 
```
```katex
\fbox{$
\boldsymbol{\theta}
= (\tilde{\boldsymbol{X}}^T \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}^T \boldsymbol{y} 
$}
```