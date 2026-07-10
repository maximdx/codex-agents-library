# Scripts

Utilities for validating and smoke-testing the Codex subagent library.

## `generate-agents.py`

Composes the source presets in `agent-src/agents/` with their ordered
instruction fragments and writes standalone Codex agent files to
`.codex/agents/`.

```bash
python3 scripts/generate-agents.py
```

Use check mode in CI or before committing. It verifies that the checked-in
runtime files exactly match their sources without modifying the working tree:

```bash
python3 scripts/generate-agents.py --check
```

## `validate-agents.sh`

Validates all project-scoped Codex custom agents in `.codex/agents/`.

```bash
./scripts/validate-agents.sh
```

Checks:
- Exactly 36 `.toml` agent files are present.
- Exactly 36 source presets are present in `agent-src/agents/`.
- Source preset names and generated agent names match exactly.
- Each source preset declares a valid name and a non-empty, duplicate-free
  `instruction_layers` list.
- Each file parses as TOML.
- Required Codex fields exist: `name`, `description`, and `developer_instructions`.
- Agent names are lowercase `underscore_case` and match filenames.
- legacy fields and command examples are absent.
- `model`, `model_reasoning_effort`, `sandbox_mode`, and nicknames use supported shapes.

Composition, layer resolution, and generated-file drift are intentionally
owned by `generate-agents.py --check`; the validator focuses on the source and
runtime catalog contracts.

## `pre-launch-check.sh`

Runs the generation drift check, agent validation, required-document checks,
and stale-syntax scan across both source fragments and generated agents:

```bash
./scripts/pre-launch-check.sh
```

## Manual Smoke Tests

Start Codex at the repository root, then prompt it to spawn representative agents:

```text
Spawn python_expert to create a typed CSV parser with pytest tests.
Spawn security_auditor to review this branch for OWASP Top 10 risks without editing files.
Spawn orchestrator to plan a full-stack authentication feature and identify which subagents should handle each phase.
```

Use `TESTING.md` for the full scenario matrix.
