# Testing Guide for Codex Subagents

## Automated Validation

Regenerate agents after changing a source preset or instruction fragment:

```bash
python3 scripts/generate-agents.py
```

Check that the committed runtime agents are up to date, then validate both the
source presets and generated TOML:

```bash
python3 scripts/generate-agents.py --check
./scripts/validate-agents.sh
```

For the complete release-oriented check, run:

```bash
./scripts/pre-launch-check.sh
```

Expected result: 36 source presets, 36 generated Codex agent files, no
generation drift, and 0 validation errors.

The generation check is deterministic and does not modify files. If it fails,
run the generator without `--check`, review the resulting `.codex/agents/`
changes, and rerun validation.

## Manual Smoke Matrix

| Area | Prompt | Expected result |
|---|---|---|
| Language | `Spawn python_expert to create a typed CSV parser with pytest tests.` | Produces typed Python and tests. |
| Review | `Spawn code_reviewer to review the current diff for correctness and missing tests.` | Reports findings first, no edits. |
| Security | `Spawn security_auditor to audit this API route for OWASP risks.` | Prioritized vulnerabilities and remediations. |
| Frontend | `Spawn frontend_developer to build a React data table with sorting and pagination.` | Component plan or implementation matching repo conventions. |
| DevOps | `Spawn docker_expert to optimize this Dockerfile for size and security.` | Concrete Dockerfile recommendations or patch. |
| Orchestration | `Spawn orchestrator to plan a full-stack auth feature and delegate work.` | Multi-phase plan with specialist assignments. |
| Integration | `Spawn buffer_api to draft and schedule a LinkedIn post through Buffer.` | Checks auth requirements, channel IDs, schedule, and GraphQL operations. |

## Acceptance Criteria

- Codex recognizes each requested subagent name.
- Every `agent-src/agents/*.toml` preset has a matching generated
  `.codex/agents/*.toml` file, and vice versa.
- `python3 scripts/generate-agents.py --check` reports no drift.
- Read-only agents report findings without editing files.
- Workspace-write agents keep changes scoped to their specialty.
- Orchestration prompts keep `max_depth = 1` and ask the parent agent to spawn specialists as needed.
- Results include clear assumptions, validation steps, and remaining risks.
