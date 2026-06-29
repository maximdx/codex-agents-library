# Scripts

Utilities for validating and smoke-testing the Codex subagent library.

## `validate-agents.sh`

Validates all project-scoped Codex custom agents in `.codex/agents/`.

```bash
./scripts/validate-agents.sh
```

Checks:
- Exactly 36 `.toml` agent files are present.
- Each file parses as TOML.
- Required Codex fields exist: `name`, `description`, and `developer_instructions`.
- Agent names are lowercase `underscore_case` and match filenames.
- legacy fields and command examples are absent.
- `model`, `model_reasoning_effort`, `sandbox_mode`, and nicknames use supported shapes.

## Manual Smoke Tests

Start Codex at the repository root, then prompt it to spawn representative agents:

```text
Spawn python_expert to create a typed CSV parser with pytest tests.
Spawn security_auditor to review this branch for OWASP Top 10 risks without editing files.
Spawn orchestrator to plan a full-stack authentication feature and identify which subagents should handle each phase.
```

Use `TESTING.md` for the full scenario matrix.
