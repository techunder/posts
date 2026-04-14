---
title: "Embedding"
weight: 40
bookCollapseSection: false
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Embedding</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-04-14 | 更新时间：2026-04-14
</div>
{{< katex />}}

**Embedding** 这个概念在大语言模型（Large Language Model）领域中随处可见，

本文从应用的角度去理解一下 **embedding** 究竟是什么。

# 什么是 Embedding

常见的大语言模型运行过程是这样的：

输入切分成 token → token 转换成 embedding 向量 → 输入大语言模型推理 → 逐个输出 token。

例如 “我喜欢大自然” 会被拆分成 4 个 token：「我」、「喜欢」、「大」、「自然」。

人类自然语言里所有这些 token（词元）会组成一个**词库**。

词库里的每一个 token 都会静态地映射到一个高维向量。

例如「喜欢」这个 token，利用 `paraphrase-multilingual-MiniLM-L12-v2` 这个 embedding model 可以映射为向量：
```text
[ 1.5620e-01 -5.2500e-02  8.6000e-03 -3.2600e-02 -1.4270e-01 -6.3600e-02
  4.2780e-01  2.1300e-01 -3.4000e-02  7.7500e-02 -6.3300e-02 -2.5110e-01
  8.0300e-02 -2.1300e-02  1.1070e-01 -7.2100e-02  3.1060e-01 -9.7000e-03
 -1.2330e-01  2.9700e-02 -3.1830e-01  1.0290e-01 -1.1480e-01  8.2900e-02
 -1.6570e-01 -2.3790e-01 -5.5900e-02  7.8500e-02 -4.1500e-02 -9.9400e-02
  ...         ...         ...         ...         ...         ...
  1.6800e-02  8.8800e-02  4.6800e-02 -2.2820e-01  1.9570e-01 -1.4130e-01
  2.6840e-01  1.0420e-01  1.7910e-01  2.0000e-04 -1.8340e-01  9.5300e-02
  2.0890e-01 -8.0000e-03 -7.6600e-02  1.8470e-01 -6.2700e-02 -3.2900e-02
 -1.7010e-01  5.5700e-02  1.8610e-01 -8.4600e-02  2.5200e-02 -1.7500e-02
 -1.6410e-01  1.6050e-01  3.6710e-01 -1.9900e-02  9.8300e-02  8.7700e-02]
（维度: 384）
```
{{% details title="计算 token embedding 的代码" open=false %}}
```python
from sentence_transformers import SentenceTransformer
import argparse

parser = argparse.ArgumentParser(description="Get embedding for text")
parser.add_argument("text", nargs="+", help="Text to encode")
args = parser.parse_args()

model = SentenceTransformer("paraphrase-multilingual-MiniLM-L12-v2")

words = args.text
embeddings = model.encode(words)

# 输出结果
for word, emb in zip(words, embeddings):
    print(f"\n=== '{word}' embedding ===")
    print(f"维度: {len(emb)}")
    print(f"向量: {emb.round(4)}")
```
{{% /details %}}

这个映射不是随意的，是对人类自然语言进行大量学习后摸索出的规律，使得语义相关性高的 token 向量值也比较类似。

学习到的规律以权重参数的形式存储在 embedding model 里，只要输入 token，embedding model 就可以推理出其 embedding 向量。

不同的企业或开源社区，都可以训练出自己的 embedding model。

不同的 embedding model 的向量维度可以不一样。

> [!NOTICE]
> 例如上面的 `paraphrase-multilingual-MiniLM-L12-v2` embedding model 的维度为 384。

# 相似度的度量：余弦相似度

上文提到的"语义相关性高的 token 向量值也比较类似"，一般是通过**余弦相似度**来度量的。

一个向量，可以描绘为向量维度的坐标系里的一个点，向量本身可以理解为从坐标原点指向该点的一条有向箭头。
<center>
<p>
  <img src="/images/docs/embedding/vector.jpeg" alt="向量空间" style="width: 50%; height: auto;">
</p>
（图：向量空间）
</center>

所有向量都会从坐标原点出发，所以两个向量会形成夹角，设为 $\theta$。

通常使用 $cos(\theta)$ 的值表示两个向量的相似度（也可以理解为距离），

$cos(\theta)$ 的值的范围为 $[-1,1]$，两个向量的越相似，夹角 $\theta$ 越小，值越接近 $1$。

根据余弦定理，余弦相似度的公式为：
```katex
\cos \theta = \frac{\boldsymbol{x} \cdot \boldsymbol{y}}{\|\boldsymbol{x}\| \|\boldsymbol{y}\|}
```

{{% details title="余弦相似度的数学推导过程" open=false %}}
设有两个向量 $\boldsymbol{x}$ 和 $\boldsymbol{y}$，$\theta$ 为 $\boldsymbol{x}$ 和 $\boldsymbol{y}$ 的夹角。

根据余弦定理，
```katex
\| \boldsymbol{x} - \boldsymbol{y} \|^2 = \|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\|\boldsymbol{x}\|\|\boldsymbol{y}\| \cos \theta
```
简化后整理得，
```katex
(\boldsymbol{x} - \boldsymbol{y}) \cdot (\boldsymbol{x} - \boldsymbol{y}) = \|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\|\boldsymbol{x}\|\|\boldsymbol{y}\| \cos \theta \\
\|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\boldsymbol{x} \cdot \boldsymbol{y} = \|\boldsymbol{x}\|^2 + \|\boldsymbol{y}\|^2 - 2\|\boldsymbol{x}\|\|\boldsymbol{y}\| \cos \theta \\
\color{red}
\cos \theta = \frac{\boldsymbol{x} \cdot \boldsymbol{y}}{\|\boldsymbol{x}\| \|\boldsymbol{y}\|}
```

其中 
```katex
\| \boldsymbol{x} \|
```
表示 $\boldsymbol{x}$ 的 $L_2$ Norm，代表一个向量距离坐标原点的距离，即欧几里得距离。
```katex
\begin{aligned}
\| \boldsymbol{x} \| = \sqrt{\boldsymbol{x}^T \boldsymbol{x}} = \sqrt{\boldsymbol{x} \cdot \boldsymbol{x}}
\end{aligned}
```
{{% /details %}}

> [!NOTICE]
> 除了常见的使用余弦相似度来表示向量相似度外，还有点积（IP / Inner Product）、欧几里得距离（L2，Euclidean Distance）、Manhattan Distance（L1，曼哈顿距离）等。
