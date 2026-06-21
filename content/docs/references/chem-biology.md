---
title: "生物学 (Biology)"
weight: 60
bookToC: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">生物学 (Biology)</div>
{{< katex />}}

从生理意义来说，**生命只不过就是化学**。

这是一个关于物质（氨基酸、蛋白质）、能量（呼吸、氧气、葡萄糖、ATP）和遗传（DNA、RNA）的故事，生物学家称之为**代谢**与**繁衍**。

# 元素

所有化学物质都由**元素**组成。元素是不能被热、电、溶剂或锤子分解的物质。

**化学反应**也不能分解元素，那只不过是**分子**的分解与重组。

## 原子

元素以其原子所带的质子数为序数，编排成了[《元素周期表》](/docs/references/chem-symbols/#%E5%85%83%E7%B4%A0%E5%91%A8%E6%9C%9F%E8%A1%A8)。

原子的质子数等于电子数，质子带正电，电子带负电，整体电荷为中性。

原子外的电子分层排布，电子层用**主量子数** n 标记：n = 1, 2, 3, 4, ...

每一层里分**亚层**：s, p, d, f

每个亚层可以有多条轨道，轨道数=2l+1，其中 l 是亚层的**角量子数**，每条轨道最多有 2 e⁻

- s: l=0，轨道数=1，球  形，最多 2 e⁻
- p: l=1，轨道数=3，双哑铃，最多 6 e⁻
- d: l=2，轨道数=5，四花瓣，最多 10 e⁻
- f: l=3，轨道数=7，八花瓣，最多 14 e⁻

每一层可出现的亚层不一样：

- n=1：1s²           => 最多 2 e⁻
- n=2：2s²,2p⁶        => 最多 8 e⁻
- n=3：3s²,3p⁶,3d¹⁰     => 最多 18 e⁻
- n≥4：4s²,4p⁶,4d¹⁰,4f¹⁴  => 最多 32 e⁻

例如**氮N**，原子序数为 7，电子层只到 n=2，电子排布：1s²2s²2p³。最多可形成 3 个**共价键**，例如**氮气NH₃**或**硝酸根NO₃⁻**（SMILES: `O=[N+]([O-])[O-]`）

![NO₃⁻](/images/docs/references/chem-biology/NO3_200x100.png)

又如**磷P**，原子序数为 15，电子层只到 n=3，电子排布：1s²2s²2p³3s²3p⁶。虽然磷在**基态**时 3d 亚层是空的，没有电子，但轨道本身存在，必要时可成键组成更多的共价键，例如**白磷P₄**或**磷酸根PO₄³⁻**（SMILES: `[O-]P(=O)([O-])[O-]`）。

![PO₄³⁻](/images/docs/references/chem-biology/PO4_3_100x100.png)

## 分子

很多原子的外层电子没有形成稳态，它们喜欢聚在一起，通过相邻电子组合成**共价键**，互相借对方的电子凑数，从而稳定下来。

例如两个氢H原子，聚合在一起组成**氢气H₂**。
又如两个氢H原子和一个氧原子O，聚合在一起组成**水H₂O**。

某些元素（比如金属元素）的原子能轻易地将电子交出去，让自己带正电荷，例如**钠离子Na⁺**。
某些元素（比如非金属元素）的原子则非常渴望自由游荡的电子，接收了这些电子后让它们带负电荷，例如**氯离子Cl⁻**。
正负电荷相互吸引，因此阳离子和阴离子拥抱在一起形成**离子键**，例如许多钠离子和氯离子挤在一起，形成正方体的**氯化钠NaCl**晶体（食盐）。
原子团也可能会带有电荷，例如**磷酸根PO₄³⁻**。

## 水

水分子HO₂由一个氧原子连接两个氢原子组成，两个氢原子与氧的连线成108度的夹角。因为氧的吸引力更大，成键的电子与氧的距离比氢的距离小一些，导致**水分子是极性分子**，氢端是它的正极，氧端是它的负极。

异性电荷相吸，水分子的正极吸引着另外一个水分子的负极，形成**氢键**，让水分子在常温下变成黏糊的液体。

任何能与水分子混合的离子或分子被称为亲水的，具有**亲水性**。当食盐晶体遇到水时，钠离子Na⁺与氯离子Cl⁻间的**离子键**会被冲破，最终离子会溶（被困）于水中。像**乙醇C2H5OH**这类分子（SMILES：`CCO`），虽然只有一个亲水端（靠OH的一端），但足以让它溶于水。

![Ethanol](/images/docs/references/chem-biology/C2H5OH_100x50.png)

另外一方面，会避开水的物质具有**疏水性**。例如**甲烷CH₄**（也叫**沼气**）是非极性的，像这种电子对称地分布在周围的分子是不能够溶于水的，例如油。

还有一类是**两亲性**分子，它们通常是带有许多亲水区和疏水区的巨大分子。

## 人体的组成元素

对人体而言，生命必需元素共有 25 种。

- 常量元素 (11)：**氧 (O)**、**碳 (C)**、**氢 (H)**、**氮 (N)**、钙 (Ca)、**磷 (P)**、硫 (S)、钾 (K)、钠 (Na)、氯 (Cl)、镁 (Mg)
- 微量元素：
  * 明确必需 (8)：铁 (Fe)、碘 (I)、锌 (Zn)、硒 (Se)、铜 (Cu)、钼 (Mo)、铬 (Cr)、钴 (Co)
  * 可能必需 (5)：锰 (Mn)、硅 (Si)、硼 (B)、钒 (V)、镍 (Ni)
  * 低量有益 (1)：氟 (F)

常量元素占人体 99.95% 体重。

仅前 4 种（O/C/H/N）就占人体 96% 以上，构成**水**、**蛋白质**、**脂肪**、**糖类**。

**水**H₂O 占人体 60% 左右。

**骨头**中占比最大元素是钙（Ca）和磷（P）。

# 生命的核心构成

## 碳（C）

有一种主宰着生命的元素，那就是碳（C）元素，它是生命的“骨架”。

碳的原子序号是6，它有4个外层电子，需再来4个电子到达稳定态。

**碳氢化合物**就是除了碳和氢之外没有其他元素的化合物。强有力的碳碳键能够形成稳定的长链，氢可以在其他空余的位置成键。碳原子与碳原子之间可以形成单键、双键或三键。碳氢链可以是链状的、环状的、树状的。

石油就是由碳氢化合物组成的。

> [!NOTE]
> 含有碳碳单键的饱和碳氢化合物叫做**烷**（wán）；含有碳碳双键的碳氢化合物叫做**烯**（xī）；含有碳碳三键的碳氢化合物叫做**炔**（quē）（**炔烃** quē tīng）。

{{% details title="常见的几类碳氢化合物" open=false %}}

**甲烷CH₄**（也叫**沼气**）是最简单的碳氢化合物。

**乙烷C₂H₆**（yǐ wán），碳碳单键（烷），饱和，SMILES：`CC`。

**乙烯C₂H₄**（yǐ xī），碳碳双键（烯），SMILES：`C=C`。

**乙炔C₂H₂**（yǐ quē），碳碳三键（炔），SMILES：`C#C`，也叫**电石气**，最简单的**炔烃**（quē tīng）。

**己烷C₆H₁₄**（jǐ wán），烷烃，碳碳单键，SMILES：`CCCCCC`。

![C6H14](/images/docs/references/chem-biology/C6H14_200x100.png)

**己烯C₆H₁₂**（jǐ xī），烯烃，碳碳双键，SMILES：`C=CCCCC`。

![C6H12](/images/docs/references/chem-biology/C6H12_200x100.png)

**己炔C₆H₁₀**（jǐ quē），炔烃，碳碳三键，SMILES：`C#CCCCC`。

![C6H10](/images/docs/references/chem-biology/C6H10_200x100.png)

**苯C₆H₆**（běn），芳香环，SMILES：`c1ccccc1`。

![C6H6](/images/docs/references/chem-biology/C6H6_200x100.png)

{{% /details %}}

**有机化合物**是一类至少包含一个碳氢键的化合物。

## 碳+氧（C+O）

氧的原子序号是8，它有2个外层电子，需再来2个电子到达稳定态。

在碳和氢的组合里加上氧元素，就形成了很多极性或两亲性分子。

典型的物质有**酸**、**醇**、**脂类**和**糖**。

> [!NOTE]
> 有COOH的叫**酸**。例如癸酸C10H19COOH（脂肪酸）。

> [!NOTE]
> 有OH离子的叫**醇**。例如乙醇C2H5OH、丙三醇C3H7OH。

> [!NOTE]
> 通常以碳的个数来用天干命名。
> 1 甲 (jiǎ) 2 乙 (yǐ) 3 丙 (bǐng) 4 丁 (dīng) 5 戊 (wù) 6 己 (jǐ) 7 庚 (gēng) 8 辛 (xīn) 9 壬 (rén) 10 癸 (guǐ)。
> 例如甲烷CH4、乙醇C2H5OH、丙三醇C3H7OH、癸酸C10H19COOH（脂肪酸）。

### 酸类（-COOH）

{{% details title="酸类" open=false %}}

**乙酸CH₃COOH**就是一种酸类，就是常说的**醋酸**（SMILES：`CC(=O)O`）

![AceticAcid](/images/docs/references/chem-biology/AceticAcid_200x100.png)

**癸酸C₁₀H₂₀O₂**也是一种酸类（SMILES：`CCCCCCCCCC(=O)O`）

![DecanoicAcid](/images/docs/references/chem-biology/DecanoicAcid_400x100.png)

{{% /details %}}

### 醇类（-OH）

{{% details title="醇类" open=false %}}

醇类如常在化妆品里面出现的**丙三醇C₃H₈O₃**（SMILES：`OCC(O)CO`）。

![Glycerol](/images/docs/references/chem-biology/Glycerol_200x100.png)

{{% /details %}}

### 脂类

{{% details title="脂类" open=false %}}

脂类比如**甘油三酯**，就是日常所说的**脂肪**，包括肥肉、食用油、体内储能组织。

甘油三酯是一类化合物，由一个丙三醇分子连接三个脂肪酸分子组成。

> [!TIP]
> 丙三醇分子像一顶帽子一样，盖在了三个脂肪酸分子上面。

三条脂肪酸链可变，例如**三癸酸甘油酯C₃₃H₆₂O₆**，分子量为 555 Da（SMILES：`CCCCCCCCCC(=O)OCC(COC(=O)CCCCCCCCC)OC(=O)CCCCCCCCC`）

![Tridecanoin](/images/docs/references/chem-biology/Tridecanoin_1300x500.png)

**胆固醇C₂₇H₄₆O**也是一种脂类，分子量为 387 Da （SMILES: `CC(C)CCCC(C)C1CCC2C3CC=C4CC(O)CCC4(C)C3CCC12C`）

![Cholesterol](/images/docs/references/chem-biology/Cholesterol_400x200.png)

脂质能够形成防水膜，并用脂肪的形式存储能量。

{{% /details %}}

### 糖类

{{% details title="糖类" open=false %}}

糖的环形分子中氢的数量通常是氧的两倍，所以常称为**碳水化合物**。

**葡萄糖C₆H₁₂O₆**，Glucose（SMILES: `OCC1OC(O)C(O)C(O)C1O`）

![Glucose](/images/docs/references/chem-biology/Glucose_300x150.png)

**果糖C₆H₁₂O₆**，Fructose，分子式和葡萄糖是一样的（SMILES: `O1C(CO)C(C(C1(CO)O)O)O`）

![Fructose](/images/docs/references/chem-biology/Fructose_300x150.png)

**蔗糖C₁₂H₂₂O₁₁**，Sucrose，相当于由一个葡萄糖分子+果糖分子组成（zhè táng，SMILES: `OCC1OC(OC2(CO)OC(CO)C(O)C2O)C(O)C(O)C1O`）

![Sucrose](/images/docs/references/chem-biology/Sucrose_400x200.png)

**乳糖C₁₂H₂₂O₁₁**，Lactose，相当于由两个葡萄糖分子组成（SMILES: `OCC1OC(O)C(O)C(O)C1OC1OC(CO)C(O)C(O)C1O`）

![Lactose](/images/docs/references/chem-biology/Lactose_400x200.png)

**核糖C₅H₁₀O₅**，Ribose，与果糖类似，少了一个碳原子和一个氧原子（SMILES: `OCC1OC(O)C(O)C1O`）

![Ribose](/images/docs/references/chem-biology/Ribose_300x150.png)

**脱氧核糖C₅H₁₀O₄**，Deoxyribose，与核糖相比，少了一个氧原子（SMILES: `C1C(C(OC1O)CO)O`）

![Deoxyribose](/images/docs/references/chem-biology/Deoxyribose_300x150.png)

{{% /details %}}

## 碳+氮+氧（C+N+O）

### 氨基酸

氨基酸（ān jī suān）是组成蛋白质的原料，人类所必须的氨基酸有20种。

{{% details title="氨基酸（20）" open=false %}}

**脂肪族非极性氨基酸**

- 甘氨酸 Glycine（SMILES：`NCC(=O)O`）

![Glycine](/images/docs/references/chem-biology/Glycine_150x75.png)

- 丙氨酸 Alanine（SMILES：`CC(N)C(=O)O`）

![Alanine](/images/docs/references/chem-biology/Alanine_200x100.png)

- 缬氨酸 Valine（xié, SMILES：`CC(C)C(N)C(=O)O`）

![Valine](/images/docs/references/chem-biology/Valine_150x150.png)

- 亮氨酸 Leucine（SMILES：`CC(C)CC(N)C(=O)O`）

![Leucine](/images/docs/references/chem-biology/Leucine_200x150.png)

- 异亮氨酸 Isoleucine（SMILES：`CCC(C)C(N)C(=O)O`）

![Isoleucine](/images/docs/references/chem-biology/Isoleucine_150x150.png)

- 脯氨酸 Proline（SMILES：`OC(=O)C1CCC[NH+]1`）

![Proline](/images/docs/references/chem-biology/Proline_150x150.png)

**极性中性氨基酸**

- 丝氨酸 Serine（SMILES：`O=C(O)C(N)CO`）

![Serine](/images/docs/references/chem-biology/Serine_200x100.png)

- 苏氨酸 Threonine（SMILES：`CC(O)C(N)C(=O)O`）

![Threonine](/images/docs/references/chem-biology/Threonine_200x100.png)

- 半胱氨酸 Cysteine（含硫，SMILES：`O=C(O)C(N)CS`）

![Cysteine](/images/docs/references/chem-biology/Cysteine_200x100.png)

- 甲硫氨酸 Methionine（含硫，SMILES：`CSCCC(N)C(=O)O`）

![Methionine](/images/docs/references/chem-biology/Methionine_200x100.png)

- 天冬酰胺 Asparagine（tiān dōng xiān àn，SMILES：`NC(=O)CC(N)C(=O)O`）

![Asparagine](/images/docs/references/chem-biology/Asparagine_200x100.png)

- 谷氨酰胺 Glutamine（gǔ ān xiān àn，SMILES：`NC(=O)CCC(N)C(=O)O`）

![Glutamine](/images/docs/references/chem-biology/Glutamine_200x100.png)

**芳香族氨基酸**

- 苯丙氨酸 Phenylalanine（SMILES：`O=C(O)C(N)Cc1ccccc1`）

![Phenylalanine](/images/docs/references/chem-biology/Phenylalanine_250x150.png)

- 酪氨酸 Tyrosine（SMILES: `O=C(O)C(N)Cc1ccc(O)cc1`）

![Tyrosine](/images/docs/references/chem-biology/Tyrosine_300x150.png)

- 色氨酸 Tryptophan（SMILES：`O=C(O)C(N)Cc1c[nH]c2ccccc12`）

![Tryptophan](/images/docs/references/chem-biology/Tryptophan_300x150.png)

- 组氨酸 Histidine（杂环芳香，SMILES：`O=C(O)C(N)Cc1c[nH]cn1`）

![Histidine](/images/docs/references/chem-biology/Histidine_250x150.png)


**酸性氨基酸**

- 天冬氨酸 Aspartic（SMILES：`O=C(O)CC(N)C(=O)O`）

![Aspartic](/images/docs/references/chem-biology/Aspartic_200x100.png)

- 谷氨酸 Glutamic（SMILES：`O=C(O)CCC(N)C(=O)O`）

![Glutamic](/images/docs/references/chem-biology/Glutamic_200x100.png)

**碱性氨基酸**

- 赖氨酸 Lysine（SMILES：`NCCCCC(N)C(=O)O`）

![Lysine](/images/docs/references/chem-biology/Lysine_300x150.png)

- 精氨酸 Arginine（SMILES：`NC(=N)NCCCCC(N)C(=O)O`）

![Arginine](/images/docs/references/chem-biology/Arginine_300x150.png)

{{% /details %}}

## 碳+氮+氧+磷（C+N+O+P）

# 其他有机物

## 多巴胺

SMILES: `NCCc1ccc(O)c(O)c1`

![Dopamine](/images/docs/references/chem-biology/Dopamine_300x150.png)

多巴胺是一种小分子**神经递质**，代谢过程如下：

1. 物蛋白质里的酪氨酸，经肝脏代谢，随血液进入大脑**多巴胺神经元**
2. $酪氨酸 \stackrel{酪氨酸羟化酶}{\implies} 左旋多巴 \stackrel{多巴脱羧酶}{\implies} 多巴胺$
3. 多巴胺被装进**突触囊泡**储存起来
4. 外界刺激产生神经冲动，传导到神经元末梢
5. 囊泡和细胞膜融合，把多巴胺释放到细胞间隙
6. 结合下游细胞受体，产生愉悦、动机信号
7. 释放完毕：大部分多巴胺被神经元回收，剩余被酶分解代谢

> [!TIP]
> 多巴胺系统本质是生物的**学习系统**，刺激生物个体不断学习与探索。
> 但现代社会中，高碳水、动作视频、电子游戏、新奇事物等变相地引起了多巴胺刺激，并导致了需求量越来越大的才能引起刺激的的上瘾机制。
> 我们对**简单的事物**、**天然的食材**、**经典的文学作品**、以及缓慢但实用的**学习本身**变得多巴胺免疫。
> **要防范非学习性、成瘾性的多巴胺刺激，回归朴素，保持多巴胺的敏感**。
