---
title: "Agent，工程的起航"
weight: 20
draft: false
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->

<div class="page-title">Agent，工程的起航</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-04-19 | 更新时间：2026-04-19
</div>
{{< katex />}}

有了前面基础知识的铺垫，终于来到了 LLM 的实践应用环节 —— 智能体，LLM 的落地应用。

**AI Agent**（智能体）是 2025 年初开始推广开来的围绕 LLM 的工程实践。

随着工程化的成熟，业界已经发展出一套驾驭 LLM 的方法论和最佳实践，

本文按这套工程实践展开，分享 AI Agent 的核心逻辑。

过程中会以当下流行的**个人智能体 [OpenClaw](https://github.com/openclaw/openclaw)** 为例。

# 架构实例：OpenClaw 架构

OpenClaw 的简要架构如下：

```mermaid
stateDiagram-v2
    direction LR

    %% 外部平台（消息源）
    feishu   : 飞书
    qq       : QQ
    wechat   : 微信
    telegram : Telegram
    nostr    : Nostr
    otherch  : ...

    %% 客户端
    webui   : Web UI
    tui     : 命令行 TUI<br/>（Terminal UI）
    node_app: Node App<br/>（iOS, Android）

    %% 关键实体
    openclaw : <strong>OpenClaw</strong>
    llm      : 大语言模型<br/>Large Language Model

    %% OpenClaw 核心
    state openclaw {
        direction LR
        ch      : 通道层<br/>（Channel Layer）
        gw      : 核心网关<br/>（Core Gateway）
        skill   : 技能引擎<br/>（Skill Engine）
        session : 会话管理<br/>（Session Manager）
        mem     : 记忆<br/>（Memory）
        plugin  : 插件系统<br/>（Plugin）

        ch      --> gw
        session --> gw
        skill   --> gw
        mem     --> gw
    }

    %% 外部平台 → Channel Layer
    feishu   --> ch
    qq       --> ch
    wechat   --> ch
    telegram --> ch
    nostr    --> ch
    otherch    --> ch

    %% 客户端 → Gateway
    webui   --> gw
    tui     --> gw
    node_app--> gw

    %% Gateway → LLM
    gw --> llm : LLM Providers

    %% 样式
    style feishu    fill:#e8f4fd,stroke:#4a90d9
    style qq        fill:#e8f4fd,stroke:#4a90d9
    style wechat    fill:#e8f4fd,stroke:#4a90d9
    style telegram  fill:#e8f4fd,stroke:#4a90d9
    style nostr     fill:#e8f4fd,stroke:#4a90d9
    style otherch   fill:#e8f4fd,stroke:#4a90d9

    style webui     fill:#d9f0e0,stroke:#5a9a6e
    style tui       fill:#d9f0e0,stroke:#5a9a6e
    style node_app  fill:#d9f0e0,stroke:#5a9a6e

    style openclaw  fill:#f5f5f5,stroke:#999,stroke-width:2px
    style gw        fill:#f0e8ff,stroke:#9a6ed4,stroke-width:2px
    style ch        fill:#f0e8ff,stroke:#9a6ed4
    style session   fill:#f0e8ff,stroke:#9a6ed4
    style mem       fill:#f0e8ff,stroke:#9a6ed4
    style skill     fill:#f0e8ff,stroke:#9a6ed4

    style llm       fill:#fff3cd,stroke:#d48806,stroke-width:2px
```

OpenClaw 是运行在用户自有服务器（或个人电脑）上的私有 AI Agent 框架。

消息经由 Channel Layer 接入，由 Core Gateway 统一路由，配合 Session Manager 管理对话上下文，技能引擎与记忆模块提供长期能力，最终调度 LLM 生成回复。

{{% details title="关键组件说明" open=false %}}
- **通道层（Channel Layer）**

    消息适配层，将各平台（QQ、飞书、Telegram、Nostr 等）格式统一为内部 schema，再送入 Gateway。

- **核心网关（Core Gateway）**

    消息路由核心，负责鉴权、会话分发、上下游协调。是整个系统的中枢。

- **会话管理（Session Manager）**

    管理对话生命周期、上下文窗口、跨 session 记忆与状态持久化。

- **技能引擎（Skill Engine）**

    技能执行引擎，按需挂载业务技能（天气预报、飞书文档、代码执行等），按指令调度工具。

- **记忆（Memory）**

    记忆存储层，支持短期记忆（会话级）与长期记忆（跨会话持久化）

- **子代理（Sub-Agent）**

    由 Gateway 派生出的并行任务执行单元，适用于复杂任务分解与独立处理（未在图中画出）。

- **插件系统（Plugin）**

    通过能力注册制和事件钩子，自定义扩展 OpenClaw 的各种能力。
{{% /details %}}

# 架构抽象：分层架构

一般化的 AI Agent，按个人理解，抽象成如下几层：

<table>
  <tr><th>层级</th><th>名称</th><th>说明</th></tr>
  <tr style="background:#E8F4FD"><td>8</td><td>👤 用户层</td><td>需求·权限·审计</td></tr>
  <tr style="background:#F8F8F8"><td>7</td><td>📖 技能层</td><td>工具使用说明和技巧手册（skill.md），AI 时代的 App</td></tr>
  <tr style="background:#F8F8F8"><td>6</td><td>🔧 工具层</td><td>命令·接口·MCP，智能体的武器库</td></tr>
  <tr style="background:#F0E8FF"><td>5</td><td>⚙️  智能体层</td><td>LLM 驾驭系统，AI 时代的 OS（Claude Code, Codex, OpenClaw）</td></tr>
  <tr style="background:#FFF3CD"><td>4</td><td>🧠 模型层</td><td>智能引擎，AI 时代的发动机（OpenAI, Anthropic, Google）</td></tr>
  <tr style="background:#F8F8F8"><td>3</td><td>🖥️ 基础设施层</td><td>服务器·存储·网络（AWS, Azure, 阿里云）</td></tr>
  <tr style="background:#F8F8F8"><td>2</td><td>💻 芯片层</td><td>GPU·TPU（英伟达 Nvidia，Google）</td></tr>
  <tr style="background:#F8F8F8"><td>1</td><td>⚡ 能源层</td><td>超大型 AI 数据中心年耗电量相当于中等城市的居民年用电量</td></tr>
</table>

# 上下文 Context

在模型训练阶段，如果输入的是干净且全面的数据，最后模型学会的就是这些数据组成的统计结构。

模型训练出来后，知识的量就已经固定了。

> [!TIP]
> 就好像在水快要放干的池塘里面捞鱼，虽然随意都能抓到，但若使用有效的工具，效果将大大提高。

在模型推理阶段，**提示词**（prompt）品质，将直接决定了大模型输出的质量。

> [!WARNING]
> 大模型的核心是自注意力机制，所谓的提示词工程（Prompt Engineering），就是为了**管理 LLM 的注意力**

OpenClaw 的上下文（同时也是提示词）由以下部分组成：

- 系统提示词（System Prompt）
- 技能列表（Skills）
- 工具列表（Tools）
- 记忆（Memory）
- 历史对话内容（Chat History）

**系统提示词**是对 LLM 的框定和约束，OpenClaw 中由位于 agent 工作区（workspace）的多个 markdown 文件组成。

{{% details title="OpenClaw Agent 定义文件" open=false %}}
| 文件 | 用途 | Context 注入 |
|------|------|:----:|
| 📋 **AGENTS.md** | 宪法，Agent 的工作手册与行为指南 | ✅ |
| 🍼 **BOOTSTRAP.md** | 首次启动引导，引导完成后删除 | ✅ |
| 🪪 **IDENTITY.md** | Agent 的身份，名字、角色、风格、头像 | ✅ |
| ❤️ **SOUL.md** | Agent 的灵魂，核心原则与处事态度 | ✅ |
| 🔧 **TOOLS.md** | 工具备注，环境配置 | ✅ |
| 👥 **USER.md** | 用户档案，基本信息与偏好 | ✅ |
| 🧠 **MEMORY.md** | 长期记忆 | ✅ |
| 🌙 **DREAMS.md** | 梦境日志，浅睡眠的反思碎片 | ❌ |
| 💓 **HEARTBEAT.md** | 心跳检查清单，周期性后台任务 | ❌ |
{{% /details %}}

> [**AGENTS.md**](https://agents.md/) 是一种被越来越多的智能体采用的**命名约定**与**格式规范**，它定义了智能体的工作手册与行为指南，与写给人类阅读的 `README.md` 对应


> [!TIP]
> 一个会话中，与 LLM 的交互，上下文就像是滚雪球，越滚越大，只是这个**初始雪球并不小**，一个简单的 OpenClaw 新会话上下文就有 13K tokens 之多

> [!WARNING]
> 标准自注意力机制（Self-Attention）决定了 **Transformer 并不会削弱远距离 token 的权重**，只要模型正确学到了训练数据的内在模式，提示词开头的 token 照样会对末尾的 token 生成产生影响。
> **但过大的上下文，会稀释单个提示词 token 的权重**，所以当上下文过大时，我们就需要考虑重置（reset）或压缩（compact）上下文了

{{% details title="一个上下文例子（精简后）" open=false %}}
```json
{
  "model": "qwen3.5:0.8b",
  "messages": [
    {
      "role": "system",
      "content": "You are a personal assistant running inside OpenClaw ... + 技能清单（Skills）、工具清单（Tools）"
    },
    {
      "role": "user",
      "content": "A new session was started via /new or /reset ..."
    },
    {
      "role": "assistant",
      "content": "",
      "tool_calls": [
        {
          "function": {
            "name": "read",
            "arguments": {
              "path": "/root/.openclaw/workspace-thea/memory/2026-04-18.md"
            }
          }
        },
        {
          "function": {
            "name": "read",
            "arguments": {
              "path": "/root/.openclaw/workspace-thea/memory/2026-04-17.md"
            }
          }
        }
      ]
    },
    {
      "role": "tool",
      "content": "<the CONTENT in /root/.openclaw/workspace-thea/memory/2026-04-18.md>",
      "tool_name": "read"
    },
    {
      "role": "tool",
      "content": "<the CONTENT in /root/.openclaw/workspace-thea/memory/2026-04-17.md>",
      "tool_name": "read"
    },
    {
      "role": "assistant",
      "content": "下午好，Johnson 👋 新的一天，有什么想聊的或者需要帮忙的吗？"
    },
    {
      "role": "user",
      "content": "未来三天天气怎么样？"
    },
    {
      "role": "assistant",
      "content": "",
      "tool_calls": [
        {
          "function": {
            "name": "read",
            "arguments": {
              "path": "/usr/local/node-v22.22.0/lib/node_modules/openclaw/skills/weather/SKILL.md"
            }
          }
        }
      ]
    },
    {
      "role": "tool",
      "content": "<the CONTENT /usr/local/node-v22.22.0/lib/node_modules/openclaw/skills/weather/SKILL.md>",
      "tool_name": "read"
    },
    {
      "role": "assistant",
      "content": "",
      "tool_calls": [
        {
          "function": {
            "name": "exec",
            "arguments": {
              "command": "curl -s \"wttr.in/Foshan?format=3\" && echo \"\" && curl -s \"wttr.in/Foshan?1\""
            }
          }
        }
      ]
    },
    {
      "role": "tool",
      "content": "<佛山的天气预报内容>",
      "tool_name": "exec"
    },
    {
      "role": "assistant",
      "content": "",
      "tool_calls": [
        {
          "function": {
            "name": "exec",
            "arguments": {
              "command": "curl -s \"wttr.in/Foshan?format=j1\" | python3 -c \"\nimport sys, json\nd = json.load(sys.stdin)\ndays = d['weather']\nlocation = d['nearest_area'][0]['areaName'][0]['value']\nprint(f'📍 佛山 (Foshan) 未来三天天气：\\n')\nfor i, day in enumerate(days):\n    date = day['date']\n    max_t = day['maxtempC']\n    min_t = day['mintempC']\n    desc = day['hourly'][4]['weatherDesc'][0]['value']  # midday description\n    rain = day['hourly'][4]['precipMM']\n    humidity = day['hourly'][4]['humidity']\n    print(f'📅 {date} (周{[\\\"日\\\",\\\"一\\\",\\\"二\\\",\\\"三\\\",\\\"四\\\",\\\"五\\\",\\\"六\\\"][(i+4)%7]})')\n    print(f'   {desc}，气温 {min_t}–{max_t}°C')\n    print(f'   降水概率 {rain}mm，湿度 {humidity}%\\n')\n\"\n"
            }
          }
        }
      ]
    },
    {
      "role": "tool",
      "content": "📍 佛山 (Foshan) 未来三天天气：\n\n📅 2026-04-19 (周四)\n   Cloudy ，气温 28–34°C\n   降水概率 0.0mm，湿度 40%\n\n📅 2026-04-20 (周五)\n   Cloudy ，气温 26–32°C\n   降水概率 0.0mm，湿度 45%\n\n📅 2026-04-21 (周六)\n   Patchy rain nearby，气温 26–33°C\n   降水概率 0.1mm，湿度 40%",
      "tool_name": "exec"
    },
    {
      "role": "assistant",
      "content": "📍 **佛山未来三天天气：**\n\n- **今天（周四）：** 多云 🌥️，28–34°C，湿度 40%\n- **明天（周五）：** 多云 🌥️，26–32°C，湿度 45%\n- **后天（周六）：** 局部小雨 🌦️，26–33°C，湿度 40%\n\n这周气温比较稳定，周末可能有小雨，出门记得带伞～"
    }
  ],
  "stream": true,
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "read",
        "description": "Read the contents of a file. Supports text files and images (jpg, png, gif, webp). Images are sent as attachments. For text files, output is truncated to 2000 lines or 50KB (whichever is hit first). Use offset/limit for large files. When you need the full file, continue with offset until complete.",
        "parameters": {
          "type": "object",
          "required": [
            "path"
          ],
          "properties": {
            "path": {
              "description": "Path to the file to read (relative or absolute)",
              "type": "string"
            },
            "offset": {
              "description": "Line number to start reading from (1-indexed)",
              "type": "number"
            },
            "limit": {
              "description": "Maximum number of lines to read",
              "type": "number"
            }
          }
        }
      }
    },
    {
      "type": "function",
      "function": {
        "name": "exec",
        "description": "Execute shell commands with background continuation for work that starts now. Use yieldMs/background to continue later via process tool. For long-running work started now, rely on automatic completion wake when it is enabled and the command emits output or fails; otherwise use process to confirm completion. Use process whenever you need logs, status, input, or intervention. Use pty=true for TTY-required commands (terminal UIs, coding agents).",
        "parameters": {
          "type": "object",
          "required": [
            "command"
          ],
          "properties": {
            "command": {
              "description": "Shell command to execute",
              "type": "string"
            },
            "workdir": {
              "description": "Working directory (defaults to cwd)",
              "type": "string"
            },
            "env": {
              "type": "object",
              "patternProperties": {
                "^(.*)$": {
                  "type": "string"
                }
              }
            },
            "yieldMs": {
              "description": "Milliseconds to wait before backgrounding (default 10000)",
              "type": "number"
            },
            "background": {
              "description": "Run in background immediately",
              "type": "boolean"
            },
            "timeout": {
              "description": "Timeout in seconds (optional, kills process on expiry)",
              "type": "number"
            },
            "pty": {
              "description": "Run in a pseudo-terminal (PTY) when available (TTY-required CLIs, coding agents)",
              "type": "boolean"
            },
            "elevated": {
              "description": "Run on the host with elevated permissions (if allowed)",
              "type": "boolean"
            },
            "host": {
              "description": "Exec host/target (auto|sandbox|gateway|node).",
              "type": "string"
            },
            "security": {
              "description": "Exec security mode (deny|allowlist|full).",
              "type": "string"
            },
            "ask": {
              "description": "Exec ask mode (off|on-miss|always).",
              "type": "string"
            },
            "node": {
              "description": "Node id/name for host=node.",
              "type": "string"
            }
          }
        }
      }
    }
  ],
  "options": {
    "num_ctx": 131072
  },
  "think": true
}
```
{{% /details %}}

以上例子的完整版会话上下文请戳「<a href="/images/docs/ai-agent-intro/openclaw-session.json" target="_blank">这里</a>」（文件大小 69 KB）

# 技能 Skills

# 记忆 Memory

# 会话 Sessions

在上一篇文章的[上下文长度](/docs/ai-agent/1-llm/#%E4%B8%8A%E4%B8%8B%E6%96%87%E9%95%BF%E5%BA%A6)章节中，我们提到了每一个 LLM 都是有上下文限制。

每一轮的对话，都会附加到历史对话列表中，整个对话列表组成一个**会话**（session）。

不断滚大的会话终有到达模型上下文长度上限的时候，所以会话是有生命周期的。

会话的状态可以分为：

- Running：活跃状态，随时可以接着继续聊
- Stopped：已归档，留存一段时间
- Deleted：已删除，释放存储空间

因为会话只是多轮对话的集合，所以是可以同时开启多个活跃状态的 session 的。

> 以 OpenClaw 来举例，每一个渠道（Channel，例如飞书、QQ、微信）每一个 agent 都可以对应一个活跃状态的会话。

# 结语

以上虽然以 OpenClaw 为例子，但**实际讲得是 AI 智能体工程的技术方法**。

即使 OpenClaw 的定位是个人 AI 助手，但它同时也是当前 AI 智能体工程领域世界一流水准的实战应用，与 Claude Code 等顶级工具并肩。

**开源与开放的架构，让它（OpenClaw）更具学习与研究价值**。更重要的是，其设计思想与方法论可迁移至我们的业务流程，可以让世界变得更便捷、更智能。

# 后话

1. 我是如何部署 OpenClaw 的

- 一台专门的云服务器（2核8GB内存40GB硬盘，安装了各种编程语言的开发环境，同时作为我的个人开发机，预付费套餐，月均百元不到）
- 购买了国内大模型厂商的 coding/token plan（小几十元每月）
- 对接了QQ、微信和飞书，随时随地触手可达，24 小时待命，多 agent 多渠道并行多会话

2. 目前我都用 OpenClaw 来干什么

- 实时新闻推送：定时（每小时）在网络上搜寻重大新闻，如有发现，主动推送给我，让我随时了解世界宏观动态
- 金融数据推送：每日定时（晚上）推送主要宽基指数估值信息，了解国内外经济行情变化
- 调研好伙伴：深挖某一个课题或开源项目的技术原理，通过聊天层层推进，步步展开，并最终产出可运行的代码

目前主要是研究它是如何工作的，几乎没有安装什么技能，没有对接 MCP，只是授权它使用 Linux 命令行和联网搜索。

> [!TIP]
> AI 只是个放大器，不能无中生有。没有业务基础，没有足够的认知，AI 放大的是零，终局还是零。只有懂业务、认知深，才能真正用 AI 在后面加上多个 0。
