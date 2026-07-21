---
title: "Nostr"
weight: 2101
bookCollapseSection: true
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">Nostr</div>
<div class="page-info">
   <span class="organized-tag">整理</span>
  发布时间：2026-07-14 | 更新时间：2026-07-14
</div>
{{< katex />}}

[**Nostr**](https://github.com/nostr-protocol/nips/blob/master/README.md)（Notes and Other Stuff Transmitted by Relays）  
读音/ˈnɒstər/，是一套私密的去中心化的 IM 消息系统。

# 消息格式
- **id**：事件哈希，唯一标识，`SHA256(0, pubkey, created_at, kind, tags, content)`
- **pubkey**：发布者公钥（身份）
- **created_at**：时间戳
- **kind**：事件类型（0 = 元数据、1 = 短文本、3 = 关注列表等，由 NIP 定义）
- **content**：内容（文本 / JSON / 任意数据）
- **sig**：secp256k1 私钥对 id 的签名（防篡改）

# 消息加密
## NIP-04

Encrypted Direct Message (deprecated in favor of NIP-17)  
消息加密（指定收件人场景）

- AES key = ECDH(我的私钥, 对方公钥)
- 发送内容为：iv + 我的公钥 + AES 加密内容

> ECDH 为密钥交换算法，见[现代加密算法](/docs/20-cryptography/01-modern-cryptography/)

## NIP-44

Encrypted Payloads (Versioned)，  
生成**临时公私钥**用于加密而不是只使用发布者的公私钥，是一种更安全的通信加密方式。

1. 生成临时私钥和临时公钥
    > ss1 = ECDH(长期私钥, 对方公钥)  
    > ss2 = ECDH(临时私钥, 对方公钥)  
    > AES key = SHA256(ss1 + ss2)  
2. 发送内容为：iv + 长期公钥 + 临时公钥 + 加密内容
3. 接收者解密
    > ss1 = ECDH(我的私钥, 对方长期公钥)  
    > ss2 = ECDH(我的私钥, 对方临时公钥)  
    > AES key = SHA256(ss1 + ss2)  

# References

- [nostr.org](https://nostr.org/)
- [Nostr Specification](https://github.com/nostr-protocol/nips/blob/master/README.md)
