# CLI, App, and IDE Notes

Codex custom agents are project-scoped when stored under `.codex/agents/`.

- CLI: start `codex` from this repository root and prompt `Spawn agent_name to ...`.
- Codex app: open this folder as the project so the `.codex` directory is in scope.
- IDE extension: subagent visibility may vary by Codex release; use the CLI or app if you need to inspect active subagent threads.

Subagents inherit the parent session's approval policy and runtime overrides. A custom agent file can set defaults such as `sandbox_mode`, but live parent overrides still apply.
