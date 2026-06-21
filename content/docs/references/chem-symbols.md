---
title: "化学符号 (Chemical)"
weight: 50
bookToC: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">化学符号 (Chemical Symbols)</div>
{{< katex />}}

# 元素周期表

![元素周期表](/images/docs/references/chem-symbols/table_of_elements_cn.jpg)
![Table of Elements](/images/docs/references/chem-symbols/table_of_elements_en.png)

# 数字上标与下标

- 上标：⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻
- 下标：₀₁₂₃₄₅₆₇₈₉₊₋

# 化学分子结构表达

## 分子式

Molecular Formula

有些分子式相同，但却是不同的分子（同分异构），e.g. C₆H₁₂O₆，可以是葡萄糖，也可以是果糖。

e.g. 水 H₂O，Fe₂(SO₄)₃

## SMILES 线性结构式
- [] 组合表达
- () 支链（挂在旁边的基团）
- = 双键
- \# 三键
- 一般大写字母表示原子，但**芳环碳**上的碳用小写c（环上的氮也用小写n）

e.g. 葡萄糖的开链（直链）结构 `OCC(O)C(O)C(O)C(O)C=O`

e.g. 酪氨酸 `N[C@@H](Cc1ccc(O)cc1)C(O)=O`

## SMILES 立体结构式

- 第一个 1：开始环
- 第二个 1：结束环
- @ 朝某一边
- @@ 朝另一边

e.g. 葡萄糖的闭链（六元环）结构 `OC[C@H]1OC(O)[C@H](O)[C@@H](O)[C@@H]1O`

e.g. 果糖的闭链（五元环）结构 `C([C@@H]1[C@H]([C@@H]([C@](O1)(CO)O)O)O)O`

## SMILES -> 图片
```python
# pip install rdkit
from rdkit import Chem
from rdkit.Chem import Draw

mol = Chem.MolFromSmiles("OC[C@H]1OC(O)[C@H](O)[C@@H](O)[C@@H]1O")
Draw.MolToImage(mol, size=(500, 300)).save("./chem.png")
print("saved: chem.png")
```

# 反应方程式

```katex
2H_2 + O_2 \stackrel{点燃}{=\!=\!=} 2H_2O
```

```katex
2H_2 + O_2 \stackrel{点燃}{\implies} 2H_2O
```

# 基团

- 羟基 OH （去氧与氢的合体字，读 qiang3）
- 醛基 C=O（读 quan2）
