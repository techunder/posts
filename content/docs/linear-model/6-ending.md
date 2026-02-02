---
title: "结语"
weight: 50
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
{{< katex />}}
<div class="page-title">线性回归 - 结语</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-01-28 | 更新时间：2026-01-29
</div>

# 后话

## 哪种求解方法更优？
解析解求解方法更优，因为它直接给出了最优解，而梯度下降法需要迭代优化，可能会收敛到局部最优解。但梯度下降法的优势在于它可以处理大规模数据集，而解析解求解方法在数据集较大时会变得非常复杂。且当数据集包含噪声或异常值时，梯度下降法更稳定。