---
title: "WebRTC"
weight: 2
bookCollapseSection: false
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">WebRTC</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-06-30 | 更新时间：2026-06-30
</div>
{{< katex />}}

# 概述

## 名词解释

- **SDP**: Session Description Protocol（会话描述协议）
- **ICE**: Interactive Connectivity Establishment（交互式连接建立）
- **STUN**: Session Traversal Utilities for NAT（NAT 穿透服务）
- **TURN**: Traversal Using Relays around NAT（中继服务）
- **SFU**: Selective Forwarding Unit（媒体分发服务）
- **MCU**: Multipoint Control Unit（多点控制单元）

## 分层结构 

客户端三层：
- 媒体采集层：MediaStream
- 连接管理层：RTCPeerConnection
- 数据通道层：RTCDataChannel

服务端三层：
- 信令层：WebSocket **信令服务**（交换 SDP+ICE）
- ICE 穿透层：**STUN**（公网探测）+ **TURN**（流量中继）
- 媒体分发层：**SFU**（多人会议，有开源实现 MediaSoup，可选）

## 整体流程
1. A 打开摄像头，创建 RTCPeerConnection，生成 **Offer SDP**
2. A 通过 WebSocket **信令服务**把 Offer 发给 B
3. B 收到 Offer，生成 **Answer SDP**，再回传给 A
4. 两端同时向 **STUN 服务**请求公网地址，收集 **ICE 候选**（**Candidate**），互相交换地址
5. RTCPeerConnection 尝试按照 ICE 优先级建立 UDP P2P 直连
6. 直连失败，自动切换到 **TURN 中继**模式
7. 连通后，音视频以 RTP 包直接传输（P2P or TURN）
8. 多人会议场景：所有流推送到 **SFU**，再由 SFU 分发定订阅方（可选）

```mermaid
sequenceDiagram
    actor A as 🖥️ A
    actor B as 🖥️ B
    participant Sig as 📨 Signaling
    participant STUN as 🔍 STUN
    participant TURN as 🚚 TURN

    Note over A,TURN: SDP (Session Description Protocol)
    autonumber 1
    A->>A: Generate Offer SDP
    A->>Sig: Offer SDP
    Sig->>B: Offer SDP
    B->>B: Generate Answer SDP
    B->>Sig: Answer SDP
    Sig->>A: Answer SDP

    Note over A,TURN: ICE (Interactive Connectivity Establishment)
    autonumber 1
    A->>STUN: ICE request
    STUN->>A: candidate1
    A->>Sig: send candidate1
    Sig->>B: send candidate1

    autonumber 1
    B-->>STUN: ICE request
    STUN-->>B: candidate2
    B-->>Sig: send candidate2
    Sig-->>A: send candidate2

    Note over A,TURN: Data Travesal
    autonumber off
    alt NAT Traversal
        A<<->>B: Media
        B<<->>A: Media
    else Traversal Using Relays
        A<<->>TURN: Media
        TURN<<->>B: Media
    end
```

# 客户端

完整流程：

```mermaid
sequenceDiagram
    box rgba(144, 238, 144, 0.2)
    participant ws1 as 📡 WebSocket1
    participant peerconn1 as 🔗 RTCPeerConnection1
    end
    box rgba(144, 196, 238, 0.2)
    participant ws2 as 📡 WebSocket2
    participant peerconn2 as 🔗 RTCPeerConnection2
    end
    box rgba(180, 180, 180, 0.2)
    participant sig as 📨 Signaling
    participant stun as 🔍 STUN
    end

    Note over ws1,stun: Join Room
    autonumber off
    ws1->>sig: Join room, start local media
    ws2-->>sig: Join room, start local media

    Note over ws1,stun: Session Description Protocol (SDP)
    autonumber 1
    ws1->>peerconn1: Generate Offer SDP and set Local Description
    peerconn1->>ws1: Offer SDP
    ws1->>sig: Offer SDP
    sig->>ws2: Offer SDP
    ws2->>peerconn2: Offer SDP
    peerconn2->>peerconn2: Set Remote Description, generate Answer SDP, set Local Description
    peerconn2->>ws2: Answer SDP
    ws2->>sig: Answer SDP
    sig->>ws1: Answer SDP
    ws1->>peerconn1: Answer SDP
    peerconn1->>peerconn1: Set Remote Description

    Note over ws1,stun: Interactive Connectivity Establishment (ICE)
    autonumber 1
    peerconn1->>stun: ICE request
    stun->>peerconn1: candidate1
    peerconn1->>ws1: candidate1
    ws1->>sig: candidate1
    sig->>ws2: candidate1
    ws2->>peerconn2: candidate1
    peerconn2->>peerconn2: add peer Candidate

    autonumber 1
    peerconn2-->>stun: ICE request
    stun-->>peerconn2: candidate2
    peerconn2-->>ws2: candidate2
    ws2-->>sig: candidate2
    sig-->>ws1: candidate2
    ws1-->>peerconn1: candidate2
    peerconn1-->>peerconn1: add peer Candidate

    Note over ws1,stun: NAT Hole Punching
    autonumber off
    peerconn1<<->>peerconn2: Set up peer connection with candidates (first P2P then fallback to TURN)

    Note over ws1,stun: Media Stream Hooking
    autonumber 1
    peerconn1->>peerconn1: Add media stream tracks
    peerconn1->>peerconn2: track
    peerconn2->>peerconn2: received and play peer track

    autonumber 1
    peerconn2-->>peerconn2: Add media stream tracks
    peerconn2-->>peerconn1: track
    peerconn1-->>peerconn1: received and play peer track

    Note over ws1,stun: Data Travesal
    autonumber off
    peerconn1<<->>peerconn2: Media over P2P/TURN
```

## 媒体采集

MediaStream

- navigator.mediaDevices.getUserMedia（摄像头+麦克风）

Local media:
```javascript
// -- get stream ---------------------------------------------------------------
const constraints = { audio: true, video: { width: 640, height: 480 } };
this.stream = await navigator.mediaDevices.getUserMedia(constraints);
document.createElement('video').srcObject = this.stream;

// -- get tracks ---------------------------------------------------------------
this.stream.getTracks();

// -- disable audio tracks -----------------------------------------------------
this.stream.getAudioTracks().forEach(t => t.enabled = false);

// -- disable video tracks -----------------------------------------------------
this.stream.getVideoTracks().forEach(t => t.enabled = false);

// -- stop tracks --------------------------------------------------------------
this.stream.getTracks().forEach(t => t.stop());
```

Remote media:
```javascript
// -- create stream ------------------------------------------------------------
this.remoteStream = new MediaStream();
this.remoteStream.addTrack(ev.track);
document.createElement('video').srcObject = this.remoteStream;
```

- getDisplayMedia（屏幕共享）

## 连接管理

RTCPeerConnection

  负责端到端建立连接、传输音视频数据流，是最核心对象。

  主要职责：
  - 生成 SDP 会话描述（Offer / Answer），但不负责发送到peer
  - 向 STUN 请求，收集 ICE 候选地址，但不负责发生到peer
  - 协商编解码器（H.264、VP8、VP9、AV1、OPUS）
  - 收发 RTP/RTCP 媒体包
  - 处理网络抖动、丢包、拥塞控制

```javascript
// -- new peer connection ------------------------------------------------------
const iceServers = [
    {urls: 'stun:stun.l.google.com:19302'}, 
    {urls: ['turn:b.example.com:1232']},
    {urls: ['turn:b.example.com:1232']}
    ];
this.pc = new RTCPeerConnection({ iceServers });
this.pc.addEventListener('icecandidate', (ev) => {
    // send `candidate` to peers through signaling server
    const candidate = {
        candidate: ev.candidate.candidate,
        sdpMid: ev.candidate.sdpMid,
        sdpMLineIndex: ev.candidate.sdpMLineIndex,
    }
});
this.pc.addEventListener('track', (ev) => {
    this.remoteStream = new MediaStream();
    this.remoteStream.addTrack(ev.track);
    document.createElement('video').srcObject = this.remoteStream;
});
this.pc.addEventListener('connectionstatechange', () => {
    const s = this.pc.connectionState;
    if (s === 'connected') {
        // connected
    } else if (s === 'failed') {
        // failed
    } else if (s === 'disconnected') {
        // disconnected
    }
});

// -- create offer -------------------------------------------------------------
const offer = await this.pc.createOffer({ offerToReceiveAudio: true, offerToReceiveVideo: true });
// then send `offer.sdp` to peer through signaling server

// -- create answer ------------------------------------------------------------
const answer = await this.pc.createAnswer();
// then send `answer.sdp` to peer through signaling server

// -- set local description ----------------------------------------------------
await this.pc.setLocalDescription(offer);
// access local description
this.pc.localDescription

// -- set remote description ---------------------------------------------------
// (type='offer' if peer proactively offer it, 
//  type='answer' if peer answered my offer, through signaling server)
await this.pc.setRemoteDescription({ type: 'offer'|'answer', sdp });
// access remote description
this.pc.remoteDescription

// -- add ice candidate --------------------------------------------------------
await this.pc.addIceCandidate(c);

// -- add local tracks ---------------------------------------------------------
tracks = this.stream.getTracks();
if (tracks.length) {
    for (const t of tracks) this.pc.addTrack(t, this.stream);
}
// get local sedding tracks
this.pc.getSenders()

// -- close peer connection ----------------------------------------------------
this.pc.close();
```

## 数据通道

RTCDataChannel

在同一个 P2P 链路上传输非媒体数据：文字、文件、二进制消息，基于 UDP，低延迟。

# 服务端

- 信令服务
- ICE 服务（STUN + TURN）
- SFU（可选）

## 信令服务

Signaling Server（必备）

WebRTC 本身不内置信令通道，必须自建服务交换协商信息。

交换内容：
- SDP（Offer/Answer）
- ICE 网络候选地址（Candidate）

信令服务只交换控制信令，不转发音视频流量。

## STUN

NAT 穿透服务 STUN（Session Traversal Utilities for NAT，必备）

客户端向 STUN 服务器发送请求，拿到自身外网地址（IP + 端口），生成 ICE 候选。

通信过程见[公网出口端口探测](../02-p2p/#%e5%85%ac%e7%bd%91%e5%87%ba%e5%8f%a3%e7%ab%af%e5%8f%a3%e6%8e%a2%e6%b5%8b)

正常网络环境下，拿到公网地址后两端可以直接 P2P，不走流量中转。

**消息格式**：

所有 STUN 消息由一个 20 字节的头部和零个或多个属性组成。

头部的格式：
```text
      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |0 0|     STUN Message Type     |         Message Length        |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                         Magic Cookie                          |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                                                               |
     |                     Transaction ID (96 bits)                  |
     |                                                               |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```
消息格式详见：[STUN Message Structure](https://www.rfc-editor.org/info/rfc8489/#section-5)

属性的格式：
```text
      0                   1                   2                   3
      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |         Type                  |            Length             |
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
     |                         Value (variable)                ....
     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

属性格式详见：[STUN Attributes](https://www.rfc-editor.org/info/rfc8489/#section-14)

## TURN

中继服务 TURN（Traversal Using Relays around NAT）

当多层 NAT、对称 NAT、防火墙严格拦截，两端无法 P2P 直连时，会自动降级为所有流量经过 TURN 服务器中转。

有 TURN over UDP / TCP / TLS 多种传输方式，TURN over UDP 最为常见。

TURN 服务器要承载媒体流量，带宽消耗大，成本较高。

> [!TIP]
> 工程上一般把 STUN + TURN 部署在同一套服务，统称 ICE Server。

> [!NOTE]
> TURN Server 服务于两种通信场景：
> - TURN Client ↔ TURN Client（两个Peer都在NAT之后）
> - TURN Client ↔ Plain UDP（Plain UDP指有公网IP的Peer）

> Plain UDP ↔ Plain UDP 的情况无需TURN Server，它们可以直接P2P通信

> [!NOTE]
> TURN通道上，有两种格式的数据：
> - STUN 消息：见[STUN消息格式](../02-webrtc/#stun)
> - ChannelData：TURN framing 头 + Data，格式为"ChannelID(2B), Length(2B), Data"，ChannelID 的范围为 0x4000 ~ 0x7FFF  
> 此外，可能会有与 Plain UDP 客户端的纯 Data 数据，没有 TURN framing 头，只有 "Data"

> STUN消息的first 2-bit 必须为0，刚好与 0x4000 ~ 0x7FFF 的 ChannelID 错开。STUN消息的 Message Type 与 ChannelData 的 ChannelID 不重合，让 TURN Control Server 可以区分两种消息格式。

> Plain UDP 客户端的纯 Data 数据不会进入 TURN Control Port，只会发送到 Relay Port，所以不会造成困扰。

TURN Client 与 TURN Server 建立通信关系的主要过程为：
1. Create Allocation by Allocate
2. AddPermission for peer
3. BindChannel for peer (channelID is unique only in current Allocation)

> 它们都是使用STUN格式的指令实现

> Plain UDP 无需 Create Allocation。

```mermaid
sequenceDiagram
    autonumber
    participant A as Peer A (TURN client)<br/>PeerAIP:PeerAPort
    participant T as TURN Server<br/>ServerIP:ControlPort
    participant B as Peer B (TURN client)<br/>PeerBIP:PeerBPort
    participant C as Peer C (plain UDP)<br/>PeerCIP:PeerCPort

    rect rgb(240, 248, 255)
    Note over A,T: Peer A allocates relay R1
    A->>T: Allocate request to TURN control (ServerIP:ControlPort)
    T-->>A: success, relay = R1 (ServerIP:RelayPort1)
    end

    rect rgb(240, 248, 255)
    Note over B,T: Peer B allocates relay R2
    B->>T: Allocate request to TURN control (ServerIP:ControlPort)
    T-->>B: success, relay = R2 (ServerIP:RelayPort2)
    end

    rect rgb(255, 248, 240)
    Note over A,T: Peer A authorizes peer B
    A->>T: CreatePermission for peer B
    A->>T: BindChannel 0x4001 to peer B
    end

    rect rgb(255, 248, 240)
    Note over B,T: Peer B authorizes peer A
    B->>T: CreatePermission for peer A
    B->>T: BindChannel 0x4002 to peer A
    end

    rect rgb(240, 255, 240)
    Note over A,B: Peer A sends to peer B via relay R2
    A->>T: ChannelData1 dst=0x4001
    T->>T: FindChannelByID 0x4001 returns peer B
    T->>T: Data1 to peer B relay R2
    T->>T: FindChannelByPeer returns channel 0x4002
    T->>B: ChannelData1 src=0x4002
    end

    rect rgb(255, 245, 245)
    Note over A,B: Peer B sends to peer A via relay R1
    B->>T: ChannelData2 dst=0x4002
    T->>T: FindChannelByID 0x4002 returns peer A
    T->>T: Data2 to peer A relay R1
    T->>T: FindChannelByPeer returns channel 0x4001
    T->>A: ChannelData2 src=0x4001
    end

    rect rgb(240, 255, 240)
    Note over A,C: Peer A sends to peer C
    A->>T: ChannelData3 dst=0x4003
    T->>T: FindChannelByID 0x4003 returns peer C
    T->>C: Data3
    end

    rect rgb(255, 245, 245)
    Note over A,C: Peer C sends to peer A via relay R1
    C->>T: Data4 to Peer A relay R1
    T->>T: FindChannelByPeer returns channel 0x4003
    T->>A: ChannelData4 src=0x4003
    end

    rect rgb(250, 250, 250)
    Note over T: Sweep removes expired allocations
    T->>T: IsExpired check, drop expired, return port
    end
```

**数据流转图**，覆盖一下情况：
- TURN client → TURN client (A → B: Data1)
- TURN client → plain UDP   (A → C: Data2)
- plain UDP → TURN client   (C → A: Data3)

```mermaid
flowchart TD
    subgraph AllocA["Allocation 1 - Peer A"]
        C1["clientAddr:<br/>PeerAIP:PeerAPort"]
        R1["relayAddr (R1):<br/>ServerIP:RelayPort1"]
        PA["permissions:<br/>allow PeerBIP<br/>allow PeerCIP"]
        CHA["channels:<br/>0x4001 → ServerIP:RelayPort2<br/>0x4003 → PeerCIP:PeerCPort"]
    end

    subgraph AllocB["Allocation 2 - Peer B"]
        C2["clientAddr:<br/>PeerBIP:PeerBPort"]
        R2["relayAddr (R2):<br/>ServerIP:RelayPort2"]
        PB["permissions:<br/>allow PeerAIP"]
        CHB["channels:<br/>0x4002 → ServerIP:RelayPort1"]
    end

    subgraph Server["TURN Server Listening"]
        CP(ServerIP:ControlPort)
        RP1(ServerIP:RelayPort1<br/>R1)
        RP2(ServerIP:RelayPort2<br/>R2)
    end

    A(Peer A<br/>TURN Client<br/>PeerAIP:PeerAPort)
    B(Peer B<br/>TURN Client<br/>PeerBIP:PeerBPort)
    C(Peer C<br/>Plain UDP<br/>PeerCIP:PeerCPort)

    A -->|Allocate| AllocA
    B -->|Allocate| AllocB

    %% A → B (TURN client to TURN client)
    A e1@-->|ChannelData1 channel=0x4001| CP
    CP -.->|GetByClient| AllocA
    CP e2@-->|Data1 src=ServerIP:RelayPort1| RP2
    RP2 -.->|GetByRelay| AllocB
    RP2 e3@-->|ChannelData1 channel=0x4002 src=ServerIP:ControlPort| B

    %% A → C (TURN client to plain UDP)
    A e4@-->|ChannelData2 channel=0x4003| CP
    CP e5@-->|Data2 src=ServerIP:ControlPort| C

    %% C → A (plain UDP to TURN client)
    C e6@-->|Data3| RP1
    RP1 -.->|GetByRelay| AllocA
    RP1 e7@-->|Data3 src=ServerIP:ControlPort| A

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#f9f,stroke:#333,stroke-width:2px
    style C fill:#f9f,stroke:#333,stroke-width:2px
    style CP fill:#fff,stroke:#333,stroke-width:2px
    style RP1 fill:#fff,stroke:#333,stroke-width:2px
    style RP2 fill:#fff,stroke:#333,stroke-width:2px

    %% Data1
    linkStyle 2,4,6 stroke:#e74c3c,stroke-width:2px
    %% Data2
    linkStyle 7,8 stroke:#3498db,stroke-width:2px
    %% Data3
    linkStyle 9,11 stroke:#2ecc71,stroke-width:2px

    e1@{ animate: true }
    e2@{ animate: true }
    e3@{ animate: true }
    e4@{ animate: true }
    e5@{ animate: true }
    e6@{ animate: true }
    e7@{ animate: true }
```

> [!TIP]
> Relay Port 就是 Client 的“**代言人**”。Client 发出的数据以 Relay Port 的身份发出，发往 Client 的数据先发往 Replay Port。

## SFU

多人视频会议（3 人及以上）的场景下，P2P 会形成网状连接，带宽爆炸，需要使用引入 **SFU**（Selective Forwarding Unit）。

SFU 工作机制：
- 每个客户端只向上行发送一路视频流给 SFU
- SFU 只做流量分发，把流分发给其他所有参会者

MCU（Multipoint Control Unit）是把多路上行画面混合成一路画面再下发的机制，其 CPU 开销高，常见于老旧视频会议系统。

> SFU 并不是 WebRTC 标准的一部分。

# References

- [W3C WebRTC API](https://www.w3.org/TR/webrtc/)
- IETF RTCWEB (RFC)
    - ICE
        - [RFC 8445: Interactive Connectivity Establishment (ICE): A Protocol for Network Address Translator (NAT) Traversal](https://www.rfc-editor.org/info/rfc8445/)
        - [RFC 8863: Interactive Connectivity Establishment Patiently Awaiting Connectivity (ICE PAC)](https://www.rfc-editor.org/info/rfc8863/)
        - [RFC 8866: SDP: Session Description Protocol](https://www.rfc-editor.org/info/rfc8866/)
    - STUN
        - [RFC 8489: Session Traversal Utilities for NAT (STUN)](https://www.rfc-editor.org/info/rfc8489/)
        - [RFC 7350: Datagram Transport Layer Security (DTLS) as Transport for Session Traversal Utilities for NAT (STUN)](https://www.rfc-editor.org/info/rfc7350/)
        - [RFC 7064: URI Scheme for the Session Traversal Utilities for NAT (STUN) Protocol](https://www.rfc-editor.org/info/rfc7064/)
    - STUN
        - [RFC 8656: Traversal Using Relays around NAT (TURN): Relay Extensions to Session Traversal Utilities for NAT (STUN)](https://www.rfc-editor.org/info/rfc8656/)
        - [RFC 8155: Traversal Using Relays around NAT (TURN) Server Auto Discovery](https://www.rfc-editor.org/info/rfc8155/)
        - [RFC 6062: Traversal Using Relays around NAT (TURN) Extensions for TCP Allocations](https://www.rfc-editor.org/info/rfc6062/)
        - [RFC 7065: Traversal Using Relays around NAT (TURN) Uniform Resource Identifiers](https://www.rfc-editor.org/info/rfc7065/)
    - RTP
        - [RFC 3550: STD 64: RTP: A Transport Protocol for Real-Time Applications](https://www.rfc-editor.org/info/rfc3550/)
        - [RFC 7728: RTP Stream Pause and Resume](https://www.rfc-editor.org/info/rfc7728/)
        - [RFC 3711: The Secure Real-time Transport Protocol (SRTP)](https://www.rfc-editor.org/info/rfc3711/)
        - [RFC 9147: The Datagram Transport Layer Security (DTLS) Protocol Version 1.3](https://www.rfc-editor.org/info/rfc9147/)
    - other
        - [RFC 8827: WebRTC Security Architecture](https://www.rfc-editor.org/info/rfc8827/)
        - [RFC 8828: WebRTC IP Address Handling Requirements](https://www.rfc-editor.org/info/rfc8828/)

