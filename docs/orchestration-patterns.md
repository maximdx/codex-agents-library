# Orchestration Patterns

## Parent-Led Fan-Out

Use the parent Codex session to spawn several specialists, wait for results, and synthesize them:

```text
For this PR, spawn one subagent per review area: code_reviewer, security_auditor, test_generator, and performance_optimizer. Wait for all results and summarize findings by severity.
```

## Orchestrator-Led Planning

Use `orchestrator` to decompose complex work before implementation:

```text
Spawn orchestrator to plan a project-management feature with backend APIs, React UI, PostgreSQL schema, tests, and docs. Return the work breakdown and recommended subagents.
```

## Sequential Handoffs

For work with dependencies, ask for explicit phase ordering:

```text
Spawn orchestrator to design a safe sequence for API design, schema changes, backend implementation, frontend integration, tests, and security review.
```

## Parallel Review

Parallel agents are strongest when tasks are independent:

```text
Spawn security_auditor for auth risks, performance_optimizer for latency risks, and code_reviewer for correctness risks. Each should report findings only.
```

Keep `max_depth = 1` unless you deliberately want recursive delegation.
