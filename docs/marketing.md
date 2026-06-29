# Marketing Notes

## Positioning

Codex Subagent Library provides 36 ready-to-use custom agents for development teams that want focused specialist workflows inside Codex.

## Key Messages

- Project-scoped custom agents live in `.codex/agents/`.
- Agents use explicit Codex TOML schema and role-based model/sandbox defaults.
- The catalog covers orchestration, full-stack work, language experts, testing, design, productivity, DevOps, debugging, and Buffer content operations.
- Validation is built in with `./scripts/validate-agents.sh`.

## Demo Prompt

```text
Spawn orchestrator to plan a full-stack authentication feature. Then have the parent session spawn backend_developer, frontend_developer, database_architect, test_generator, and security_auditor for the relevant phases.
```
