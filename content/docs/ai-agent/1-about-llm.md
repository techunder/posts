---
title: "关于 LLM，我们需要知道的"
weight: 10
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->

<div class="page-title">关于 LLM，我们需要知道的</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-04-14 | 更新时间：2026-04-14
</div>
{{< katex />}}

要好用 AI Agent，我们需要先理解其核心，大语言模型（Large Language Model），简称 LLM

本文简要介绍，关于 LLM，我们需要知道的基础知识。

# 人工智能

人工智能经过几十年的发展，已经形成一系列庞大的分支

```mermaid
graph LR
    AI[🤖 人工智能<br>Artificial Intelligence]

    AI --> Classical[🎯 经典AI<br>符号主义]
    AI --> ML[📊 机器学习<br>Machine Learning]
    AI --> Emerging[⚡ 新兴方法<br>Emerging]

    Classical --> ExpertSystems[🧠 专家系统<br>Expert Systems]
    Classical --> Logic[🧮 逻辑规划<br>Logic Planning]
    Classical --> Search[🔍 搜索算法<br>Search Algorithms]

    ML --> Supervised[✅ 监督学习<br>Supervised Learning]
    ML --> Unsupervised[🔎 无监督学习<br>Unsupervised Learning]
    ML --> RL[🎮 强化学习<br>Reinforcement Learning]
    ML --> DL[🧠 深度学习<br>Deep Learning]

    Supervised --> Classification[🏷️ 分类<br>Classification]
    Supervised --> Regression[📈 回归<br>Regression]

    Unsupervised --> Clustering[📍 聚类<br>Clustering]
    Unsupervised --> DimReduce[📉 降维<br>Dimensionality Reduction]

    DL --> CNN[🖼️ 卷积神经网络<br>CNN]
    DL --> RNN[ RNN / LSTM]
    DL --> Transformer[🔄 Transformer]
    DL --> GAN[🎨 生成对抗网络<br>GAN]
    DL --> Diffusion[✨ 扩散模型<br>Diffusion]

    Transformer --> NLP[💬 自然语言处理<br>NLP]
    Transformer --> LLM[📚 大语言模型<br>LLM]
    Transformer --> Vision[👁️ 视觉模型<br>Vision Models]

    RL --> PolicyOpt[⚙️ 策略优化<br>Policy Optimization]
    RL --> Q-Learning[🎯 Q-Learning]

    Emerging --> NeuroSymbolic[🧩 神经符号AI<br>NeuroSymbolic]
    Emerging --> AGI[🌟 通用人工智能<br>AGI]
    Emerging --> Quantum[⚛️ 量子AI<br>Quantum AI]
    Emerging --> EdgeAI[📱 边缘AI<br>Edge AI]

    %% 高亮 Transformer
    style Transformer fill:#FFD700,stroke:#DAA520,stroke-width:3px,color:#000
    style LLM fill:#FFF8DC,stroke:#DAA520,stroke-width:2px
```

<center>（图：人工智能的主要分支）</center>

> 当前大放异彩的 LLM 就是属于 Tranformer 这一支

# 深度学习

深度学习是通过**深度神经网络**实现的，它模拟了人类的大脑神经网络结构。

<p>
  <img src="/images/docs/ai-agent-intro/neuron.png" alt="神经元" style="width: 20%; height: auto;">
  <img src="/images/docs/ai-agent-intro/brain.png" alt="大脑神经网络" style="width: 45%; height: auto;">
</p>

![计算机深度神经网络](/images/docs/ai-agent-intro/neural-network.png)

<center>（图：计算机深度神经网络）</center>

深度神经网络由大量神经元组成，每层神经元接收前一层输出的**加权和**，经过**激活函数**实现非线性变换后传递给下一层，最终到达输出层。输出层根据任务类型给出相应形式的输出：
- **多分类任务**经 softmax 归一化为各类别的概率分布，推理时通常选择概率最高的类别作为预测结果；
- **二分类任务**经 sigmoid 输出 0 到 1 之间的标量值，可视为正类概率；
- **回归任务**则无激活函数，直接输出线性结果。

{{% details title="相关的数学表达式" open=false %}}
### 加权求和+激活:
```katex
\boldsymbol{a}_{next} = \sigma(\boldsymbol{a}^T \boldsymbol{W} + \boldsymbol{b})
```
设按上一层 m 个神经元与当前层 n 个神经元**全连接**，其中
- $\boldsymbol{a}$ 为上一层的输出，shape 为 (m,1)
- $\boldsymbol{W}$ 为当前层的权重，shape 为 (m,n)
- $\boldsymbol{b}$ 为当前层的偏置，shape 为 (n,1)
- $\sigma$ 为激活函数，常见为：
    - $relu(x) = max(0, x)$，主流
    - $sigmoid(x) = \frac{1}{(1+e^{-x})}$，输出 0~1
    - $tanh(x) = \frac{e^x-e^{-x}}{e^x+e^{-x}}$，输出 -1~1

### softmax:
```katex
\text{softmax}(\boldsymbol{x}) = 
\begin{bmatrix} 
\text{softmax}(\boldsymbol{x})_1 \\ 
\text{softmax}(\boldsymbol{x})_2 \\ 
\cdots \\ 
\text{softmax}(\boldsymbol{x})_n 
\end{bmatrix}
```
其中 $\boldsymbol{x}$ 为向量
```katex
\text{softmax}(\boldsymbol{x})_i = \frac{e^{x_i}}{\sum_{j=1}^n e^{x_j}}
```
{{% /details %}}

一般的过程是通过训练得到权重 $\boldsymbol{W}$，封装成模型，再投放到应用场景中做推理。

不同的模型，会选择不同的架构，不同的权重参数量。

> [!TIP]
> 深度学习是建立在**概率论**之上的一门技术，对它来说，没有 100% 的必然 —— 每次输出只是当前条件下概率较高的 token，而非逻辑推导的必然结果。

> LLM 通常使用 temperature 或 top_p 调用参数来控制结果输出的采样策略

# 大语言模型（LLM）
LLM是智能体的核心引擎和智力源泉。

现代的LLM基本是**Transformer架构**或其变体，始于Google Brain团队于2017年发表的一篇论文《Attention Is All You Need》。

![Transformer模型架构](/images/docs/ai-agent-intro/transformer-model-architecture.png)

<center>（图：Transformer模型架构）</center>

> [!NOTICE]
> 像GPT这一类主流生成大模型，只有右边的架构，输出是一个字一个字往外蹦（Decoder-only）

{{< asciinema
  cast="/asciinema-627097.cast"
  loop=true
  autoplay=true
  speed=2 >}}

> [!NOTICE]
> 像BERT这一类理解模型，只有左边的架构，直接吐出整个语句的结果，用于分类或意图理解（Encoder-only）

Transformer是一种基于自注意力机制的深度神经网络架构，其核心模块通常采用**多头自注意力**结构。

通过投喂海量的通用知识，让其习得了其中的规律，并保存为模型的权重参数。
这个过程称为「**预训练**」（Pre-training）。

> [!TIP]
> 模型以人类自然语言为基础习得，权重参数量巨大，故名「**大语言模型**」

之后需要经过价值对齐、监督微调等的「**后训练**」（Post-training）过程才能上线使用。

# Token & Embedding

一段话先拆分成词元（token），例如

“我喜欢大自然” →「我」、「喜欢」、「大」、「自然」

每个token会被投射到embedding的向量空间中，语义相近的token距离较近。

<p>
  <img src="/images/docs/ai-agent-intro/vector.jpeg" alt="向量空间" style="width: 50%; height: auto;">
</p>
<center>（图：向量空间）</center>

向量空间的维度通常较高，比如LLaMA-3 8B为4096维、OpenAI text-embedding-3-large默认3072维等

> [!TIP]
> 就像星星嵌在夜晚的天空中一样，我们按语义把token嵌入到一个高维向量空间中，故名 「**embedding**」（嵌入）

![embedding示意图](/images/docs/ai-agent-intro/embedding.png)

<center>（图：embedding示意图）</center>

> [!NOTICE]
> man ≈ 男人

> [!NOTICE]
> king - man + woman ≈ queen

对LLM的调用，通过输入和输出的token计费。

> [!WARNING]
> LLM以Token为计量单位，是AI时代像“电”一样的基本能源单位

# LLM 推理过程

1. 输入一句话 → 切成 token（词元）
2. 每个 token 变成 embedding 向量 → 得到一组 embedding 向量列表
3. 每个 embedding 向量都分别被映射成 Q、K、V 三个向量
4. 预测下一个字时，拿最后一个字的 Q，去跟前面所有字的 K 算相关性，相关性 = 权重
5. 用权重对前面所有 token 的 V 加权融合 → 得到单头注意力 output
6. 拼接多个单头注意力的 output → 映射回 embedding 向量列表
7. 最后输出映射：$d_{model}$ → $d_{vocab}$ → softmax → token 概率

# Context Length

上下文长度

# Tool Calling
