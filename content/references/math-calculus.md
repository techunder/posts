---
title: "微积分公式"
weight: 20
bookToC: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Math Calculus</div>
{{< katex />}}

参考《普林斯顿微积分读本（修订版）》。这个是一本关于微积分的书，分为**微分**与**积分**两部分。

# 反常积分
* **反常积分定义**：出现以下情况，$\int_a^b f(x)dx$就是反常积分
    * 函数$f$在闭区间$[a,b]$内无界（无界处成为<b>暴裂点</b>）
    * $b=\infty$
    * $a=-\infty$
* 如果函数$f(x)$仅仅在$x$接近于$a$点时无界，则$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} \int_{a+\epsilon}^b f(x)dx$。
    * 其是发散还是收敛，与$b$的值无关，因为$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} (\int_{a+\epsilon}^c f(x)dx + \int_c^b f(x)dx) = \lim_{\epsilon \to 0^+} \int_{a+\epsilon}^c f(x)dx + M$
* 如果函数$f(x)$仅仅在$x$接近于$b$点时无界，则$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} \int_{a}^{b-\epsilon} f(x)dx$。
    * 其是发散还是收敛，与$a$的值无关，因为$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} (\int_{a}^c f(x)dx + \int_c^{b-\epsilon} f(x)dx) = \lim_{\epsilon \to 0^+} \int_c^{b-\epsilon} f(x)dx + M$
* 如果函数$f(x)$仅仅在区间$(a,b)$内的$c$点无界，则积分可分成两部分$\int_a^b f(x)dx = \int_a^c f(x)dx + \int_c^b f(x)dx$即可化成前面的两种情况，当有更多的无界点同理。只有全部分部都是收敛的，积分才会收敛。
* 如果函数$f(x)$在区间$[a,\infty)$上没有其他破裂点，则$\int_a^\infty f(x)dx = \lim_{N \to \infty} \int_a^N f(x)dx$
* 如果函数$f(x)$在区间$(-\infty,b]$上没有其他破裂点，则$\int_{-\infty}^b f(x)dx = \lim_{N \to \infty} \int_{-N}^b f(x)dx$
* 如果函数$f(x)$在区间$(-\infty,\infty)$上没有其他破裂点，则$\int_{-\infty}^\infty f(x)dx = \lim_{N \to \infty} \int_{-N}^a f(x)dx +\lim_{N \to \infty} \int_a^N f(x)dx$
* **比较判别法**：
    * 如果 $\int_a^b f(x)dx \ge \int_a^b g(x)dx = \infty$，$\int_a^b f(x)dx$ 一定发散。
    * 如果 $\int_a^b f(x)dx \le \int_a^b g(x)dx < \infty$，$\int_a^b f(x)dx$ 一定收敛。
* **函数互为渐近线**：当$x \to a$时，$f(x) \sim g(x)$同$\lim_{x \to a} \frac{f(x)}{g(x)} = 1$ 有着同样的意义（但这并不意味着函数$f(x)$和函数$g(x)$的差非常小，只是差相比$f(x)$和$g(x)$非常小而已）。