---
title: "BLE 协议"
weight: 202
bookCollapseSection: false
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">BLE 协议</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-06-18 | 更新时间：2026-06-18
</div>
{{< katex />}}

**BLE**（Bluetooth Low Energy）低功耗蓝牙，协议由**蓝牙技术联盟**（Bluetooth Special Interest Group，简称 Bluetooth SIG / SIG）维护。

蓝牙 4.0 首次加入 BLE，后续在 5.0/5.1/5.2/5.3/5.4/6.0 添加新特性。

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

# 广播（Advertising）

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
