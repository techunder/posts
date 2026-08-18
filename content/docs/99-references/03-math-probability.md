---
title: "概率论 (Probability Theory)"
weight: 3
bookToC: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">概率论</div>
{{< katex />}}

根据《普林斯顿概率论读本》整理。

# 书写约定
* $log(2) = log_e(2) = ln(2)$

# 排列组合
permutation

* **排列**（Array）：$A_n^k = \frac{n!}{(n-k)!}$（从 n 个中选 k 个排列，有序）
    * $A_n^k = n(n-1)(n-2)...(n-(k-1)) = \frac{n!}{(n-k)!}$
    * $A_n^n = n!$
    * $A_n^1 = n$
* **组合**（Combination）：$C_n^k = \frac{n!}{k!(n-k)!}$（从 n 个中选 k 个组合，无序），也表示为$\tbinom{n}{k}$或$\dbinom{n}{k}$
    * $A_n^k = C_n^k A_k^k \implies C_n^k = \frac{A_n^k}{A_k^k} = \frac{n!}{k!(n-k)!}$
    * $C_n^k = C_n^{n-k}$（挑出 k 个好的 = 挑出 (n-k) 个坏的）
    * $C_n^n = 1$
    * $C_n^1 = n$
* **加法原理**: 完成一件事情有多少种独立的方法。
* **乘法原理**: 完成一件事情需要分几个步骤，不能一步独立完成。

# 常用知识
* **同一天生日问题**：如果出席聚会的每个人都等可能地出生在$D$天中的任何一天，那么大约需要$\sqrt{D\cdot 2log2}$个人才能使得“至少两个人的生日在同一天”的概率为50%。

