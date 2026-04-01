---
title: "深度学习 (DL)"
weight: 30
bookToC: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Deep Learning</div>
{{< katex />}}

本文根据 IIT (Illinois Institute of Technology) CS577 整理。

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
* $\text{softmax}(\boldsymbol{x})$
  
  let $\boldsymbol{x} = [x_1, x_2, \dots, x_n]^T$

  ```katex
  \text{softmax}(\boldsymbol{x})_i = \frac{e^{x_i}}{\sum_{j=1}^n e^{x_j}}
  ```
  ```katex
  \text{softmax}(\boldsymbol{x}) = 
  \begin{bmatrix} 
  \text{softmax}(\boldsymbol{x})_1 \\ 
  \text{softmax}(\boldsymbol{x})_2 \\ 
  \cdots \\ 
  \text{softmax}(\boldsymbol{x})_n 
  \end{bmatrix}
  ```

# 余弦相似度
设有两个向量 $\boldsymbol{x}$ 和 $\boldsymbol{y}$，
其中 $\theta$ 为 $\boldsymbol{x}$ 和 $\boldsymbol{y}$ 的夹角。

根据余弦定理，
```katex
\| \boldsymbol{x} - \boldsymbol{y} \|^2 = \|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\|\boldsymbol{x}\|\|\boldsymbol{y}\| \cos \theta \\
(\boldsymbol{x} - \boldsymbol{y}) \cdot (\boldsymbol{x} - \boldsymbol{y}) = \|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\|\boldsymbol{x}\|\|\boldsymbol{y}\| \cos \theta \\
\|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\boldsymbol{x} \cdot \boldsymbol{y} = \|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\|\boldsymbol{x}\|\|\boldsymbol{y}\| \cos \theta \\
\color{red}
\cos \theta = \frac{\boldsymbol{x} \cdot \boldsymbol{y}}{\|\boldsymbol{x}\| \|\boldsymbol{y}\|}
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
## Least Squares Method (LSM)
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

## Gradient Descent

Let $\epsilon_k > 0$ be the learning rates, $k$ is the iteration counter, $k = 1,2,\dots$
* Initialize $\boldsymbol{\theta}$
* While not converged:
    * Select $m$ samples $\left \\{ \boldsymbol{x}^{(1)}, \cdots , \boldsymbol{x}^{(m)} \right \\}$ and matching labels $\left \\{ y^{(1)}, \cdots , y^{(m)} \right \\}$
    * Computer gradient $\boldsymbol{g} \leftarrow \nabla_{\boldsymbol{\theta}} \frac{1}{m} \sum_{i=1}^m L(f(\boldsymbol{x}^{(i)},\boldsymbol{\theta}), y^{(i)})$
    * Compute update $\boldsymbol{\theta} \leftarrow \boldsymbol{\theta} - \epsilon_k \boldsymbol{g}$

# Attention Mechanism

注意力机制

## 先从一个具体例子说起

假设我们有 3 个 token：「我」、「爱」、「你」。

每个 token 进入注意力层之前，会先被投影成三个向量——Q（Query）、K（Key）、V（Value）。

设$d_{model}$ = token 原始 embedding 的维度（比如 BERT 是 768，GPT-3 是 12288 等）。

设$d_k$ = 每个 token 投影成 Q 或 K 向量后的维度。

设$d_v$ = 每个 token 投影成 V 向量后的维度。

```katex
Q = embedding \times W_q    (d_{model} → d_k) \\
K = embedding \times W_k    (d_{model} → d_k) \\
V = embedding \times W_v    (d_{model} → d_v)
```
$W_q$、$W_k$、$W_v$ 是可学习的矩阵，维度分别为 $d_{model} \times d_k$、$d_{model} \times d_k$ 和 $d_{model} \times d_v$。


$d_k$ = 通常比 $d_{model}$ 小很多，比如 $d_{model}$ = 4096，$d_k$ = 64。

这样做是为了省计算量 —— 注意力计算里 $QK^T$ 的矩阵乘法规模是 $(n \times d_k) \times (d_k \times n) = O(n^2·d_k)$，$d_k$ 越小越快。

粗略理解：
- Q = "我在找什么"
- K = "我有什么"
- V = "我携带的信息内容"

## 单步注意力公式

单次注意力的完整公式是：

```katex
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{Q K^T}{\sqrt{d_k}}\right) V
```

分三步走：

### 第一步：算相似度（$Q \times K^T$）

```katex
S = \frac{Q K^T}{\sqrt{d_k}}
```

Q 是 shape (1, $d_k$) 的行向量

K 是 shape (n, $d_k$) 的矩阵（n = token 数量）

$Q \times K^T$ 得到 shape (1, n) 的分数向量

除以 $\sqrt{d_k}$ 是为了防止 $d_k$ 太大导致 softmax 梯度消失

以 3 个 token 为例：

```katex
S = \begin{bmatrix} s_1 & s_2 & s_3 \end{bmatrix}
```

s₁ 表示"第一个 token 对当前 query 的相关程度"。


### 第二步：softmax 归一化

```katex
\alpha = \text{softmax}(S) = \begin{bmatrix} \alpha_1 & \alpha_2 & \alpha_3 \end{bmatrix}
```

其中：

```katex
\alpha_i = \frac{e^{s_i}}{\sum_j e^{s_j}}
```

结果是三个概率值，和为 1，代表每个历史 token 对当前 query 的**注意力权重**。


### 第三步：加权求和（$\alpha \times V$）
```katex
\text{output} = \alpha_1 v_1 + \alpha_2 v_2 + \alpha_3 v_3
```

用注意力权重对 V 向量做加权平均，得到一个融入了上下文信息的输出向量。