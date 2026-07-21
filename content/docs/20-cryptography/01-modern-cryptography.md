---
title: "现代加密算法"
weight: 1
bookCollapseSection: false
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">现代加密算法</div>
<div class="page-info">
   <span class="organized-tag">整理</span>
  发布时间：2026-07-14 | 更新时间：2026-07-14
</div>
{{< katex />}}

# 基本概率

- **加密**：公钥锁，私钥开。
- **签名**：私钥锁，公钥开。
- **密钥交换**：让两个人在完全不安全的网络上，不传输密钥，却能算出同一把只有他俩知道的对称密钥。

# 常见算法

- **加密**：RSA
- **签名**：RSA，ECDSA (secp256k1) ，Ed25519 (Edwards25519)
- **密钥交换**：DH，ECDH (secp256k1) ，X25519 (Curve25519)

> RSA = Rivest Shamir Adleman  
> DSA = Digital Signature Algorithm  
> Ed25519 = Edwards 2^255 - 19

# 椭圆曲线

## secp256k1

**secp256k1** 是通过椭圆曲线生成的非对称密钥
- 私钥：一个随机数
- 公钥：由私钥通过 secp256k1 算法算出

> secp256k1: Secure-Prime-256bit-Koblitz-1，Koblitz（人名）族里的第 1 条曲线  
> secp256r1: r = Random  

签名算法为 **ECDSA**，密钥交换算法为 **ECDH**

## Curve25519/Edwards25519

- 私钥：32 Bytes（256 bits）
- 公钥：32 Bytes（256 bits）

密钥很短, 签名算法为 **Ed25519**，密钥交换算法为 **X25519**，是现代高性能椭圆曲线数字签名和密钥交换算法。

# 密钥交换

> [!TIP]
> Alice 和 Bob 想要协商一份只有彼此知晓的秘密，一旁的 Eve 在全程窃听。他们约定好一条规则：首先两人公开选定黄色作为通用基础颜料；Alice 私下保存独有的红色颜料，Bob 则保管自己专属的蓝色颜料。Alice 将公开的黄色与自己的红色混合得到橙色发送给 Bob，Bob 把公开的黄色和自己蓝色混合得到绿色发送给 Alice。Eve 只能看见公开的黄色、发送的橙色与绿色，无从得知私密的红色和蓝色。随后 Alice 将收到的绿色混入自己的红色，Bob 将收到的橙色混入自己的蓝色，最终两人得到成分完全一致的颜色 - 棕色，也就是双方共享的秘密，而仅有公开颜料的 Eve，永远调配不出这份共同秘密。颜料混合十分容易，但想要把混合后的颜料重新拆分还原出原始纯色几乎无法做到。

**DH (Diffie–Hellman) 密钥交换算法**：

> DH(我的私钥, 你的公钥) = 共享密钥  
> DH(你的私钥, 我的公钥) = 共享密钥  
> 不用发送密钥，通信双方已经有了一个静态共享密钥！  
> 可以直接用于对称加密消息。

**原始 DH 使用模幂运算**：

> 公开参数：大素数 p，基数 g  
> A 的私钥：a  
> B 的私钥：b  
> A 计算并发送：A_pub = g^a mod p  
> B 计算并发送：B_pub = g^b mod p  
> 最后共享密钥：  
> A 算：B_pub ^ a mod p = g^(ab) mod p  
> B 算：A_pub ^ b mod p = g^(ab) mod p  
> 结果：一模一样！

**ECDH**（Elliptic Curve Diffie-Hellman）使用椭圆曲线的点乘：
- DH：用 g^x mod p
- ECDH：用私钥 × 基点G（椭圆曲线）
