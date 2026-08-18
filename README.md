# dshusage

一个轻量的 DSH Token 用量与费用统计工具。

直接读取本机 DSH 会话数据，无需额外服务。默认统计今天，中文输出，费用以人民币显示。

## 直接运行

无需安装：

```bash
curl -fsSL https://raw.githubusercontent.com/BeforeWave/dshusage/main/dshusage | sh
```

展开峰谷用量：

```bash
curl -fsSL https://raw.githubusercontent.com/BeforeWave/dshusage/main/dshusage \
  | sh -s -- --peak-breakdown
```

## 安装

如果你希望长期使用：

```bash
curl -fsSL https://raw.githubusercontent.com/BeforeWave/dshusage/main/install.sh | sh
```

安装后直接运行：

```bash
dshusage
```

默认安装到 `~/.local/bin/dshusage`。

## 常用用法

```bash
# 今天
dshusage

# 指定日期
dshusage --date 2026-08-18

# 全部历史
dshusage --all

# 展开峰谷用量
dshusage --peak-breakdown

# 梁文峰 / 梁文谷
dshusage --funny --peak-breakdown

# 简化模型名并合并同类模型
dshusage --normalize

# JSON 输出
dshusage --json

# 英文输出
dshusage --lang en

# 美元显示
dshusage --currency USD
```

## 输出

```text
DSH Token 用量 — 2026-08-18

模型                       输入      缓存命中      缓存写入      输出      总计      调用      费用
------------------------------------------------------------------------------------------------
deepseek-v4-flash          ...       ...           ...           ...       ...       ...       ¥...
deepseek-v4-pro            ...       ...           ...           ...       ...       ...       ¥...
------------------------------------------------------------------------------------------------
总计                       ...       ...           ...           ...       ...       ...       ¥...
```

使用 `--peak-breakdown` 可展开峰值与谷值用量；配合 `--funny` 时显示为 `梁文峰` / `梁文谷`。

## JSON

```bash
dshusage --json
```

输出包含按日期统计、模型明细和总计，适合脚本处理或接入其他工具。

```json
{
  "daily": [
    {
      "date": "2026-08-18",
      "inputTokens": 1500000,
      "outputTokens": 150000,
      "cacheCreationTokens": 0,
      "cacheReadTokens": 15000000,
      "totalTokens": 16650000,
      "totalCost": 6.18,
      "modelsUsed": ["deepseek-v4-flash"],
      "modelBreakdowns": []
    }
  ],
  "totals": {
    "inputTokens": 1500000,
    "outputTokens": 150000,
    "cacheCreationTokens": 0,
    "cacheReadTokens": 15000000,
    "totalTokens": 16650000,
    "totalCost": 6.18
  }
}
```

## 参数

```text
--today                  今天
--date YYYY-MM-DD        指定日期
--all                    全部历史
--timezone ZONE          指定时区
--json                   JSON 输出
--normalize              简化并归一化模型名
--peak-breakdown         展开峰谷用量
--currency CNY|USD       指定显示币种
--fx-rate RATE           指定 USD/CNY 汇率
--lang zh|en             输出语言
--funny                  梁文峰 / 梁文谷
--color                  强制彩色输出
--no-color               禁用彩色输出
--no-cost                不计算费用
--version                查看版本
```

## 要求

- macOS / Linux
- Node.js 22+ 推荐
- 已有 DSH 本地会话数据

## License

MIT
