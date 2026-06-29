# Testing Guide for Codex Subagents

## Automated Validation

Run:

```bash
./scripts/validate-agents.sh
```

Expected result: 36 Codex agent files, 0 errors.

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
- Read-only agents report findings without editing files.
- Workspace-write agents keep changes scoped to their specialty.
- Orchestration prompts keep `max_depth = 1` and ask the parent agent to spawn specialists as needed.
- Results include clear assumptions, validation steps, and remaining risks.
