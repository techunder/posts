---
title: "AI Agent ReAct"
weight: 302
bookCollapseSection: true
draft: true
---
<!-- Copyright © 2026 Techunder (Guanhua Liu) | All Rights Reserved | https://techunder.tech | Email: techunder@163.com -->
<div class="page-title">AI Agent ReAct</div>
<div class="page-info">
   <span class="original-tag">原创</span>
  发布时间：2026-07-06 | 更新时间：2026-07-06
</div>
{{< katex />}}

所谓 ReAct 就是以 **Reason-Act Loop**（推理-行动循环）的方式让 LLM 自我驱动工作，直到 LLM 认为可以输出最终结果。

Act（行动）通常是通过调用工具（tool/function）与外部系统互动，通过获取信息理解环境，通过作用于外部从而改变环境。

# 功能示意图

```mermaid
flowchart TD
    Start([用户输入]) --> A["❶  组装 Prompt"]
    A --> B["❷  LLM 推理"]
    B --> Choice{❸  调工具?}
    Choice -->|是| C["❹  执行工具"]
    Choice -->|否| Done([回复用户])
    C -->|loop| B

    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#dbeafe,stroke:#3b82f6
    style C fill:#fef3c7,stroke:#f59e0b
    style Start fill:#d1fae5,stroke:#10b981
    style Done fill:#d1fae5,stroke:#10b981
```
其中 ❷  → ❸  → ❹  → ❷  的循环可以发生多次，直至 LLM 不再产生 Tool Calling 意图或设定的最大循环次数到达。

# 最小 ReAct Loop

本 Demo code 演示最小化版本的 ReAct Loop。

ReAct Loop 需要先注册 Tools，然后交给 LLM 做推理（Reason）。Loop 的核心代码在 `Agent.run` 函数。

{{% details title="Code: ReAct Loop" open=false %}}
```python
# pip install openai

# need to configure an openai API compatible model with the following ENV variables:
#    export OPENAI_BASE_URL=<BASE_URL>
#    export OPENAI_API_KEY=<API_KEY>

import json
import os
import sys
import time
import logging
from typing import Callable
from openai import OpenAI

# == LOGS ======================================================================

# configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(name)s: %(message)s")
logging.getLogger("httpcore").setLevel(logging.WARNING)
logger = logging.getLogger("ReAct")

def print_msg(msg):
    logger.debug("============ object start")
    if hasattr(msg, "to_dict"):
        logger.debug(json.dumps(msg.to_dict(), indent=2, ensure_ascii=False))
    else:
        logger.debug(json.dumps(msg, indent=2, ensure_ascii=False))
    logger.debug("------------- object end")


# == TOOLS =====================================================================

def get_weather(location: str) -> str:
    """Get weather of a location (demo with fixed data)."""
    weather_data = {
        "北京": "小雨，气温 15-22°C，湿度 80%。",
        "上海": "晴，气温 22-28°C，湿度 50%。",
        "广州": "多云，气温 25-30°C，湿度 70%。",
        "佛山": "多云，气温 24-30°C，湿度 69%，微风。",
    }
    return weather_data.get(location, f"{location}天气：数据暂缺，请稍后再试。")


get_weather_schema = {
        "type": "function",
        "function": {
            "name": get_weather.__name__,
            "description": "获取指定城市的天气，用户需要先提供具体位置。",
        "parameters": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "城市名称，例如广州",
                }
            },
            "required": ["location"]
        },
    }
}


def get_location() -> str:
    """Get user's current location (demo with fixed data)."""
    location_data = {
        "ip": "127.0.0.1",
        "city": "广州",
        "region": "广东省",
        "country": "中国",
    }
    return json.dumps(location_data, ensure_ascii=False)


get_location_schema = {
        "type": "function",
        "function": {
            "name": get_location.__name__,
            "description": "获取用户的当前位置，例如所在城市与地区。",
        "parameters": {
            "type": "object",
            "properties": {},
            "required": []
        },
    }
}

LOCAL_TOOLS = [
    (get_weather.__name__, get_weather, get_weather_schema),
    (get_location.__name__, get_location, get_location_schema),
]

class Tool:
    def __init__(self, name: str, fn: Callable, schema: dict):
        self.name = name
        self.fn = fn
        self.schema = schema

    def execute(self, args):
        return self.fn(**args)

# == AGGENT ====================================================================

class Agent:
    def __init__(self, max_iterations, model_name):
        self.tools: dict[str, Tool] = {}
        self.max_iterations = max_iterations
        self.model_name = model_name
        self.client = OpenAI()
        self.messages: list = [
            {"role": "system", "content": "You are a helpful assistant."}
        ]

    def register(self, name, fn, schema):
        self.tools[name] = Tool(name, fn, schema)
        logger.info("registered tool: %s", name)

    def execute_tool_call(self, tc_name, args):
        return self.tools[tc_name].execute(args)

    def tool_schemas(self):
        return [t.schema for t in self.tools.values()]

    def run(self, user_input):
        self.messages.append({"role": "user", "content": user_input})
        print_msg(self.messages[-1])
        logger.info("USER> %s", user_input)

        t0 = time.perf_counter()
        try:
            for _ in range(self.max_iterations):
                response = self.client.chat.completions.create(
                    model=self.model_name,
                    messages=self.messages,
                    tools=self.tool_schemas(),
                    extra_body={"reasoning_split": True}, # split the reasoning and content when return
                )
                msg = response.choices[0].message
                self.messages.append(msg)
                print_msg(self.messages[-1])

                if not msg.tool_calls:
                    # 无工具调用意图，正常回复用户，结束
                    logger.info("ASSISTANT> %s", msg.content)
                    break
                for tc in msg.tool_calls:
                    # 检测到 LLM 的工具调用意图，发起工具调用
                    logger.info("ASSISTANT> 【调用工具】: %s, 【参数】: %s", tc.function.name, tc.function.arguments)

                    tc_result = self.execute_tool_call(tc.function.name, json.loads(tc.function.arguments))
                    logger.info("TOOL> %s", tc_result)

                    # 向 LLM 返回工具调用原始结果
                    msg = {"role": "tool", "tool_call_id": tc.id, "content": str(tc_result)}
                    self.messages.append(msg)
                    print_msg(self.messages[-1])
        finally:
            logger.info("react loop finished in %.3f s", (time.perf_counter() - t0))

# == MAIN ======================================================================

if __name__ == "__main__":
    # initialize agent
    agent = Agent(max_iterations=30, model_name="MiniMax-M3")

    # register tools
    for name, fn, schema in LOCAL_TOOLS:
        agent.register(name, fn, schema)

    # react loop
    user_input = "今天的天气如何？"
    agent.run(user_input)
```
{{% /details %}}

# ReAct Loop + MCP

[**MCP**](/docs/ai-agent-intro/2-agent/#tools--mcp) 提供标准化的外部 Tool 接口，当 ReAct Loop 配置上 MCP Server，犹如为大脑接入了手脚，可以直接操控物理世界。

{{% details title="Code: ReAct Loop + MCP" open=false %}}
```python
```
{{% /details %}}
