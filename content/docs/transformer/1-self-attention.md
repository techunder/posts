---
title: "自注意力机制"
weight: 10
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->

<div class="page-title">自注意力机制</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-04-06 | 更新时间：2026-04-06
</div>

自注意力机制（Self-Attention Mechanism）是 Transformer 模型的核心机制。

# 整体流程

1. 输入一句话 → 切成 token（词元）
2. 每个 token → 变成 embedding 向量（通过查表）→ 得到一组 embedding 向量列表
3. 每个 embedding 向量都分别被映射成 Q、K、V 三个向量
4. 预测下一个字时，拿最后一个字的 Q，去跟前面所有字的 K 算相关性，相关性 = 权重
5. 用权重对前面所有字的 V 加权融合
6. 最后用融合出来的结果 → 算下一个 token 的概率

# Token 映射

假设我们有 3 个 token：「我」、「爱」、「你」。

每个 token 都会先表示为 embedding 向量。

每个 token 进入注意力层之前，会先被投影成三个向量 —— Q（Query）、K（Key）、V（Value）。

粗略理解：
- Q = "我在找什么"
- K = "我有什么"
- V = "我携带的信息内容"

设$d_{model}$ = token 原始 embedding 的维度（比如 BERT 是 768，GPT-3 是 12288 等）。

设$d_k$ = 每个 token 投影成 Q 或 K 向量后的维度。

设$d_v$ = 每个 token 投影成 V 向量后的维度。

```katex
Q = embedding \times W_q (d_{model} → d_k) \\
K = embedding \times W_k (d_{model} → d_k) \\
V = embedding \times W_v (d_{model} → d_v)
```
$W_q$、$W_k$、$W_v$ 是可学习的矩阵，shape 分别为 $(d_{model}, d_k)$、$(d_{model}, d_k)$ 和 $(d_{model}, d_v)$。

$d_k$ = 通常比 $d_{model}$ 小很多，比如 $d_{model}$ = 4096，$d_k$ = 64。

这样做是为了省计算量 —— 例如下面的注意力计算里，$QK^T$ 的矩阵乘法规模是 $(1 \times d_k \times n) = O(n·d_k)$，所以 $d_k$ 越小越快。

# 单步注意力公式

我们的目标是，看到「我」、「爱」、「你」三个 token，要计算下一个 token 的概率，然后挑概率最大的作为下一个 token。

原理是以当前最后一个 token， 即「你」，作为 query，去跟当前已经出现的所有 token，即「我」、「爱」、「你」，的 key 计算相关性，相关性 = 权重，按权重取值。

单次注意力的完整公式是：

```katex
\fbox{$
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{Q K^T}{\sqrt{d_k}}\right) V
$}
```

分步拆解：

## 第一步：算相似度权重

```katex
S = \frac{Q K^T}{\sqrt{d_k}}
```

Q 是 shape 为 $(1, d_k)$ 的行向量

K 是 shape 为 (n, $d_k$) 的矩阵（n = token 数量）

$Q \times K^T$ 得到 shape (1, n) 的向量，为相似度权重

为了防止 $d_k$ 太大导致 softmax 梯度消失，除以 $\sqrt{d_k}$

以 3 个 token 为例：

```katex
S = \begin{bmatrix} s_1 & s_2 & s_3 \end{bmatrix}
```

s₁ 表示"第一个 token 对当前 query 的相关程度"。

## 第二步：权重归一化

```katex
\alpha = \text{softmax}(S) = \begin{bmatrix} \alpha_1 & \alpha_2 & \alpha_3 \end{bmatrix}
```

其中：

```katex
\alpha_i = \frac{e^{s_i}}{\sum_j e^{s_j}}
```

结果是三个概率值和为 1，代表每个历史 token 对当前 query 的**注意力权重**。


## 第三步：加权求和
```katex
\text{output} = \alpha_1 v_1 + \alpha_2 v_2 + \alpha_3 v_3
```

用注意力权重对 V 向量做加权平均，得到一个融入了上下文信息的输出向量。
