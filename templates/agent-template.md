# Copy this descriptor into agent-src/agents/ and keep its filename aligned with
# name. Codex does not load this source directly; scripts/generate-agents.py
# emits the standalone runtime file in .codex/agents/.

name = "lowercase_underscore_agent_name"
description = "Use when you need a clear specialty and trigger for Codex subagent spawning."
model = "gpt-5.6-terra"
model_reasoning_effort = "medium"
sandbox_mode = "workspace-write"
nickname_candidates = ["Display Name"]
instruction_layers = [
  "common/agent-contract.md",
  "agents/lowercase_underscore_agent_name.md",
]
