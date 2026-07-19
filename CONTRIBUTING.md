# Contributing to the Codex Subagent Library

## What to Contribute

- New Codex custom agents.
- Better instructions for existing agents.
- Documentation, examples, and validation improvements.
- Tests or smoke scenarios for agent behavior.

## Agent Requirements

Create or edit the agent definition under `agent-src/agents/`. Do not hand-edit `.codex/agents/*.toml`; those are generated runtime files that Codex consumes and that remain checked in for immediate use.

```text
agent-src/
├── agents/<agent_name>.toml
└── fragments/
    ├── common/agent-contract.md
    ├── bases/<shared_role>.md
    ├── overlays/<domain>/<specialty>.md
    └── agents/<agent_name>.md
        ↓ scripts/generate-agents.py
.codex/agents/<agent_name>.toml
```

Each source definition supplies the agent metadata and its ordered `instruction_layers`. The generator resolves those paths under `agent-src/fragments/`. Composition follows this order:

1. Shared contract
2. Execution mode
3. Base role
4. Domain or capability overlays
5. Agent-specific instructions

Not every category needs a distinct fragment. Most presets still use `common/agent-contract.md` plus `agents/<agent_name>.md`. The six language/tool presets instead compose `common/agent-contract.md`, `bases/software-engineer.md`, and one file under `overlays/languages/`. Add a layer only when it owns guidance reused by multiple presets; layers must be additive and non-contradictory rather than relying on later text to override earlier instructions. The orchestrator retains its narrow coordination exception. Do not consolidate or rewrite agent semantics as part of an unrelated contribution.

Start from `templates/agent-template.md` for the descriptor and `templates/agent-instructions-template.md` for the agent-specific fragment. The descriptor filename must match the `name` field.

Required fields:

```toml
name = "my_agent"
description = "Use when you need a focused specialist for a clear task."
model = "gpt-5.6-terra"
model_reasoning_effort = "medium"
sandbox_mode = "workspace-write"
nickname_candidates = ["My Agent"]
instruction_layers = [
  "common/agent-contract.md",
  "agents/my_agent.md",
]
```

Use `read-only` for research, review, planning, and security agents that should not edit code. Use `workspace-write` for agents expected to implement changes.

Choose the least expensive tier that reliably handles the role: `gpt-5.6-luna` for bounded, high-volume work; `gpt-5.6-terra` for implementation and analysis; and `gpt-5.6-sol` for high-risk review or adjudication. Start at `low` or `medium` reasoning and use `high` only when the role benefits from deeper judgment.

## Naming

Use lowercase `underscore_case`: `python_expert`, `security_auditor`, `buffer_api`.

## Validation

Before opening a pull request:

```bash
python3 scripts/generate-agents.py
python3 scripts/generate-agents.py --check
./scripts/validate-agents.sh
```

The first command updates the checked-in standalone TOMLs. The check command fails when generated output has drifted from `agent-src/`, and the validator checks the resulting Codex configuration. Commit both the source change and its generated `.codex/agents/*.toml` output.

Also add a new agent to `README.md`, `docs/agent-guide.md`, and relevant examples. Existing public names and filenames are compatibility guarantees during this migration; renaming or removing an agent requires a separately documented breaking change.

## Pull Request Checklist

- [ ] Agent source and generated TOML both parse successfully.
- [ ] All descriptor fields shown above are present and valid.
- [ ] Every instruction layer exists under `agent-src/fragments/`.
- [ ] Filename matches `name`.
- [ ] No legacy fields or command examples are present.
- [ ] Sandbox and model defaults match the agent's risk profile.
- [ ] `python3 scripts/generate-agents.py --check` passes.
- [ ] Generated `.codex/agents/*.toml` output is committed.
- [ ] Documentation and examples are updated.
