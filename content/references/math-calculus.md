---
title: "微积分 (Calculus)"
weight: 20
bookToC: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Math Calculus</div>
{{< katex />}}

根据《普林斯顿微积分读本（修订版）》整理。这个是一本关于微积分的书，分为**微分**与**积分**两部分。

# 反常积分
* **反常积分定义**：出现以下情况，$\int_a^b f(x)dx$就是反常积分
    * 函数$f$在闭区间$[a,b]$内无界（无界处成为<b>暴裂点</b>，就好像包裹的函数被暴裂了一样，里面的积分就溢出）
    * $b=\infty$
    * $a=-\infty$
* **针对破裂点**：
    * 如果函数$f(x)$仅仅在$x$接近于$a$点时无界，则$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} \int_{a+\epsilon}^b f(x)dx$
    * 如果函数$f(x)$仅仅在$x$接近于$b$点时无界，则$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} \int_{a}^{b-\epsilon} f(x)dx$
    * 如果函数$f(x)$仅仅在区间$(a,b)$内的$c$点无界，则积分可分成两部分$\int_a^b f(x)dx = \int_a^c f(x)dx + \int_c^b f(x)dx$，可化了成前面的两种情况
* **针对边界无穷大**:
    * 如果函数$f(x)$在区间$[a,\infty)$上没有其他破裂点，则$\int_a^\infty f(x)dx = \lim_{N \to \infty} \int_a^N f(x)dx$
    * 如果函数$f(x)$在区间$(-\infty,b]$上没有其他破裂点，则$\int_{-\infty}^b f(x)dx = \lim_{N \to \infty} \int_{-N}^b f(x)dx$
    * 如果函数$f(x)$在区间$(-\infty,\infty)$上没有其他破裂点，则$\int_{-\infty}^\infty f(x)dx = \lim_{N \to \infty} \int_{-N}^a f(x)dx +\lim_{N \to \infty} \int_a^N f(x)dx$
* **比较判别法**：
    * 如果 $\int_a^b f(x)dx \ge \int_a^b g(x)dx = \infty$，$\int_a^b f(x)dx$ 一定发散。
    * 如果 $\int_a^b f(x)dx \le \int_a^b g(x)dx < \infty$，$\int_a^b f(x)dx$ 一定收敛。
* **渐近线等价函数**：当$x \to a$时，$f(x) \color{red} \sim \color{black} g(x)$表示$\lim_{x \to a} \frac{f(x)}{g(x)} = 1$
    * 这并不是说明当$x$接近于$a$时，$f(x)$大约等于$g(x)$（它们可能相差数百万），而是说明当$x$接近于$a$时，$f(x)$和$g(x)$的比值接近于1。
    * 渐近线等价的函数的积仍为渐近线等价，但加减却不成立。
    * 如果当$x \to a$时$f(x) \sim g(x)$，且这两个函数在区间$[a,b]$上没有其他的暇点了，那么积分$\int_a^b f(x)dx$和$\int_a^b g(x)dx$会同时收敛或同时发散（虽然同时收敛，可收敛值不一定相等）。
* **$p$判别法**，对于任何有限值$a>0$，
    * 当$p<1$时，积分$\int_0^a \frac{1}{x^p} dx$收敛
    * 当$p>1$时，积分$\int_a^{\infty} \frac{1}{x^p} dx$收敛
    * 其它情况都发散
* **绝对收敛判别法**：如果积分$\int_a^b |f(x)| dx$收敛，那么$\int_a^b f(x) dx$也一定收敛。这对$\int_a^{\infty} |f(x)| dx$同样适用。