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

# 常用知识

* **多项式公式**
    * **平方差公式**：$a^2-b^2=(a+b)(a+b)$，$a+b$和$a-b$互相为对方的**共轭表达式**
    * **立方差公式**：$a^3-b^3=(a-b)(a^2+ab+b^2)$
    * **和的立方公式**：$(a+b)^3=a^3+3a^2b+3ab^2+b^3$
* **二次方程$ax^2+bx+c=0$的解**：$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$

* **数列求和**：
    * $\sum_{j=1}^{n}j=\frac{n(n+1)}{2}$（即前$n$个自然数的和，可以通过两个相同的反序数列相加得出）
    * $\sum_{j=1}^{n}(j^2-(j-1)^2)=\sum_{j=1}^{n}(2j-1)=n^2$（即前$n$个奇数的和等于$n^2$，通过展开得出）
    * $\sum_{j=1}^{n}j^2=\frac{n(n+1)(2n+1)}{6}$（即前$n$个自然数平方的和，可以通过展开$\sum_{j=1}^{n}(j^3-(j-1)^3)$得出）


# 函数与图像

[1]
* **函数的类型**：
    * 多项式函数（幂）
    * 指数函数和对数函数
    * 三角函数和反三角函数
    * 双曲函数和反双曲函数
* **上域与值域**：值域实际上是上域的一个子集。上域是可能输出的集合，一般为$\mathbb{R}$，而值域则是实际输出的集合。
* **数学约束**：1）分数的分母不能为零；2）不能取一个负数的偶次方根；3）不能取一个负数或零的对数。
* **垂线检验**：如果你有某个图像，想知道它是否是某个函数的图像，只需看看任何的垂线和图像的相交是否多于一次，函数的图像不会和任何垂线相交多于一次。通过**水平线检验**判断函数是否有反函数。
* **反函数**：对于$f$值域中的所有$y$，都有$f(f^{-1}(y))=y$；但是$f^{-1}(f(x))$可能不等于$x$；$f^{-1}(f(x))=x$仅当$x$在限制的定义域中才成立（因为一个$y$可能对应多个$x$）。
* **复合函数**：$f(x)=h(g(x))$可以表示为$f=h \circ g$，读作$f$是$g$与$h$的复合。
* **奇偶函数**：如果一个函数$f$是奇的，且在0上有定义，则$f(0)=0$；两个奇函数之积是偶函数，。
* **线性函数**：线性函数$f(x)=mx+b$可以通过**点斜式**描述，即通过点$(x_0, y_0)$且斜率为$m$的直线为$y-y_0=m(x-x_0)$，如果只知道通过$(x_1,y_1)$和$(x_2,y_2)$两点，那么可以先计算其斜率$m=\frac{y_2-y_1}{x_2-x_1}$，再通过点斜式得到。
* **多项式函数**：最简式$p(x)=ax^n$的图像分$n$为奇数或偶数两种类型，多项式通式$p(x)=a_nx^n+a_{n-1}x^{n-1}+\ldots+a_2x^2+a_1x+a_0$的图像中间部分取决与各项，但两侧趋势取决于最高幂项的指数$n$。
* **有理函数**：最简式$\frac{1}{x^n}$的图像分$n$为奇数或偶数两种类型，通式为$\frac{p(x)}{q(x)}$。
* **指数函数**：$y = b^x$的图像分$b > 1$和$0 < b < 1$两种类型，$y = b^{-x}(b > 0)$等同于$y = b^x(0 < b < 1)$。
* **对数函数**：对数函数$y=log_b(x)$是指数函数$y=x^b$的逆函数，对数函数的图像可以通过以直线$y=x$镜子，映射指数函数得出，同样分$b > 1$和$0 < b < 1$两种类型。
* **绝对值函数**：绝对值函数$f(x)=|g(x)|$的图像，以$x$轴为镜子，把$g(x)$在$x$轴下方的图像映照上来，$x$轴上方的图像保持不变。


# 指数和对数函数

* 指数法则 [9.2]:
    * $b^0=1$
    * $b^1=b$
    * $b^x b^y=b^{x+y}$
    * $\frac{b^x}{b^y}=b^{x-y}$
    * $(b^x)^y=b^{xy}$

* 对数基础 [9.1]:
    * $\log_b(y)$表示底数为$b$，$y$的对数，含义是为了得到$y$，你必须将底数$b$提升的幂次。这里要求$y > 0$，$b > 0$且$b\neq 1$
    * **$x$的自然对数的表示**：$log_e(x)=ln(x)=log(x)$
    * <span style="color:red;">$log_b(b^x)=x$</span>：通过对数函数的定义得出。
    * <span style="color:red;">$b^{log_b(x)}=x$</span>：通过对数函数的定义得出。
    * <span style="color:red;">$log_{\frac{1}{b}}(y)=-log_b(y)$</span>：$x=log_{\frac{1}{b}}(y) \Rightarrow (\frac{1}{b})^x=y \Rightarrow b^{-x}=y \Rightarrow -x=log_b(y) \Rightarrow x=-log_b(y)$
    * 常用对数值
        * $ln(2) \approx 0.7$
        * $ln(3) \approx 1.1$
        * $ln(5) \approx 1.6$ 

* 对数法则 [9.3]:
    * $b^0=1$
    * $log_b(1)=0$
    * $log_b(b)=1$
    * $log_b(xy)=log_b(x)+log_b(y)$
    * $log_b(\frac{x}{y})=log_b(x)-log_b(y)$
    * $log_b(x^y)=y log_b(x)$
    * <span style="color:red;">$log_b(x)=\frac{log_c(x)}{log_c(b)}$</span>：换底法则，这意味着对同一个变量，不同底数的对数函数是互为常数倍的关系（倍数为$\frac{1}{log_c(b)}$），图像为在垂直方向拉伸$\frac{1}{log_c(b)}$倍的关系


# 三角函数
* 定义 [2.1]
    * **正弦**：$sin(\theta)=\frac{OppositeSide}{Hypotenuse}=\frac{y}{r}$，以$2\pi$[$0$, $2\pi$]为周期的奇函数（[$-\frac{\pi}{2},\frac{\pi}{2}$]单调递增），$sin(-\theta)=-sin(\theta)$
    * **余弦**：$cos(\theta)=\frac{AdjacentSide}{Hypotenuse}=\frac{x}{r}$，以$2\pi$[$0$, $2\pi$]为周期的偶函数（[$0,\pi$]单调递减），$cos(-\theta)=cos(\theta)$
    * **正切**：$tan(\theta)=\frac{OppositeSide}{AdjacentSide}=\frac{y}{x}$，以$\pi$$[-\frac{\pi}{2}, \frac{\pi}{2}]$为周期的奇函数（[$-\frac{\pi}{2},\frac{\pi}{2}$]单调递增），$tan(-\theta)=-tan(\theta)$
    * **余切**：$cot(\theta)=\frac{1}{tan(\theta)}=\frac{x}{y}$，以$\pi$$[0, \pi]$为周期的奇函数（[$0,\pi$]单调递减），$cot(-\theta)=-cot(\theta)$
    * **正割**：$sec(\theta)=\frac{1}{cos(\theta)}=\frac{r}{y}$，以$2\pi$[$0$, $2\pi$]为周期的偶函数（[0,$\frac{\pi}{2}$]和[$\frac{\pi}{2},\pi$]单调递减，在$x=\frac{\pi}{2}$处有渐近线），$sec(-\theta)=sec(\theta)$
    * **余割**：$csc(\theta)=\frac{1}{sin(\theta)}=\frac{r}{x}$，以$2\pi$[$0$, $2\pi$]为周期的奇函数（[$-\frac{\pi}{2},0$]和[$0,\frac{\pi}{2}$]单调递减，在$x=0$处有渐近线），$csc(-\theta)=-csc(\theta)$
    * cos = **co**mplementary **s**in
    * cot = **co**mplementary **t**an

* 常用值 [2.2]
    | $\theta$   | $0$       | $\dfrac{\pi}{6}$ | $\dfrac{\pi}{4}$ | $\dfrac{\pi}{3}$ | $\dfrac{\pi}{2}$ |
    |------------|-----------|------------------|------------------|------------------|------------------|
    | $\sin(\theta)$ | $0$       | $\dfrac{1}{2}$   | $\dfrac{\sqrt{2}}{2}$ | $\dfrac{\sqrt{3}}{2}$ | $1$              |
    | $\cos(\theta)$ | $1$       | $\dfrac{\sqrt{3}}{2}$ | $\dfrac{\sqrt{2}}{2}$ | $\dfrac{1}{2}$   | $0$              |
    | $\tan(\theta)$ | $0$       | $\dfrac{\sqrt{3}}{3}$ | $1$              | $\sqrt{3}$       | *                |
    | $\cot(\theta)$ | *         | $\sqrt{3}$       | $1$              | $\dfrac{\sqrt{3}}{3}$ | $0$              |
                
    * 通过**参考角**计算$0$到$\frac{\pi}{2}$之外的三角函数值。
    * **参考角**为角$\theta$的射线与**$x$轴**之间的最小夹角，它必定介于0到$\frac{\pi}{2}$之间。
    * 正负号按$x$和$y$的符号选取。
        
* 三角恒等式 [2.3]
    * $tan(x)=\frac{sin(x)}{cos(x)}$
    * $cot(x)=\frac{cos(x)}{sin(x)}$
    * 毕达哥拉斯定理：
        * <span style="color:red;">$cos^2(x)+sin^2(x)=1$</span>
        * $1+tan^2(x)=sec^2(x)$ (左右两边同时除以$cos^2(x)$)
        * $1+cot^2(x)=csc^2(x)$ (左右两边同时除以$sin^2(x)$)
    * complementary
        * $sin(x)=cos(\frac{\pi}{2} - x)$
        * $cos(x)=sin(\frac{\pi}{2} - x)$
        * $tan(x)=cot(\frac{\pi}{2} - x)$
        * $cot(x)=tan(\frac{\pi}{2} - x)$
        * $sec(x)=csc(\frac{\pi}{2} - x)$
        * $csc(x)=sec(\frac{\pi}{2} - x)$
    * <span style="color:red;">$sin(A+B)=sin(A)cos(B)+cos(A)sin(B)$</span>（公平策略）
    * <span style="color:red;">$cos(A+B)=cos(A)cos(B)-sin(A)sin(B)$</span>（偏袒策略）
        * $sin(2x)=2sin(x)cos(x)$
        * $cos(2x)=cos^2(x)-sin^2(x)=1-2sin^2(x)=2cos^2(x)-1$
        * 积化和差公式：
            * $cos(A)cos(B)=\frac{1}{2}(cos(A-B)+cos(A+B))$
            * $sin(A)sin(B)=\frac{1}{2}(cos(A-B)-cos(A+B))$
            * $sin(A)cos(B)=\frac{1}{2}(sin(A-B)+sin(A+B))$
    

# 反三角函数

**存在反函数的条件**：如果函数的导数总为正或有限个零（一直递增），或总为负或有限个零（一直递减），那么函数有反函数。[10.2]
* **反正弦函数**：$f(x)=sin^{-1}(x)=arcsin(x)$，为奇函数，$x \in [-1, 1]$，$y \in [-\frac{\pi}{2}, \frac{\pi}{2}]$
* **反余弦函数**：$f(x)=cos^{-1}(x)=arccos(x)$，为非奇非偶函数，$x \in [-1, 1]$，$y \in [0, \pi]$
* 对于在区间$[-1,1]$上任意的$x$，$sin^{-1}+cos^{-1}(x)=\frac{\pi}{2}$
* **反正切函数**：$f(x)=tan^{-1}(x)=arctan(x)$，为奇函数，$x \in \mathbb{R}$，$y \in [-\frac{\pi}{2}, \frac{\pi}{2}]$
* **反余切函数**：$f(x)=cot^{-1}(x)=arccot(x)$，为非奇非偶函数，$x \in \mathbb{R}$，$y \in [0, \pi]$
* **反正割函数**：$f(x)=sec^{-1}(x)=arcsec(x)$，为非奇非偶函数，$x \in (-\infty,-1] \cup [1,\infty)$，$y \in [0,\pi] \setminus \{ \frac{\pi}{2} \}$
* **反余割函数**：$f(x)=csc^{-1}(x)=arccsc(x)$，为奇函数，$x \in (-\infty,-1] \cup [1,\infty)$，$y \in [-\frac{\pi}{2},\frac{\pi}{2}] \setminus \{ 0 \}$
    

# 双曲函数
双曲函数实际上是伪装的指数函数 [9.8]

* 定义
    * **双曲正弦函数**：<span style="color:orange;">$sinh(x)=\frac{e^x - e^{-x}}{2}$</span>
    * **双曲余弦函数**：<span style="color:orange;">$cosh(x)=\frac{e^x + e^{-x}}{2}$</span>
    * **双曲正切函数**：$tanh(x)=\frac{sinh(x)}{cosh(x)}$
    * **双曲余切函数**：$coth(x)=\frac{cosh(x)}{sinh(x)}$
    * **双曲正割函数**：$sech(x)=\frac{1}{cosh(x)}$
    * **双曲余割函数**：$csch(x)=\frac{1}{sinh(x)}$

* 性质
    * $cosh(x)$是偶函数：<span style="color:orange;">$cosh(-x)=cosh(x)$</span>
    * $sinh(x)$是奇函数：<span style="color:orange;">$sinh(-x)=-sinh(x)$</span>
    * <span style="color:orange;">$cosh(0)=1$</span>
    * <span style="color:orange;">$sinh(0)=0$</span>
    * <span style="color:orange;">$cosh^2{x} - sinh^2(x) = 1$</span>
            

# 反双曲函数
[10.3]

* **反双曲正弦函数**：$f(x)=sinh^{-1}(x)=arcsinh(x)=ln(x+\sqrt{x^2+1})$，为奇函数，$x \in \mathbb{R}$，$y \in \mathbb{R}$
* **反双曲余弦函数**：$f(x)=cohh^{-1}(x)=arccosh(x)=ln(x+\sqrt{x^2-1})$，为非奇非偶函数，$x \in [1,\infty)$，$y \in [0,\infty)$
* **反双曲正切函数**：$f(x)=tanh^{-1}(x)=arctanh(x)=ln(x+\sqrt{x^2+1})$，为奇函数，$x \in (-1,1)$，$y \in \mathbb{R}$
* **反双曲余切函数**：$f(x)=coth^{-1}(x)=arccoth(x)=ln(x+\sqrt{x^2+1})$，为奇函数，$x \in (-\infty,-1) \cup (1,\infty)$，$y \in \mathbb{R} \setminus {0}$
* **反双曲正割函数**：$f(x)=sech^{-1}(x)=arcsech(x)=ln(x+\sqrt{x^2+1})$，为非奇非偶函数，$x \in (0,1]$，$y \in [0,\infty)$
* **反双曲余割函数**：$f(x)=csch^{-1}(x)=arccsch(x)=ln(x+\sqrt{x^2+1})$，为奇函数，$x \in \mathbb{R} \setminus {0}$，$y \in \mathbb{R} \setminus {0}$


# 极限导论 $lim$

* 极限定义 [3]
    * **左侧极限**：$\lim_{x \to a^-} f(x) = L$，$x$在$a$处减一点点的函数值（不关心当$x=a$时函数的值是什么，哪怕没有值）。
    * **右侧极限**：$\lim_{x \to a^+} f(x) = L$，$x$在$a$处加一点点的函数值（不关心当$x=a$时函数的值是什么，哪怕没有值）。
    * **双侧极限**：$\lim_{x \to a} f(x) = L$，仅当$\lim_{x \to a^-} f(x) = \lim_{x \to a^+} f(x) = L$（不关心当$x=a$时函数的值是什么，哪怕没有值）。
    * **垂直渐近线**：如果$\lim_{x \to a^-} f(x)$或$\lim_{x \to a^+} f(x)$等于$\pm\infty$，那么$x=a$就是$f(x)$的垂直渐近线。一个函数可以有多条垂直渐近线，如$y=tan(x)$。
    * **水平渐近线**：如果$\lim_{x \to -\infty} f(x)$或$\lim_{x \to \infty} f(x)$等于$a$，那么$y=a$就是$f(x)$的垂直渐近线。一个函数可以有不同的左侧和右侧水平渐近线，但最多只有一条左侧水平渐近线和一条右侧水平渐近线。如$\lim_{x \to -\infty}tan^{-1}(x)=-\frac{\pi}{2}$，$\lim_{x \to \infty}tan^{-1}(x)=\frac{\pi}{2}$。
    * **函数与渐近线相交**：一个函数可以和它的水平渐近线相交，例如$\lim_{x \to \infty}\frac{sin(x)}{x}=0$，$x$在接近$\infty$时无限次与$x$轴相交。
    * **<span style="color:red;">夹逼定理（三文治定理）</span>**：如果$g(x) \leq f(x) \leq {h(x)}$，且$\lim_{x \to a}g(x)=L$，$\lim_{x \to a}h(x)=L$，那么$\lim_{x \to a}f(x)=L$。
    * **和（差）的极限等于极限的和（差）**：当所有分项的极限都是有限的时候成立（即分项都不是$\pm\infty$时）
    * **积（商）的极限等于极限的积（商）**：当所有分项的极限都是有限的时候成立（即分项都不是$\pm\infty$时）

* 多项式极限 [4]
    * 一般采用代入法计算极限。
    * 如果分母为$0$但分子不为$0$，则极限为$\pm \infty$，符号看$x \to a$时函数值的符号，但请注意左右极限的值不一定相等。
    * 如果上述的方法不凑巧，可以尝试消除分子分母的公因子，或分子分母同时乘以分子或分母的共轭表达式。
    * 对于任意$n > 0$，只要$C$是常数，就有$lim_{x \to \pm \infty}\frac{C}{x^n}=0$。
    * 求多项式的极限时，其最高次项决定一切，即$\lim_{x \to \infty}\frac{p(x)}{p_L(x)}=1$（其中$p_L(x)$为$p(x)$的最高次项），可以基于这个原理化解多项式的极限，通常的做法是吧$p(x)$化解成$\frac{p(x)}{p_L(x)}p_L(x)$，从而消除非最高次项。


* 指数与对数极限 [9.6]
    * e的定义 [9.4]
        * <span style="color:red;">$\lim_{n \to \infty}(1+\frac{1}{n})^n=e$</span>
        * $lim_{h \to 0}(1+h)^{\frac{1}{h}}=e$
        * <span style="color:red;">$\lim_{n \to \infty}(1+\frac{x}{n})^n=e^x$</span>
        * $\lim_{h \to 0}(1+xh)^{\frac{1}{h}}=e^x$
    * $\lim_{h \to 0}\frac{e^h - 1}{h}=1$：通过使用定义法求$\frac{d}{dx}(e^x)=e^x=\lim_{h \to 0}\frac{e^{x+h}-e^x}{h}$，取$x=0$处的值得出。
    * $\lim_{h \to 0}\frac{ln(1+h)}{h}=1$：通过使用定义法求$\frac{d}{dx}ln(x)=\frac{1}{x}=\lim_{h \to 0}\frac{ln(x+h)-ln(x)}{h}$，取$x=1$处的值得出。亦可以使用线性化公式证明：$\lim_{h \to 0} ln(1+h)=ln(1)+ln'(1)(1+h-1)=h$。
    * 当$x \to \infty$: <span style="color:red;">$log_b(x) < x^n < b^x$</span>, where $n > 0, b > 1$, 也就是说增速排序：对数 $ < $ 幂 $ < $ 指数
        * $\lim_{x \to \infty} \frac{log_b(x)}{x^n}=0$
        * $\lim_{x \to \infty} \frac{x^n}{b^x}=0$
        * $\lim_{x \to 0^+} x^n log_b(x)=0$ (let $x=\frac{1}{t}$ to make it become $\lim_{t \to \infty}\frac{-log_b(t)}{t^n}=0$)
        
* 三角函数的极限 [7.1]
    * <span style="color:red;">$sin(x) < x < tan(x)$</span>, when $0 < x < \frac{\pi}{2}$（通过单位圆内角度为$x$的扇形与相邻两个直角三角形的面积证明）
    * <span style="color:red;">$\lim_{x \to 0}\frac{sin(x)}{x}=1$</span>：$x$可以替换为任何小的数，例如$\lim_{x \to 0}\frac{sin(3x^7)}{3x^7}=1$（通过$sin(x) < x < tan(x)$证明）
    * <span style="color:red;">$\lim_{x \to 0}\frac{tan(x)}{x}=1$</span>：$x$可以替换为任何小的数，例如$\lim_{x \to 0}\frac{tan(3x^7)}{3x^7}=1$（通过$\lim_{x \to 0}\frac{sin(x)}{x}=1$证明）
    * <span style="color:red;">$\lim_{x \to 0}\frac{1-cos(x)}{x}=0$</span>（乘以分子共轭表达式，通过$\lim_{x \to 0}\frac{sin(x)}{x}=1$证明）
    * $\lim_{x \to \infty}\frac{sin(\theta)}{x^\alpha}=0$：when $\alpha > 0$, $\theta$ could be any number
    * $\lim_{x \to \infty}\frac{cos(\theta)}{x^\alpha}=0$：when $\alpha > 0$, $\theta$ could be any number

* 反三角函数的极限 [10.2]
    * $\lim_{x \to -\infty}tan^{-1}(x)=-\frac{\pi}{2}$, $\lim_{x \to \infty}tan^{-1}(x)=\frac{\pi}{2}$
    * $\lim_{x \to -\infty}cot^{-1}(x)=\pi$, $\lim_{x \to \infty}cot^{-1}(x)=0$
    * $\lim_{x \to -\infty}sec^{-1}(x)=\frac{\pi}{2}$, $\lim_{x \to \infty}sec^{-1}(x)=\frac{\pi}{2}$
    * $\lim_{x \to -\infty}csc^{-1}(x)=0$, $\lim_{x \to \infty}csc^{-1}(x)=0$
        

# 连续性和可导性
函数图像通常满足**垂线检验**即可，进一步的要求，我们可以考虑要求其有**连续性**，即可以通过一笔勾画出来，甚至它是**光滑**（可导）的，即图像不会出现尖角。
    
* 连续性 [5.1]
    * **在一点处的连续**：如果<span style="color:red;">$\lim_{x \to a}f(x)=f(a)$</span>（即有左右极限且它们相等），那么函数$f(x)$在点$x=a$处连续（其实就是函数$f(x)$在点$x=a$处不跳跃）。
    * **在一个区间上连续**：如果函数在区间$(a,b)$上的每一点都连续，那么它在该区间上连续，如果同时$\lim_{x \to a^+}f(x)=f(a)$且$\lim_{x \to b^-}f(x)=f(b)$，那么它在区间$[a,b]$也连续。
    * **运算后的连续性**：两个连续函数的加、减、乘、除（分母不能为零）、复合后，仍然是连续函数。
    * **连续函数**：多项式函数（幂函数）、指数函数、对数函数、三角函数都是连续函数。
    * **<span style="color:red;">介值定理</span>**：如果$f$在$[a,b]$上**连续**，并且$f(a) < M$且$f(b) > M$，那么在区间$(a,b)$上至少有一点$c$，使得$f(c)=M$。代之以$f(a) > M$且$f(b) < M$，同样成立。
    * **<span style="color:red;">最值定理</span>**：如果$f$在$[a,b]$（必须是闭区间）上**连续**，那么$f$在$[a,b]$上至少有一个最大值和一个最小值。

* 可导性（光滑性）[5.2]
    * **平均速率**：$Average Speed = \frac{Distance}{Time}$
    * **平均速度**：$Average Velocity = \frac{Displacement}{Time}$
    * **瞬时速度**：$Instant Velocity = \lim_{u \to t}v_{t \leftrightarrow u} = \lim_{u \to t}\frac{f(u)-f(t)}{u-t} = \lim_{h \to 0}\frac{f(t+h)-f(t)}{h}$
    * **函数的导数**：通过点$(x,f(x))$的切线的斜率（slope）是$x$的一个函数，这个函数被称为$f$的导数，记作$f'$或$\frac{d}{dx}f(x)$
    * **导数的含义**：当$x$稍作改变时，$y$的变化有多大（含正负号）
    * **$\Delta_x$与$dx$**：$\Delta_x$表示$x$的变化，$dx$表示$x$的**十分微小**的变化。
    * **求导公式**：<span style="color:red;">$f'(x)=\lim_{h \to 0}\frac{f(x+h)-f(x)}{h}$</span>$=\lim_{\Delta_{x} \to 0}\frac{\Delta_y}{\Delta_x}=\frac{dy}{dx}$，即对于$x$，如果左右极限存且相等在则函数在$x$处可导。请注意$\frac{dy}{dx}$不是一个分数，而是当$\Delta_x \to 0$时的一个极限。
    * **二阶导数**：导数的导数称为二阶导数，表示为$f''$或$f^{(2)}(x)$或$\frac{d^2y}{dx^2}$或$\frac{d^2}{dx^2}(\ldots)$
    * **注意事项**：请注意$(\frac{dy}{dx})^2$和$\frac{d^2y}{d^2x}$是完全不同的，前者是一阶导数的平方，后者是一个二阶导数。
    * **高阶导数**：高阶导数可以表示为$f^{(n)}(x)$或$\frac{d^ny}{dx^n}$或$\frac{d^n}{dx^n}(\ldots)$
    * **左导数**：$\lim_{x \to a^-}f^{'}(x)=\lim_{h \to 0^-}\frac{f(x+h)-f(x)}{h}$
    * **右导数**：$\lim_{x \to a^+}f^{'}(x)=\lim_{h \to 0^+}\frac{f(x+h)-f(x)}{h}$
    * **连续与可导的关系**：可导函数一定连续，但连续函数未必可导（比如尖角处，代表函数的突然变化）
    * **函数及其导数的图像**：原函数平坦时，导函数与$x$轴相交（即该点导数为零）。原函数是一条斜直线时，导函数是一个常数。原函数在某点不光滑（不可导），则其导数在该点不连续。原函数有渐近线，则其导数也会有渐近线，只不过导数的渐近线没有原函数的渐近线那么陡。


# 微分 $\frac{dy}{dx}$
    
* 求导法则 [6.1]
    * **加法法则**：<span style="color:red;">$\frac{d}{dx}(u+v)=\frac{du}{dx}+\frac{dv}{dx}$</span>
    * **乘法法则**：<span style="color:red;">$\frac{d}{dx}(uv)=\frac{du}{dx}v+u\frac{dv}{dx}$</span>
    * **乘法法则**：<span style="color:red;">$\frac{dy}{dx}(uvw)=\frac{du}{dx}vw+u\frac{dv}{dx}w+uv\frac{dw}{dx}$</span>
    * **除法法则**：<span style="color:red;">$\frac{dy}{dx}(\frac{u}{v})=\frac{\frac{du}{dx}v-u\frac{dv}{dx}}{u^2}$</span>
    * **链式法则**：<span style="color:red;">$\frac{dy}{dx}=\frac{dy}{du}\frac{du}{dx}$</span>
    * **链式法则**：<span style="color:red;">$\frac{dy}{dx}=\frac{dy}{dv}\frac{dv}{du}\frac{du}{dx}$</span>

* 多项式函数的导数 [6.1]
    * **线性函数**：<span style="color:orange;">$\frac{d}{dx}(mx+b)=m$</span>
    * **幂函数**：<span style="color:orange;">$\frac{d}{dx}(x^a)=ax^{a-1}$</span>
    * **常数函数**：$\frac{d}{dx}(C)=0$
    * **幂函数的常数倍**：$\frac{d}{dx}(Cx^a)=Cax^{a-1}$。

* 指数和对数函数的导数 [9.5]
    * <span style="color:orange;">$\frac{d}{dx}log_b(x)=\frac{1}{x ln(b)}$</span>
    * $\frac{d}{dx}log_e(x)=\frac{1}{x}$
    * <span style="color:orange;">$\frac{d}{dx}(b^x)=b^x ln(b)$</span>
    * $\frac{d}{dx}(e^x)=e^x$

* 三角函数的导数 [7.2]
    * <span style="color:orange;">$\frac{d}{dx}sin(x)=cos(x)$</span>
    * <span style="color:orange;">$\frac{d}{dx}cos(x)=-sin(x)$</span>
    * <span style="color:orange;">$\frac{d}{dx}tan(x)=sec^2(x)$</span>
    * <span style="color:orange;">$\frac{d}{dx}cot(x)=-csc^2(x)$</span>
    * <span style="color:orange;">$\frac{d}{dx}sec(x)=sec(x)tan(x)$</span>
    * <span style="color:orange;">$\frac{d}{dx}csc(x)=-csc(x)cot(x)$</span>
    * (记忆：$cos/cot/csc$的导数是正常函数形式，前面加上一个负号)
    * $\frac{d^2}{dx^2}sin(x)=-sin(x)$

* 反三角函数的导数 [10.2]
    * $\frac{d}{dx}sin^{-1}(x)=\frac{1}{\sqrt{1-x^2}}$，其中$x \in (-1, 1)$
    * $\frac{d}{dx}cos^{-1}(x)=-\frac{1}{\sqrt{1-x^2}}$，其中$x \in (-1, 1)$
    * $\frac{d}{dx}tan^{-1}(x)=\frac{1}{1+x^2}$，其中$x \in \mathbb{R}$
    * $\frac{d}{dx}cot^{-1}(x)=-\frac{1}{1+x^2}$，其中$x \in \mathbb{R}$
    * $\frac{d}{dx}sec^{-1}(x)=\frac{1}{|x|\sqrt{x^2-1}}$，其中$x \in (-\infty,-1) \cup (1,\infty)$
    * $\frac{d}{dx}csc^{-1}(x)=-\frac{1}{|x|\sqrt{x^2-1}}$，其中$x \in (-\infty,-1) \cup (1,\infty)$

* 双曲函数的导数 [9.8.2]
    * $\frac{d}{dx}sinh(x)=cosh(x)$
    * $\frac{d}{dx}cosh(x)=sinh(x)$
    * $\frac{d}{dx} tanh(x)=sech^2(x)$
    * $\frac{d}{dx} coth(x)=-csch^2(x)$
    * $\frac{d}{dx} sech(x)=-sech(x) tanh(x)$
    * $\frac{d}{dx} csch(x)=-csch(x) coth(x)$

* 反双曲函数的导数 [10.3]
    * $\frac{d}{dx}sinh^{-1}(x)=\frac{1}{\sqrt{x^2+1}}$，其中$x \in \mathbb{R}$
    * $\frac{d}{dx}cosh^{-1}(x)=\frac{1}{\sqrt{x^2-1}}$，其中$x \in [1,\infty)$
    * $\frac{d}{dx}tanh^{-1}(x)=\frac{1}{1-x^2}$，其中$x \in (-1,1)$
    * $\frac{d}{dx}coth^{-1}(x)=\frac{1}{1-x^2}$，其中$x \in (-\infty,-1) \cup (1,\infty)$
    * $\frac{d}{dx}sech^{-1}(x)=-\frac{1}{x\sqrt{1-x^2}}$，其中$x \in (0,1)$
    * $\frac{d}{dx}csch^{-1}(x)=-\frac{1}{|x|\sqrt{1+x^2}}$，其中$x \in \mathbb{R} \setminus {0}$
            

# 微分应用
* **相关变化率**：量$Q$的变化率是$Q$关于时间的导数，即$\frac{dQ}{dt}$ [8]
* **隐函数求导**：无需特意写成关于$t$的函数再取导，对方程（隐函数）两边同时对$t$取导数，即可以得出某个变量的变化率 [8]
* 指数增长与衰变 [9.7]
    * 如果一个量变化的速率取决与这个量的大小，即$\frac{dy}{dx}=ky$，那么$y=Ae^{kx}$，其中A为常数，$k$称为**增长常数**。
    * **指数增长方程**：$P(t)=P_0 e^{kt}$，$P_0$是初始的总数，$k$是增长常数
    * **指数衰退方程**：$P(t)=P_0 e^{-kt}$，$P_0$是初始的总数，$-k$是衰变常数
    * 对于半衰期为$t_{1/2}$的放射性衰变，$P(t)=P_0 e^{-kt}$，其中$k=\frac{ln(2)}{t_{1/2}}$
* **反函数的导数**：<span style="color:red;">如果$y=f^{-1}(x)$，则$\frac{dy}{dx}=\frac{1}{f'(y)}=\frac{1}{f'(f^{-1}(x))}$</span> [10.1]


# 导数和图像
* 函数的极值 [11.1]
    * **<span style="color:orange;">临界点</span>**：如果函数$x=x$处的导数为零或导数不存在，我们就称为$x=c$为临界点。
    * **极值定理**：假设函数$f$定义在开区间$(a,b)$内，并且$c \in (a,b)$，如果$c$为函数的局部最大值或最小值，那么点$c$一定为该函数的临界点。
    * **最值一定是临界点，临界点不一定是最值**（想象函数$y=x^3$的$0$点处）。
    * **在一个闭区间内，局部最大值或最小值只可能出现在临界点或该区间的端点**。
    * **求最值的方法**：在导数为零的点和端点中，计算函数值，找到最大值和最小值。
* 相关定理 [11.2]
    * **<span style="color:red;">罗尔定理</span>**：假设函数$f$在闭区间$[a,b]$内连续，在开区间$(a,b)$内可导，如果$f(a)=f(b)$， 那么在开区间$(a,b)$内至少存在一点$c$，使得$f'(x)=0$。（可通过中值定理导出）
    * **<span style="color:red;">中值定理</span>**：假设函数$f$在闭区间$[a,b]$内连续，在开区间$(a,b)$内可导，那么在开区间$(a,b)$内至少有一点$c$使得$f'(c)=\frac{f(b)-f(a)}{b-a}$。（即点$c$的斜率）
    * **推论1**：如果对于在定义域$(a,b)$内的所有$x$，都有$f'(x)=0$，那么函数$f$在开区间$(a,b)$内常数函数。
    * **推论2**：如果对于任意实数都有$f'(x)=g'(x)$，那么有$f(x)=g(x)+C$（$C$为常数）。
*  二阶导数和图像 [11.3]
    * **<span style="color:orange;">拐点</span>**：函数图像从凹向上（下）变为凹向下（上）的点称为拐点。
    * **水平拐点**：不仅是拐点，且通过该点的切线也是水平的。
    * **拐点处的切线**：拐点处的切线把函数图像分为一上一下两部分。
    * 如果$x=c$是函数$f$的拐点，则一定有$f''(c)=0$。但如果$f''(c)=0$，则$x=c$未必是函数$f$的拐点。
*  对导数为零点的分类 [11.4]
    * **导数为零的可能性**：当$f'(c)=0$，则对于点$c$有以下的可能性：
        * $c$为局部最大值
        * $c$为局部最小值
        * $c$为水平拐点
    * **情况判断 - 使用一阶导数**：假设$f'(c)=0$，
        * 如果从左往右通过$c$点，$f'(x)$的符号由正变负，那么$c$点为局部最大值
        * 如果从左往右通过$c$点，$f'(x)$的符号由负变正，那么$c$点为局部最小值
        * 如果从左往右通过$c$点，$f'(x)$的符号不发生变化，那么$c$点为水平拐点
    * **情况判断 - 使用二阶导数**：假设$f'(c)=0$，
        * 如果$f''(c) < 0$（向下凹），那么$c$点为局部最大值
        * 如果$f''(c) > 0$（向上凹），那么$c$点为局部最小值
        * 如果$f''(c)=0$，那么无法判断，需要使用一阶导数判断
* 绘制导数图像 [12]
    * **原理**：用极限去找渐进线，用一阶导数去找极大值和极小值，使用二阶导数去找函数的凹凸性
    * **函数符号表格**：找到函数、其一阶导数、其二阶导数的零点和不连续点，以及它们之间的随意点，分别判断他们的正负、斜上斜下、凹凸性
    * **绘制函数图像的全面方法**：
        * 定义域和对称性
        * $y$轴截距：让$x=0$求$y$
        * $x$轴截距：让$y=0$求$x$
        * 垂直渐近线（或可去不连续点）：分母为0的位置
        * 水平渐近线：$lim_{x \to \infty} f(x)$和$lim_{x \to -\infty} f(x)$
        * 函数的正负
        * 一阶导数的正负和临界点
        * 二阶导数的正负和拐点
                    

# 最优化和线性化
* 最优化 [13.1]
    * **最优化**：列出目标函数，在一阶导数为零的临界点中寻找最大值或最小值，通过二阶导数的正负校验是否为最大值或最小值。
* 线性化 [13.2]
    * **线性化**：线性函数<span style="color:red;">$L(x)=f(a)+f'(a)(x-a)$</span>被称为函数$f$在$x=a$处的线性化函数。（使用了直线的点斜式表示）
    * **线性化求模拟值**：通过某一点的切线函数求切点附近的模拟值。$f(x) \approx L(x)=f(a)+f'(a)(x-a)$，$a$为切点，$f(x)$为原函数，$L(x)$为函数$f(x)$在$x=a$处的线性化函数。
    * **微分**：$f(a+\Delta x) \approx f(a)+f'(a)\Delta x$，其中$df=f'(a) \Delta x$被称为函数$f$在$x=a$处的微分，表示当$x=a \to a+ \Delta x$时$f$变化量的近似值。
    * 模拟值误差<span style="color:orange;">$r(x)=f(x)-L(x)=\frac {1}{2} f''(c)(x-a)^2$</span>，其中$c \in (x,a)$，通过$f''(c)$的正负号可以判断模拟值偏大（高估）还是偏小（低估）。
* 牛顿法 [13.3]
    * **牛顿法**：假设$a$是对方程$f(x)=0$的解的一个近似，如果令<span style="color:orange;">$b=a-\frac{f(a)}{f'(a)}$</span>，则在很多情况下，$b$是个比$a$更好的近似。
    * **失效的四种情况**：
        * $f'(a)$的值接近于$0$，为了避免出现这种情况，要确保初始猜测不在函数$f$的临界点附近
        * 如果$f(x)=0$有不止一个解，可能得到的不是你想要的那个解
        * 陷入循环一直重复，无法更进一步
        * 近似值有可能会变得越来越偏离
* 通过洛必达法则求极限 [14]
    * **极限的主要形式**：
        * A型$\frac{0}{0}$, $\frac{\pm \infty}{\pm \infty}$（称为**不定式**）：$\lim_{x \to a} \frac {f(x)}{g(x)}$
        * B1型$\pm(\infty - \infty)$：$\lim_{x \to a} (f(x)-g(x))$
        * B2型$0 \times \pm \infty$：$\lim_{x \to a} f(x)g(x)$
        * C型$1^{\pm \infty}$, $0^0$, $\infty^0$：$\lim_{x \to a} f(x)^{g(x)}$
        * B1 -> A, C -> B2 -> A
    * **$\frac{0}{0}$型极限**：如果$f(a)=g(a)=0$，那么<span style="color:red;">$\lim_{x \to a} \frac{f(x)}{g(x)}=\lim_{x \to a} \frac{f'(x)}{g'(x)}$</span>（通过点$a$的线性化$f(x) \approx f(a)+f'(a)(x-a)$和$g(x) \approx g(a)+g'(a)(x-a)$得出）
    * **$\frac{\pm \infty}{\pm \infty}$型极限**：照样可以使用洛必达法则。
    * B1型可以尝试分子分母同时乘以除以一个共轭表达式，转换成A型后使用洛必达法则。
    * B2型可以尝试把较简单的一个因子取倒数移动到分母，转换成A型后使用洛必达法则。
    * C型可以取对数后化成B2型，之后尝试转换成不定式后使用洛必达法则，得到极限后取指数。
            

# 积分基础 $\int$
[15.1]

* **定积分和不定积分** [17.4]
    * **定积分**: 有积分上下限的为定积分$\int_a^b f(x)dx=F(b)-F(a)$（$F$为$f$的任一反导数），代表一个数。
    * **不定积分**: 没有积分上下限的为不定积分$\int f(x)dx=F(x)+C$（$C$为任意常数，$F$为$f$的任一反导数），代表一个函数集合。
* **定积分的概念**：$\int_a^b f(x)dx$，表示函数$f(x)$对于$x$从$a$到$b$的积分，$f(x)$称为**被积函数**，$a$和$b$称为**积分极限**或**积分端点**，$dx$表示对$x$进行积分。 [16.1]
* **定积分的意义**：$\int_a^b f(x)dx$，表示由曲线$y=f(x)$，两条垂线$x=a$和$x=b$，以及$x$轴所围成的有向面积（平方单位）。 [16.1]
* **定积分的定义**：$\int_a^b f(x)dx=\lim_{mesh \to 0} \sum_{j=1}^n f(c_j)(x_j-x_{j-1})$，其中$a=x_0 < x_1 < \dots < x_{n-1} < x_n=b$，并且对每一个$j=1,\dots,n$都有$c_j$在$[x_{j-1},x_j]$内。[16.2]
    * 其中$\sum_{j=1}^n f(c_j)(x_j-x_{j-1})$称为**黎曼和**。
    * 积分符号$\int$可以理解成$\sum$，只不过是当$mesh \to 0$时的极限

* **定积分的性质**：对于可积函数$f$和$g$，任意常数$a$，$b$，$c$
    * **对调积分上下限**：$\int_a^b f(x)dx=-\int_b^a f(x)dx$ [16.3]
    * **积分上下限相等**：$\int_a^a f(x)dx=0$ [16.3]
    * **可以把积分表达式切开**：$\int_a^b f(x)dx=\int_a^c f(x)dx+\int_c^b f(x)dx$ [16.3]
    * **常数可以被移到积分表达式的外面**：<span style="color:blue;">$\int cf(x)dx=c\int f(x)dx$</span> [17.6]
    * **和差的积分等于积分的和差**：<span style="color:blue;">$\int (f(x)+g(x))dx=\int f(x)dx + \int g(x)dx$</span> [17.6]
    * **常数的定积分**：$\int_a^b cdx=c(b-a)$ [16.1]
    * **奇函数的定积分**：如果$f(x)$为奇函数，$\int_{-a}^a f(x)dx=0$（可通过换元法把$x$替换为$-t$得到） [16.1,18.1]

* **位移**：$\int_a^b v(t)dt$ [16.1]
* **路程**：$\int_a^b |v(t)|dt$ [16.1]
* **面积** [16.4]
    * **求通常的面积$\int_a^b |f(x)|dx$**：
        * 找出在$[a,b]$区间内满足$f(x)=0$的所有$x$的值（$0$值点）；
        * 在$a$点、所有$0$值点、$b$点所做成的所有相邻区间内求函数$f(x)$的积分；
        * 对各个积分的绝对值求和。
    * **求两条曲线之间的面积**：$\int_a^b |f(x)-g(x)|dx$，注意要使用$f(x)-g(x)$的零值点分段求解。
    * **求曲线与$y$轴所围成的面积**：如果$f(x)$存在反函数，由函数$y=f(x)$、直线$y=A$、直线$y=B$、$y$轴所围成的面积为$\int_A^B f^{-1}(y)dy$
* **积分估算** [16.5]
    * 如果对于在区间$[a,b]$内的所有$x$都有$f(x) \le g(x)$，那么$\int_a^b f(x)dx \le \int_a^b g(x)dx$
    * 如果对于在区间$[a,b]$内的所有$x$都有$m \le f(x) \le M$，那么$m(b-a) \le \int_a^b f(x)dx \le M(b-a)$
* **函数的平均值**：函数$f$在区间$[a,b]$内的平均值为$\frac{1}{b-a} \int_a^b f(x)dx$ [16.6]
* **<span style="color:red;">积分的中值定理</span>**：如何函数$f$在闭区间$[a,b]$上连续，在开区间$(a,b)$内总有一点$c$满足$(b-a)f(c)=\int_a^b f(x)dx$ [16.6]
* **可积函数**：与可导的情况不同，即使是不连续的函数，只要它有有限个不连续的点，该函数也是可积的，也就是说定积分$\int_a^b f(x)dx$存在。[16.7]
    

# 不定积分
    
* **定积分通式**：<span style="color:red;">$F(x)=\int_a^x f(t)dt$</span>，表示由曲线$y=f(t)$、$t$轴、$t=a$、$t=x$围成区域的面积。其中$t$称为虚拟变量。[17.1]
* **积分下限变换**：把积分下限从一个常数换至另一个常数，变化前后只相差一个常数：设$F(x)=\int_a^x f(t)dt$，$H(x)=\int_b^x f(t)dt$，$C$为常数，那么$F(x)=\int_a^b f(t)dt + \int_b^x f(t)dt = H(x) + C$ [17.1]
* **微积分的第一基本定理**：如果函数$f$在闭区间$[a,b]$上是连续的，定义$F(x)=\int_a^x f(t)dt, x \in [a,b]$，则$F$在开区间$(a,b)$内是可导函数，而且$F'(x)=f(x)$，即<span style="color:red;">$\frac{d}{dx} \int_a^x f(t)dt=f(x)$</span>。（通过展开$F'(x)=\lim_{h \to 0} = \frac{F(x+h)-F(x)}{h}$证明）[17.2]
* **求定积分的思路**：设$f(x)$的反导数是$F(x)$，因为$\frac{d}{dx} \int_a^x f(t)dt=f(x)$，所以$\int_a^x f(t)dt=F(x) + C$（$C$为任意常数）。通过代入$x=a$可求得$C=-F(a)$，所以<span style="color:red;">$\int_a^x f(t)dt = F(x) - F(a)$</span>。[17.2]
* **微积分的第二基本定理**：如果函数$f$在闭区间$[a,b]$上是连续的，$F$是$f$的任意一个反导数（关于$x$），那么有$\int_a^b f(x)dx = F(b) -F(a)$，记为$F(x)\big|_a^b$。[17.3]
* **求反导数的思路**：因为$\frac{d}{dx} \int_a^x f(t)dt=f(x)$，所以<span style="color:red;">函数$f(x)$的反导数为$\int_a^x f(t)dt$</span>（$a$为任意常数）。[17.2]
* **反导数的集合**：如果$\frac{d}{dx}F(x)=f(x)$，那么$\int f(x)dx=F(x)+C$，表示函数$f(x)$的反导数的集合（有无限多个）。[17.4]
* **函数导数的积分就是这个函数本身**：$\int_a^b \frac{d}{dx} F(x)dx=F(x) \big|_a^b$。[17.4]
* **不定积分公式** [17.6]
| Differential Calculus                | Integral Calculus                                   |
|--------------------------------------|-----------------------------------------------------|
| $\frac{d}{dx} x^a = ax^{a-1}$        | $\int x^a dx = \frac{x^{a+1}}{a+1}+C$ (if $a \neq -1$) |
| $\frac{d}{dx} ln(x)=\frac{1}{x}$     | $\int \frac{1}{x} dx = ln|x|+C$                     |
| $\frac{d}{dx} e^x = e^x$             | $\int e^x dx = e^x + C$                             |
| $\frac{d}{dx} b^x = b^x ln(b)$       | $\int b^x dx = \frac{b^x}{ln(b)}+C$                 |
| $\frac{d}{dx} sin(x) = cos(x)$       | $\int cos(x) dx = sin(x) + C$                       |
| $\frac{d}{dx} cos(x) = -sin(x)$      | $\int sin(x) dx = -cos(x) + C$                      |
| $\frac{d}{dx} tan(x) = sec^2(x)$     | $\int sec^2(x) dx = tan(x) + C$                     |
| $\frac{d}{dx} sec(x) = sec(x)tan(x)$ | $\int sec(x)tan(x) dx = sec(x) + C$                 |
| $\frac{d}{dx} cot(x) = -csc^2(x)$    | $\int csc^2(x) dx = -cot(x) + C$                    |
| $\frac{d}{dx} csc(x) = -csc(x)cot(x)$| $\int csc(x)cot(x) dx = -csc(x) + C$                |
| $\frac{d}{dx} sin^{-1}(x)= \frac{1}{\sqrt{1-x^2}}$ | $\int \frac{1}{\sqrt{1-x^2}} dx = sin^{-1}(x) + C$ |
| $\frac{d}{dx} tan^{-1}(x)= \frac{1}{1+x^2}$ | $\int \frac{1}{1+x^2} dx = tan^{-1}(x) + C$         |
| $\frac{d}{dx} sec^{-1}(x) = \frac{1}{\|x\|\sqrt{x^2-1}}$ | $\int \frac{1}{\|x\|\sqrt{x^2-1}} dx = sec^{-1}(x) + C$ |
| $\frac{d}{dx} sinh(x) = cosh(x)$     | $\int cosh(x) dx = sinh(x) + C$                     |
| $\frac{d}{dx} cosh(x) = sinh(x) $    | $\int sinh(x) dx = cosh(x) + C$                     |

    * 微分时，如果用$ax$替代$x$，那么每一个相应的公式乘以$a$就可以了；<br/>
    * 积分时，如果用$ax$替代$x$，那么每一个相应的公式乘以$\frac{1}{a}$就可以了。
        
* **积分的方法**:
    * **换元法**：使用$t$替换掉被积函数的的一部分，计算不定积分后，再用$x$相关的函数替换回$t$得到原函数的不定积分。[18.1]
        * $\int \frac{f'(x)}{f(x)} dx=ln|f(x)|+C$，可通过换元法把$f(x)$替换为$t$计算得到：因为$\frac{dt}{dx} = f'(x)$，从而化为$\int \frac{1}{t} dt$ [18.1]
        * $\int \frac{f'(x)}{f^n(x)} dx=(-n+1)f^{(-n+1)}(x)+C$，可通过换元法把$f(x)$替换为$t$计算得到：因为$\frac{dt}{dx} = f'(x)$，从而化为$\int t^{-n+1} dt$ [18.1]
        * $\int \frac{1}{x^2+a^2} dx = \frac{1}{a} tan^{-1}(\frac{x}{a}) + C$，通过分子分母同时除以$a^2$再把$\frac{x}{a}$替换为$t$，再利用$\frac{d}{dx} tan^{-1}(x)= \frac{1}{1+x^2}$计算得到 [18.3]
    
    * **分部积分法**：利用导数的乘法法则可以得到$\int f(x)g'(x)dx=f(x)g(x)-\int g(x)f'(x)dx$，记忆简写为$\int udv = uv - \int vdu$（对导数的乘法公式两边同时取不定积分得到）。[18.2]
    * **部分分式法**：将有理函数$\frac{g(x)}{f(x)}$分解为部分分式的形式，然后对每个部分分式求不定积分，最后将所有积分结果相加，分解部分分式的方法：[18.3]
        * 通过**多项式除法**确保函数分子的次数小于分母的次数
        * 对分母进行因式分解
        * 按分母写成部分分式的形式：
            * $\frac{X}{(x+a)} \mapsto \frac{A}{x+a}$
            * $\frac{X}{(x+a)^2} \mapsto \frac{A}{(x+a)^2} + \frac{B}{x+a}$
            * $\frac{X}{(x+a)^3} \mapsto \frac{A}{(x+a)^3} + \frac{B}{(x+a)^2} + \frac{C}{x+a}$
            * $\frac{X}{(x+a)^4} \mapsto \frac{A}{(x+a)^4} + \frac{B}{(x+a)^3} + \frac{C}{(x+a)^2} + \frac{D}{x+a}$
            * $\frac{X}{(x^2+ax+b)} \mapsto \frac{Ax+B}{(x^2+ax+b)}$
        * 求出常数A、B、C、D：通过$x$换值法或系数相等法
        * 对前4种情况，使用换元法求积分
        * 对第5种情况，尝试**因式分解后**化成部分分式，如不能因式分解则把分母写成平方的形式（**配方**，如最高项系数不为1，先提取最高项系数），换元，再化成部分分式，最后积分
* **三角积分**：
    * 可以通过以下公式化解平方根：
        * **倍角公式**：
            * $cos^2(x)=\frac{1}{2}(1+cos(2x))$
            * $sin^2(x)=\frac{1}{2}(1-cos(2x))$
        * **毕达哥拉斯定理**：
            * $sin^2(x)+cos^2(x)=1$
            * $1+tan^2(x)=sec^2(x)$
            * $1+cot^2(x)=csc^2(x)$
    * 可以通过**积化和差公式**化解三角函数的积：
        * $cos(A)cos(B)=\frac{1}{2}(cos(A-B)+cos(A+B))$
        * $sin(A)sin(B)=\frac{1}{2}(cos(A-B)-cos(A+B))$
        * $sin(A)cos(B)=\frac{1}{2}(sin(A-B)+sin(A+B))$
    * 对分母是$1+trig(x)$或$1-trig(x)$的，可以分子分母同乘以其**共轭表达式**化解（$trig(x)$表示任意三角函数）
    * $sin$或$cos$的幂：
        * 有奇次幂的，拆开一项（优先低次幂项）与$dx$搭配，剩下的利用毕达哥拉斯定理化成同一个三角函数，以多项式方式展开求解
        * 只有偶次幂的，以倍角公式降幂处理
    * $sin$的幂（约化公式）：
        * $ \int sin(x) dx = -cos(x) + C $
        * $ \int sin^2(x) dx = \int \frac{1}{2} (1-cos(2x)) dx = \frac{1}{2} x - \frac{1}{4} sin(2x) + C$ （倍角公式）
        * $ \int sin^n(x) dx $（when $n \ge 2$）
            * $ = \int sin(x)sin^{n-1}(x) dx $
            * $ = - sin^{n-1}(x)cos(x) + (n-1) \int cos^{2}(x)sin^{n-2}(x) dx $（分部积分法）
            * $ = - sin^{n-1}(x)cos(x) + (n-1) \int (1-sin^2(x))sin^{n-2}(x) dx $
            * $ = - sin^{n-1}(x)cos(x) + (n-1) \int sin^{n-2}(x) dx - (n-1) \int sin^{n}(x) dx $
            * <span style="color:blue;">$ \implies \int sin^n(x) dx = - \frac{1}{n} sin^{n-1}(x)cos(x) + \frac{n-1}{n} \int sin^{n-2}(x) dx $</span>
    * $cos$的幂（约化公式）：
        * $ \int cos(x) dx = sin(x) + C $
        * $ \int cos^2(x) dx = \int \frac{1}{2} (1+cos(2x)) dx = \frac{1}{2} x + \frac{1}{4} sin(2x) + C$ （倍角公式）
        * $ \int cos^n(x) dx $（when $n \ge 2$）
            * $ = \int cos(x)cos^{n-1}(x) dx $
            * $ = cos^{n-1}(x)sin(x) + (n-1) \int sin^{2}(x)cos^{n-2}(x) dx $（分部积分法）
            * $ = cos^{n-1}(x)sin(x) + (n-1) \int (1-cos^2(x))cos^{n-2}(x) dx $
            * $ = cos^{n-1}(x)sin(x) + (n-1) \int cos^{n-2}(x) dx - (n-1) \int cos^{n}(x) dx $
            * <span style="color:blue;">$ \implies \int cos^n(x) dx = \frac{1}{n} cos^{n-1}(x)sin(x) + \frac{n-1}{n} \int cos^{n-2}(x) dx $</span>
    * $tan$的幂（约化公式）：
        * $ \int tan(x) dx = \int \frac{sin(x)}{cos(x)} dx = -ln|cos(x)| + C $ (设$t=cos(x)$)
        * $ \int tan^2(x) dx =  \int (sec^2(x)-1) dx = tan(x) - x + C$ 
        * $ \int tan^n(x) dx $（when $n \ge 2$）
            * $ = \int (sec^2(x)-1) tan^{n-2}(x) dx $
            * $ = \int tan^{n-2}(x)sec^2(x)dx - \int tan^{n-2}(x)dx $
            * <span style="color:blue;">$ = \frac{1}{n-1}tan^{n-1}(x) - \int tan^{n-2}(x)dx $</span>
    * $cot$的幂（约化公式）：
        * $ \int cot(x) dx = \int \frac{cos(x)}{sin(x)} dx = ln|sin(x)| + C $ (设$t=sin(x)$)
        * $ \int cot^2(x) dx =  \int (csc^2(x)-1) dx = cot(x) - x + C$ 
        * $ \int cot^n(x) dx $（when $n \ge 2$）
            * $ = \int (csc^2(x)-1) cot^{n-2}(x) dx $
            * $ = \int cot^{n-2}(x)csc^2(x)dx - \int cot^{n-2}(x)dx $
            * <span style="color:blue;">$ = \frac{1}{n-1}cot^{n-1}(x) - \int cot^{n-2}(x)dx $</span>
    * $sec$的幂（约化公式）：
        * $ \int sec(x) dx = \int \frac{sec(x)tan(x) + sec^2(x)}{sec(x) + tan(x)} dx = ln|sec(x) + tan(x)| + C $
        * $ \int sec^2(x) dx = tan(x) + C $
        * $ \int sec^{n}(x) dx $（when $n \ge 2$）
            * $ = \int sec^2(x)sec^{n-2}(x) dx $
            * $ = sec^{n-2}(x)tan(x) - (n-2) \int sec^{n-2}(x)tan^2(x) dx $（分部积分法）
            * $ = sec^{n-2}(x)tan(x) - (n-2) \int sec^{n-2}(x)(sec^2(x)-1) dx $
            * $ = sec^{n-2}(x)tan(x) - (n-2) \int sec^n(x) dx + (n-2) \int sec^{n-2}(x) dx $
            * <span style="color:blue;">$ \implies \int sec^n(x) dx = \frac{1}{n-1} sec^{n-2}(x)tan(x) + \frac{n-2}{n-1} \int sec^{n-2}(x) dx $</span>
    * $csc$的幂（约化公式）：
        * $ \int csc(x) dx = \int \frac{csc(x)cot(x) + csc^2(x)}{csc(x) + cot(x)} dx = -ln|csc(x) + cot(x)| + C $
        * $ \int csc^2(x) dx = -cot(x) + C $
        * $ \int csc^{n}(x) dx $（when $n \ge 2$）
            * $ = \int csc^2(x)csc^{n-2}(x) dx $
            * $ = - csc^{n-2}(x)cot(x) - (n-2) \int csc^{n-2}(x)cot^2(x) dx $（分部积分法）
            * $ = - csc^{n-2}(x)cot(x) - (n-2) \int csc^{n-2}(x)(csc^2(x)-1) dx $
            * $ = - csc^{n-2}(x)cot(x) - (n-2) \int csc^n(x) dx + (n-2) \int csc^{n-2}(x) dx $
            * <span style="color:blue;">$ \implies \int csc^n(x) dx = - \frac{1}{n-1} csc^{n-2}(x)cot(x) + \frac{n-2}{n-1} \int csc^{n-2}(x) dx $</span>
* **三角换元法的积分**：
    * **$\sqrt{a^2-x^2}$**：设$x=asin(\theta)$换元，把$\theta,a,x$的关系看成$\theta$的对边为$a$斜边为$x$邻边为$\sqrt{x^2-a^2}$的直角三角形
    * **$\sqrt{x^2+a^2}$**：设$x=atan(\theta)$换元，把$\theta,a,x$的关系看成$\theta$的对边为$x$邻边为$a$斜边为$\sqrt{x^2+a^2}$的直角三角形
    * **$\sqrt{x^2-a^2}$**：设$x=asec(\theta)$换元，把$\theta,a,x$的关系看成$\theta$的邻边为$a$斜边为$x$对边为$\sqrt{x^2-a^2}$的直角三角形
    * 对于$\sqrt{ax^2+bx+c}$，可以通过配方、换元化成以上形式
            

# 反常积分
* **反常积分定义**：出现以下情况，$\int_a^b f(x)dx$就是反常积分
    * 函数$f$在闭区间$[a,b]$内无界（无界处成为**暴裂点**，就好像包裹的函数被暴裂了一样，里面的积分就溢出）
    * $b=\infty$
    * $a=-\infty$
* **反常积分思路**：
    * **针对破裂点**：
        * 如果函数$f(x)$仅仅在$x$接近于$a$点时无界，则$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} \int_{a+\epsilon}^b f(x)dx$
        * 如果函数$f(x)$仅仅在$x$接近于$b$点时无界，则$\int_a^b f(x)dx = \lim_{\epsilon \to 0^+} \int_{a}^{b-\epsilon} f(x)dx$
        * 如果函数$f(x)$仅仅在区间$(a,b)$内的$c$点无界，则积分可分成两部分$\int_a^b f(x)dx = \int_a^c f(x)dx + \int_c^b f(x)dx$，可化了成前面的两种情况
    * **针对边界无穷大**:
        * 如果函数$f(x)$在区间$[a,\infty)$上没有其他破裂点，则$\int_a^\infty f(x)dx = \lim_{N \to \infty} \int_a^N f(x)dx$
        * 如果函数$f(x)$在区间$(-\infty,b]$上没有其他破裂点，则$\int_{-\infty}^b f(x)dx = \lim_{N \to \infty} \int_{-N}^b f(x)dx$
        * 如果函数$f(x)$在区间$(-\infty,\infty)$上没有其他破裂点，则$\int_{-\infty}^\infty f(x)dx = \lim_{N \to \infty} \int_{-N}^a f(x)dx +\lim_{N \to \infty} \int_a^N f(x)dx$
* **反常积分办法**：
    * **比较判别法**：
        * 如果 $\int_a^b f(x)dx \ge \int_a^b g(x)dx = \infty$，$\int_a^b f(x)dx$ 一定发散。
        * 如果 $\int_a^b f(x)dx \le \int_a^b g(x)dx < \infty$，$\int_a^b f(x)dx$ 一定收敛。
    * **极限比较判别法**：
        * **渐近线等价函数**：当$x \to a$时，$f(x) \color{red} \sim \color{black} g(x)$表示$\lim_{x \to a} \frac{f(x)}{g(x)} = 1$
            * 这并不是说明当$x$接近于$a$时，$f(x)$大约等于$g(x)$（它们可能相差数百万），而是说明当$x$接近于$a$时，$f(x)$和$g(x)$的比值接近于1。
            * 渐近线等价的函数的**积**仍为渐近线等价，但加减却不成立。
        * **极限比较判别法**：如果当$x \to a$时$f(x) \sim g(x)$，且这两个函数在区间$[a,b]$上没有其他的暇点了，那么积分$\int_a^b f(x)dx$和$\int_a^b g(x)dx$会同时收敛或同时发散（虽然同时收敛，可收敛值不一定相等）。
    * **$p$ 判别法**，对于任何有限值$a>0$，
        * 当$p<1$时，积分$\int_0^a \frac{1}{x^p} dx$收敛
        * 当$p>1$时，积分$\int_a^{\infty} \frac{1}{x^p} dx$收敛
        * 其它情况都发散
    * **绝对收敛判别法**：如果积分$\int_a^b |f(x)| dx$收敛，那么$\int_a^b f(x) dx$也一定收敛。这对$\int_a^{\infty} |f(x)| dx$同样适用。
* **解题思路**：
    * 确保被积函数为正：通过取反、绝对收敛判别法
    * 没有瑕点的积分，都是收敛的
    * 有瑕点的积分：
        1. 确定区间$[a,b]$上的所有**瑕点**
        1. 将积分拆分成若干积分之和，使得每个积分至多有一个瑕点，并且瑕点在积分的上限或下限处
        1. 只有全部分部积分都收敛积分才收敛