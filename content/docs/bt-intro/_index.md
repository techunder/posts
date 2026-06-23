---
title: "蓝牙规范"
weight: 202
bookCollapseSection: false
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">蓝牙规范</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-06-18 | 更新时间：2026-06-18
</div>
{{< katex />}}

蓝牙规范由**蓝牙技术联盟**（Bluetooth Special Interest Group，简称 Bluetooth SIG / SIG）维护。

**核心规范**是 [Bluetooth Core Specification](https://www.bluetooth.com/specifications/specs/core-specification-6-3/)，有多个版本。

**BLE**（Bluetooth Low Energy）是蓝牙核心规范里的低功耗子集，从 4.0 开始引入，向下兼容。

# 蓝牙版本

| 蓝牙版本 | 官方发布日期 | 核心标志性 |
|---|---|---|
| Bluetooth 4.0 | 2010-06-30 | BLE 诞生，双模 / 单模，AES 加密、GATT 协议 |
| Bluetooth 4.1 | 2013-12-03 | 兼容 LTE 无干扰、主从角色互换、基础 IP 通道 |
| Bluetooth 4.2 | 2014-12-04 | 数据包扩容、LE 安全连接、6LoWPAN、隐私增强 |
| Bluetooth 5.0 | 2016-12-06 | 2Mbps 高速 PHY、4 倍距离、8 倍广播包、BLE Mesh 基础 |
| Bluetooth 5.1 | 2019-01-29 | AoA/AoD 厘米级空间定位、方向查找 |
| Bluetooth 5.2 | 2019-12-31 | LE Audio 低功耗音频、LC3 编码、同步音频通道 EATT |
| Bluetooth 5.3 | 2021-07-13 | 连接子分级、抗干扰优化、更低延迟、功耗优化 |
| Bluetooth 5.4 | 2023-01-31 | PAwR 响应式周期性广播、无连接双向数据、穿戴低功耗优化 |
| Bluetooth Core 6.0 | 2024-08-27 | Channel Sounding 高精度测距、车钥匙 / 防丢器专用标准 |
| Bluetooth Core 6.1 | 2025 上半年 | 协议层小幅优化、广播过滤升级 |
| Bluetooth Core 6.2 | 2025 下半年 | 射频双模统一、工业场景可靠性增强 |
| Bluetooth Core 6.3 | 2026-05 | 厘米测距精度提升、信道探测扩容、低延迟广播优化 |

> 蓝牙 5.x 为目前消费物联网量产主力

# BLE 协议栈架构
BLE 协议栈分两层：**主机（Host）** 和 **控制器（Controller）**，中间通过 **HCI**（Host Controller Interface）通信。

<table>
  <tr style="background:#E8F4FD"><th>物理层次</th><th>协议层次</th><th>说明</th></tr>
  <tr><td><b>主机 Host</b></td><td>
    <table style="border-collapse: collapse; padding: 0;">
      <tr><td style="padding: 0;">应用层 (Application)</td><td style="padding: 0;">开发者写的代码</td></tr>
      <tr><td style="padding: 0;"><b>GAP</b> (通用访问规范)</td><td style="padding: 0;">广播、连接、安全</td></tr>
      <tr><td style="padding: 0;"><b>GATT</b> (通用属性规范)</td><td style="padding: 0;">数据读写模型</td></tr>
      <tr><td style="padding: 0;"><b>ATT</b> (属性协议)</td><td style="padding: 0;">GATT 的底层协议</td></tr>
      <tr><td style="padding: 0;"><b>SMP</b> (安全管理协议)</td><td style="padding: 0;">加密配对</td></tr>
      <tr><td style="padding: 0;"><b>L2CAP</b> (逻辑链路控制与适配协议)</td><td style="padding: 0;">协议复用、分段</td></tr>
    </table>
  </td><td>主控 MCU/CPU/OS</td></tr>
  <tr><td><b>主机控制器接口 HCI</b></td><td></td><td>UART、SPI、USB 等</td></tr>
  <tr><td><b>控制器 Controller</b></td><td>
    <table style="border-collapse: collapse; padding: 0;">
      <tr><td style="padding: 0;"><b>LL</b> (链路层)</td><td style="padding: 0;">射频控制、状态机</td></tr>
      <tr><td style="padding: 0;"><b>PHY</b> (物理层)</td><td style="padding: 0;">1Mbps GFSK, 2.4GHz</td></tr>
    </table>
  </td><td>蓝牙射频芯片</td></tr>
</table>

# 角色（Role）

| 角色 | 说明 |
|---|---|
| **Broadcaster** | 单纯广播，不接受连接（ beacon 类设备） |
| **Observer** | 单纯扫描，不发起连接 |
| **Central** | 扫描广播、发起连接，相当于"主设备"（手机） |
| **Peripheral** | 广播并接受连接，相当于"从设备"（传感器） |

> 手机通常是 **Central**，智能设备通常是 **Peripheral**。

# LL 层 PDU 

## 广播信道 PDU（Advertising Channel PDU）

```
┌──────────────────────────┬───────────────────────────┐
│ Header (2 bytes)         │ Payload (1~37 bytes)      │
└──────────────────────────┴───────────────────────────┘
```
**Header 字段拆分**（bit15~bit0）:

1) PDU Type (bit 15~12)
4 bits，决定**PDU 的种类**：
| 值 | 类型 | 用途 |
|---|---|---|
| 0b0000 | ADV_IND | 可连接、可扫描广播（最常用） |
| 0b0001 | ADV_DIRECT_IND | 定向可连接广播（指定设备） |
| 0b0010 | ADV_NONCONN_IND | 不可连接、不可扫描（纯 beacon） |
| 0b0011 | SCAN_REQ | 扫描请求 |
| 0b0100 | SCAN_RSP | 扫描响应 |
| 0b0101 | CONNECT_REQ | 连接请求 |
| 0b0110 | ADV_SCAN_IND | 可扫描、不可连接 |
| 0b0111-0b1111 | Reserved | 保留 |

2) TxAdd / RxAdd (bit 11、bit 10)
地址类型标志位，决定设备地址是 **Public** 还是 **Random**：
| Bit | 值 | 含义 |
|---|---|---|
| TxAdd (bit 11) | 0 | 发送方地址是 Public |
| TxAdd (bit 11) | 1 | 发送方地址是 Random |
| RxAdd (bit 10) | 0 | 接收方地址是 Public |
| RxAdd (bit 10) | 1 | 接收方地址是 Random |

> 不同类型的 PDU Type 的 Payload ，可能会有 **6 字节的 AdvA**（发送方地址）和 **InitA**（CONNECT_REQ 里接收方地址）。这两个 bit 就是告诉 LL 解析器地址用哪种类型解。

3) 保留位 (bit 9 ~ 8)

4) Length (bit 7 ~ 2)

    6 bits，**Payload 字节数**，有效范围 **1 ~ 37**（5.x 之后**最大可到 255**，取决于 PDU 类型）。

5) 保留位 (bit 1 ~ 0)


**不同 PDU Type 的 Payload 结构**

- **ADV_IND Payload**
```
┌──────────────────┐
│   AdvA (6B)      │  ← 发送方地址
│   AdvData (≤31B) │  ← 广播数据（AD Structure 串）
└──────────────────┘
```

- **SCAN_REQ Payload**
```
┌──────────────────┐
│   ScanA (6B)     │  ← ?
│   AdvA (6B)      │  ← 发送方地址
└──────────────────┘
```

- **SCAN_RSP Payload**
```
┌──────────────────────┐
│   AdvA (6B)          │  ← 发送方地址
│   ScanRspData (≤31B) │  ← 扫描响应数据
└──────────────────────┘
```

- **CONNECT_REQ Payload**
```
Offset  Size   字段                        说明
──────────────────────────────────────────────────────────
0       6B     InitA                      发起者（Central）地址
6       6B     AdvA                       接收者（Peripheral）地址
12      4B     AA (Access Address)        连接通道接入地址（固定 0x8E89BED6）
16      3B     CRCInit                    CRC 初始化值
19      1B     WinSize                    传输窗口大小
20      1B     WinOffset                  传输窗口偏移
21      2B     Interval                   连接间隔（1.25ms 单位）
23      2B     Latency                    从机延迟（连接事件数）
25      2B     Timeout                    监控超时（10ms 单位）
27      3B     ChM (Channel Map)          37 个数据频道使用位图
30      2B     Hop (Hop Increment + Sleep) 跳频增量 + CSA #2 标志
32      1B     SCA                        Central 时钟精度
──────────────────────────────────────────────────────────
                                       总 34 字节
```

**关键参数：**
| 参数 | 范围 | 说明 |
|---|---|---|
| Interval | 0x0006 ~ 0x0C80 (7.5ms ~ 4s) | 连接间隔，1.25ms 单位 |
| Latency | 0 ~ 499 | 从机可跳过的连接事件数 |
| Timeout | 0x000A ~ 0x0C80 (100ms ~ 32s) | 监控超时，10ms 单位 |
> **超时必须满足：** Timeout > (1 + Latency) × Interval × 2


## 数据信道 PDU（Data Channel PDU）

## 链路控制 PDU（LL Control PDU）

# 广播（Advertising）

**广播行为**：

1. 在LL层，广播在 37/38/39 三个广播频道上循环发送
    - Channel 37 (2402 MHz) → 发送 ADV_IND
    - Channel 38 (2426 MHz) → 发送 ADV_IND
    - Channel 39 (2480 MHz) → 发送 ADV_IND
2. 然后短暂进入扫描窗口，等待扫描请求并响应

**广播包类型**（Advertising Type）：

| Type | 说明 |
|---|---|
| **ADV_IND** | 可连接、可扫描（最常用） |
| **ADV_DIRECT_IND** | 定向可连接，指向特定设备（最快重连） |
| **ADV_NONCONN_IND** | 不可连接、不可扫描（纯 beacon） |
| **ADV_SCAN_IND** | 不可连接、可扫描（被动广播） |
| **SCAN_REQ / SCAN_RSP** | 扫描请求与响应 |


从设备（Peripheral）对外发送广播包，包含：
- **设备地址**（MAC）
- **广播数据**（厂商 ID、设备名称等，可自定义）

主设备（Peripheral）发送扫描帧，从设备回复：
- **扫描响应数据**（更长，可按需填写）

主设备收到从设备的广播包和扫描响应数据后，通知主设备的应用层。

每一帧的长度最大31个字节，每帧数据可以包含多个字段，每个字段的格式为 `Length(1B), Type(1B), Data(nB)`。

# GATT 模型（数据组织）

GATT 是 BLE 应用开发最核心的部分，定义了一套树形数据结构：
```
Server（从设备）
 └── Profile（配置文件 — 预定义的功能集合）
      └── Service（服务 — 完整的功能模块）
           ├── Characteristic（特征值）— 最小的数据单元
           │    ├── Properties（读写/通知/指示等）
           │    ├── Value（数据值）
           │    └── Descriptor（描述符，可选）
           └── Characteristic
      └── Service
```

**Example — 心率服务：**
```
Heart Rate Service (0x180D)
 └── Heart Rate Measurement (0x2A37)  ← Characteristic
      ├── Properties: Notify
      ├── Value: 心率数值
      └── CCCD Descriptor (使能通知)
```

# ATT 协议

ATT 是 GATT 的底层传输协议，将所有数据抽象为 **Attribute（属性）**：
```
Attribute = Handle（句柄） + Type（UUID） + Permissions（权限）
```
每个 Attribute 有：
- **Handle**：16-bit 句柄，像内存地址，唯一标识
- **Type**：UUID，区分是 Service、Characteristic 还是 Descriptor
- **Value**：实际数据
- **Permissions**：读/写/加密等权限

# 通用 UUID

SIG（蓝牙技术联盟）定义了大量标准 Service/Characteristic UUID：

| UUID | 含义 |
|---|---|
| 0x180A | Device Information |
| 0x180D | Heart Rate |
| 0x180F | Battery Service |
| 0xFFE0 | 自定义私有服务常用前缀 |

私有服务用自定义 16-bit 或 32-bit UUID。

# 参考资料

- [Bluetooth Core Specification](https://www.bluetooth.com/specifications/specs/core-specification-6-3/)
- [Assigned Numbers](https://www.bluetooth.com/specifications/assigned-numbers/)
- [GATT Specification Supplement](https://www.bluetooth.com/specifications/specs/gatt-specification-supplement/)
