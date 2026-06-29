# Getting Started with Codex Subagents

## Prerequisites

- Codex installed and authenticated.
- This repository opened as the current working directory.
- Codex subagent workflows available in your Codex surface. Subagent activity is visible in the Codex app and CLI.

## Install the Library

Use the repository as a project-scoped agent library. The custom agents are already in `.codex/agents/`; no global install step is required.

```bash
./scripts/validate-agents.sh
codex
```

From the Codex session, ask for explicit subagent spawning:

```text
Spawn code_reviewer to review the current diff for correctness and missing tests.
Spawn e2e_tester to create Playwright coverage for checkout.
Spawn docker_expert to optimize this Dockerfile and explain the tradeoffs.
```

## How Codex Loads These Agents

Each `.toml` file defines one custom agent. Codex uses the `name` field as the source of truth; filenames match names for readability. Project-level settings in `.codex/config.toml` set `max_threads = 6` and `max_depth = 1`.

## Choosing an Agent

Use a specialist for focused work, such as `python_expert`, `security_auditor`, or `terraform_expert`. Use `orchestrator` when a task spans multiple domains and needs a coordinated plan.

## First Smoke Test

```text
Spawn python_expert to create a small typed CSV parser and include pytest tests.
```

Then try a read-only role:

```text
Spawn security_auditor to inspect this repository for credential-handling risks and report findings only.
```
