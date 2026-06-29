# Contributing to the Codex Subagent Library

## What to Contribute

- New Codex custom agents.
- Better instructions for existing agents.
- Documentation, examples, and validation improvements.
- Tests or smoke scenarios for agent behavior.

## Agent Requirements

Create one `.toml` file in `.codex/agents/`. The filename must match the `name` field.

Required fields:

```toml
name = "my_agent"
description = "Use when you need a focused specialist for a clear task."
developer_instructions = """
You are the Codex custom subagent `my_agent`.
...
"""
```

Recommended fields:

```toml
model = "gpt-5.4-mini"
model_reasoning_effort = "medium"
sandbox_mode = "workspace-write"
nickname_candidates = ["My Agent"]
```

Use `read-only` for research, review, planning, and security agents that should not edit code. Use `workspace-write` for agents expected to implement changes.

## Naming

Use lowercase `underscore_case`: `python_expert`, `security_auditor`, `buffer_api`.

## Validation

Before opening a pull request:

```bash
./scripts/validate-agents.sh
```

Also add the agent to `README.md`, `docs/agent-guide.md`, and relevant examples.

## Pull Request Checklist

- [ ] Agent TOML parses successfully.
- [ ] `name`, `description`, and `developer_instructions` are present.
- [ ] Filename matches `name`.
- [ ] No legacy fields or command examples are present.
- [ ] Sandbox and model defaults match the agent's risk profile.
- [ ] Documentation and examples are updated.
