# Best Practices

## Spawn Explicitly

Codex only spawns subagents when you ask it to. Use direct prompts:

```text
Spawn security_auditor to review this authentication change for exploitable risks.
Spawn test_generator to add regression coverage for the bug fixed in this diff.
```

## Match Agent to Task

Use the narrowest specialist that can complete the job. Use `orchestrator` only when the request spans multiple domains or needs coordinated sequencing.

## Respect Sandbox Defaults

Read-only agents are for exploration, review, planning, research, and security analysis. Workspace-write agents can implement changes, but they still inherit the parent Codex approval policy and runtime overrides.

## Give Useful Context

Include goal, relevant paths, constraints, and done criteria. For example:

```text
Spawn backend_developer to add rate limiting to the login endpoint. Follow existing Express middleware patterns in src/middleware, preserve the API shape, and add the smallest relevant tests.
```

## Keep Fan-Out Controlled

The project config uses `max_depth = 1` to prevent recursive fan-out. For large work, ask the parent Codex session to spawn several named agents and then consolidate the result.
