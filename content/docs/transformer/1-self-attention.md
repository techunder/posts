---
title: "自注意力机制"
weight: 10
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->

<div class="page-title">自注意力机制</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-04-08 | 更新时间：2026-04-08
</div>
{{< katex />}}

自注意力机制（Self-Attention Mechanism）是 Transformer 模型的核心机制。

下文是按推理（生成）的过程来描述的。

# 整体流程

1. 输入一句话 → 切成 token（词元）
2. 每个 token 变成 embedding 向量 → 得到一组 embedding 向量列表
3. 每个 embedding 向量都分别被映射成 Q、K、V 三个向量
4. 预测下一个字时，拿最后一个字的 Q，去跟前面所有字的 K 算相关性，相关性 = 权重
5. 用权重对前面所有 token 的 V 加权融合 → 得到单头注意力 output
6. 拼接多个单头注意力的 output → 映射回 embedding 向量列表
7. 最后输出映射：$d_{model}$ → $d_{vocab}$ → softmax → token 概率

# Token 映射

假设我们有 3 个 token：「我」、「爱」、「你」。

每个 token 都会先表示为 embedding 向量。

每个 token 进入注意力层之前，会先被投影成三个向量 —— Q（Query）、K（Key）、V（Value）。

粗略理解：
- Q = "我在找什么"
- K = "我有什么"
- V = "我携带的信息内容"

设 $d_{model}$ = token 原始 embedding 的维度（比如 BERT 是 768，GPT-3 是 12288 等）。

设 $d_k$ = 每个 token 投影成 Q 或 K 向量后的维度。

设 $d_v$ = 每个 token 投影成 V 向量后的维度。

```katex
Q = embedding \times W_q \qquad (d_{model} → d_k) \\
K = embedding \times W_k \qquad (d_{model} → d_k) \\
V = embedding \times W_v \qquad (d_{model} → d_v)
```

$W_q$、$W_k$、$W_v$ 是可学习的矩阵，shape 分别为 

- $W_q$: $(d_{model}, d_k)$
- $W_k$: $(d_{model}, d_k)$
- $W_v$: $(d_{model}, d_v)$

$d_k$ = 通常比 $d_{model}$ 小很多，比如 $d_{model}$ = 4096，$d_k$ = 64。

这样做是为了省计算量 —— 例如下面的注意力计算里，

$QK^T$ 的矩阵乘法规模是 $(1 \times d_k \times n) = O(n·d_k)$，所以 $d_k$ 越小越快。

# 单步注意力公式

我们的目标是，看到「我」、「爱」、「你」三个 token，

要计算下一个 token 的概率，然后挑概率最大的作为下一个 token。

原理是以当前最后一个 token， 即「你」，作为 query，

去跟当前已经出现的所有 token，即「我」、「爱」、「你」，的 key 计算相关性，

相关性 = 权重，按权重取值。

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
\boldsymbol{\alpha} = \text{softmax}(S) = \begin{bmatrix} \alpha_1 & \alpha_2 & \alpha_3 \end{bmatrix}
```

其中：

```katex
\alpha_i = \frac{e^{s_i}}{\sum_j e^{s_j}}
```

结果是三个概率值和为 1，代表每个历史 token 对当前 query 的**注意力权重**。

## 第三步：加权求和

V 的 shape 为 $(n, d_v)$
```katex
V = \begin{bmatrix} \boldsymbol{v_1} \\ \boldsymbol{v_2} \\ \boldsymbol{v_3} \end{bmatrix}
```
```katex
O_{head}
= \boldsymbol{\alpha}V
= \alpha_1 \boldsymbol{v_1} + \alpha_2 \boldsymbol{v_2} + \alpha_3 \boldsymbol{v_3}
```

用注意力权重对 V 向量做加权平均，得到一个融入了上下文信息的输出向量。

# KV Cache

每次生成一个新的 token 时，需要用到目前为止所有 token 的 K 和 V

所以模型会缓存一个 K 和 V 的列表，每次生成新的 token，其 $K_i$ 和 $V_i$ 都会压入缓存
```katex
K_{cached} = \begin{bmatrix} K_1 & K_2 & \cdots & K_n \end{bmatrix} \\
V_{cached} = \begin{bmatrix} V_1 & V_2 & \cdots & V_n \end{bmatrix}
```

称为 KV Cache，所以注意力公式可以理解成：
```katex
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{Q_{new} K_{cached}^T}{\sqrt{d_k}}\right) V_{cached}
```
请注意到这个 KV Cache 是不断膨胀的，越后面的 token，要运算的矩阵越大，算力要求越高

# 注意力层输出

单注意力只能关注一个语言特性

但通常需要综合多个语言特性才能有好的效果

比如语义关联、句法结构、代词指代、相邻词等

把多头注意力拼接在一起再输出

单注意力的 $O_{head}$ 的 shape 为 $(1, d_v)$

$h$ 头注意力的 $O_{head}$ concat 拼接后 $O_{heads}$ 的 shape 为 $(1, h \times d_v)$

然后通过 $W_o$ 映射回 $(1, d_{model})$
```katex
O_{attention} = O_{heads} \times W_o \qquad (h \times d_v → d_{model})
```

其中 $W_o$ 的 shape 为 $(h \times d_v, d_{model})$。

# 最终 token 输出

注意力层的输出为 $(1, d_{model})$

需要把这个结果最终转换成 token

总体思路为：$d_{model}$ → $d_{vocab}$ → softmax → token 概率

这里需要用到另外一个权重 $W_{t}$，shape 为 $(d_{model}, d_{vocab})$

```katex
O_{vocab} = O_{attention} \times W_t \qquad (d_{model} → d_{vocab})
```
$O_{vocab}$ 的维度为整个词表大小，与 token 一一对应

通过 softmax 归一化后，取权重最高或按温度随机取 token。

# 上下文长度
上下文长度对自注意力机制的计算量影响很大，呈 $O(n^2)$ 复杂度，下面逐步拆解。

假设输入 token 序列长度为 $n$：

- Q: ($n$, $d_{model}$)
- K: (n, $d_{model}$)
- V: (n, $d_v$)

第一步：$QK^T$

> $QK^T = (n, d_{model}) \times (d_{model}, n) = (n, n)$，复杂度为 $O(n^2d_{model})$

第二步：Softmax

> 对 $(n, n)$ 矩阵的每一行做 softmax，复杂度仍然是 $O(n^2)$

第三步：$\times V$

> $(n, n) \times (n, d_v) = (n, d_v)$，复杂度为 $O(n^2d_v)$

最后做复杂度统计，因为 $d_{model}$ 和 $d_v$ 通常远小于 $n$，

$O(n^2d_{model}) + O(n^2) + O(n^2d_v) = O(n^2)$

# 权重总结

总的来说，我们需要以下权重

- $W_q$：shape $(d_{model}, d_k)$ &emsp;&emsp;&emsp; embedding → Q
- $W_k$：shape $(d_{model}, d_k)$ &emsp;&emsp;&emsp; embedding → K
- $W_v$：shape $(d_{model}, d_v)$ &emsp;&emsp;&emsp; embedding → V
- $W_o$：shape $(h \times d_v, d_{model})$ &emsp; V → embedding
- $W_t$：shape $(d_{model}, d_{vocab})$ &emsp;&emsp; embedding → token
