# Troubleshooting

## Agent Not Found

Confirm the file exists and the name matches:

```bash
ls .codex/agents/python_expert.toml
./scripts/validate-agents.sh
```

Use underscore names in prompts: `python_expert`, not `python-expert`.

## Subagent Did Not Spawn

Codex spawns subagents only when explicitly asked. Start the prompt with `Spawn agent_name to ...` or ask for multiple named agents.

## Unexpected Edits

Check the agent's `sandbox_mode`. Review, research, planning, security, and debugging-analysis agents should be `read-only`; implementation agents use `workspace-write`.

## Too Much Fan-Out

Keep `.codex/config.toml` at `max_depth = 1`. If too many threads open, lower `max_threads` or ask for fewer agents.

## TOML Parse Failure

Run the validator and inspect the reported file. Common issues are unescaped quotes in basic strings or a filename that does not match `name`.
