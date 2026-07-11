![Codex Subagent Library thumbnail](assets/repository-thumbnail.png)

# Codex Agents/Subagents Library

A Codex-only library of 36 project-scoped custom subagents for software development, review, planning, design, DevOps, debugging, and Buffer content operations.

Codex loads the checked-in standalone files in `.codex/agents/*.toml`. Contributors author those files through the layered sources in `agent-src/`, which are assembled deterministically so shared instructions do not have to be maintained in every agent by hand.

## Quick Start

1. Install and authenticate Codex.
2. Clone or open this repository at the project root.
3. Start Codex from this folder so it can load `.codex/agents/` and `.codex/config.toml`.
4. Ask Codex to spawn a subagent explicitly:

```text
Spawn python_expert to refactor this parser with type hints and pytest coverage.
Spawn security_auditor to review this branch for auth and input-validation risks.
Spawn orchestrator to plan a full-stack authentication feature and delegate specialist work.
```

Codex only spawns subagents when explicitly asked. The project config keeps direct child spawning enabled with `max_depth = 1` and caps concurrent threads at `max_threads = 4`.

## GPT-5.6 Routing Policy

Every agent has an explicit model and reasoning effort so expensive parent settings are not inherited accidentally:

- `gpt-5.6-luna` at low or medium handles bounded research, decomposition, documentation, and routine integrations.
- `gpt-5.6-terra` at medium is the default implementation and orchestration worker; high is reserved for architecture, debugging, infrastructure, and performance work.
- `gpt-5.6-sol` at high is reserved for correctness and security review, where missed risks are costly.

This is a starting policy, not a substitute for measurement. Escalate a task only when requirements conflict, evidence remains inconclusive, or security, concurrency, compatibility, or data integrity materially raises the cost of a wrong answer.

## Agent Catalog

### Orchestration

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Orchestrator](.codex/agents/orchestrator.toml) | Coordinates complex multi-agent software workflows and integrates specialist outputs. | `workspace-write` | `gpt-5.6-terra` |
| [Workflow Manager](.codex/agents/workflow_manager.toml) | Designs sequential and parallel execution workflows with dependencies, retries, and handoffs. | `workspace-write` | `gpt-5.6-terra` |
| [Project Manager](.codex/agents/project_manager.toml) | Plans sprints, backlogs, stakeholder updates, risks, and delivery milestones. | `read-only` | `gpt-5.6-terra` |

### Full-Stack Development

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Frontend Developer](.codex/agents/frontend_developer.toml) | Builds modern web interfaces with React, Vue, Angular, TypeScript, state management, and accessibility. | `workspace-write` | `gpt-5.6-terra` |
| [Backend Developer](.codex/agents/backend_developer.toml) | Builds APIs, authentication, authorization, validation, database access, and server-side business logic. | `workspace-write` | `gpt-5.6-terra` |
| [Full-Stack Expert](.codex/agents/fullstack_expert.toml) | Implements complete features across frontend, backend, database, tests, and integration boundaries. | `workspace-write` | `gpt-5.6-terra` |
| [Mobile Developer](.codex/agents/mobile_developer.toml) | Builds cross-platform and native mobile features with React Native, Flutter, iOS, and Android patterns. | `workspace-write` | `gpt-5.6-terra` |
| [API Designer](.codex/agents/api_designer.toml) | Designs REST, GraphQL, OpenAPI contracts, versioning strategy, and API documentation. | `workspace-write` | `gpt-5.6-terra` |
| [Database Architect](.codex/agents/database_architect.toml) | Designs schemas, data models, indexes, migrations, and query optimization strategies. | `workspace-write` | `gpt-5.6-terra` |

### Language Experts

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Python Expert](.codex/agents/python_expert.toml) | Implements modern Python with type hints, pytest, async patterns, and framework best practices. | `workspace-write` | `gpt-5.6-terra` |
| [JavaScript Expert](.codex/agents/javascript_expert.toml) | Implements modern JavaScript and TypeScript across React, Node.js, testing, and build tooling. | `workspace-write` | `gpt-5.6-terra` |
| [Rust Expert](.codex/agents/rust_expert.toml) | Implements Rust with ownership, borrowing, async, error handling, and performance-aware design. | `workspace-write` | `gpt-5.6-terra` |
| [Go Expert](.codex/agents/go_expert.toml) | Implements idiomatic Go services with concurrency, interfaces, error handling, and testing. | `workspace-write` | `gpt-5.6-terra` |
| [Java Expert](.codex/agents/java_expert.toml) | Implements Java and Spring Boot code with Maven or Gradle, JUnit, and enterprise patterns. | `workspace-write` | `gpt-5.6-terra` |
| [SQL Expert](.codex/agents/sql_expert.toml) | Writes and optimizes SQL queries, indexes, relational schemas, migrations, and execution plans. | `workspace-write` | `gpt-5.6-terra` |

### Testing & Quality

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [E2E Tester](.codex/agents/e2e_tester.toml) | Creates end-to-end tests with Playwright, Cypress, Selenium, page objects, and CI integration. | `workspace-write` | `gpt-5.6-terra` |
| [A/B Test Ideas](.codex/agents/ab_test_ideas.toml) | Generates experiment hypotheses, variants, metrics, guardrails, and product test plans. | `read-only` | `gpt-5.6-luna` |
| [Code Reviewer](.codex/agents/code_reviewer.toml) | Reviews changes for correctness, maintainability, regressions, security risk, and missing tests. | `read-only` | `gpt-5.6-sol` |
| [Security Auditor](.codex/agents/security_auditor.toml) | Audits code and designs for OWASP risks, auth flaws, data exposure, and dependency issues. | `read-only` | `gpt-5.6-sol` |
| [Test Generator](.codex/agents/test_generator.toml) | Creates unit, integration, contract, and regression tests with appropriate mocks and coverage focus. | `workspace-write` | `gpt-5.6-terra` |

### Design & UI/UX

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [UI/UX Designer](.codex/agents/uiux_designer.toml) | Designs user flows, wireframes, interaction patterns, information architecture, and usability improvements. | `workspace-write` | `gpt-5.6-terra` |
| [Figma to HTML](.codex/agents/figma_to_html.toml) | Converts Figma designs or screenshots into accessible HTML, CSS, React, and design tokens. | `workspace-write` | `gpt-5.6-terra` |
| [Responsive Design](.codex/agents/responsive_design.toml) | Improves mobile-first responsive layouts, breakpoints, touch targets, accessibility, and cross-browser behavior. | `workspace-write` | `gpt-5.6-terra` |
| [Design System](.codex/agents/design_system.toml) | Builds component libraries, design tokens, theming, accessibility standards, and usage documentation. | `workspace-write` | `gpt-5.6-terra` |

### Productivity

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Enhanced Planner](.codex/agents/enhanced_planner.toml) | Creates multi-step implementation plans with dependencies, milestones, risks, and success criteria. | `read-only` | `gpt-5.6-terra` |
| [Research Agent](.codex/agents/research_agent.toml) | Researches technical options, documentation, tradeoffs, and current best practices with source citations. | `read-only` | `gpt-5.6-luna` |
| [Task Breakdown](.codex/agents/task_breakdown.toml) | Breaks epics and large asks into stories, tasks, estimates, dependencies, and acceptance criteria. | `read-only` | `gpt-5.6-luna` |
| [Doc Generator](.codex/agents/doc_generator.toml) | Writes README files, API docs, architecture notes, migration guides, and user-facing documentation. | `workspace-write` | `gpt-5.6-luna` |

### DevOps

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Docker Expert](.codex/agents/docker_expert.toml) | Creates and reviews Dockerfiles, compose files, image optimization, build caching, and container security. | `workspace-write` | `gpt-5.6-terra` |
| [Kubernetes Expert](.codex/agents/kubernetes_expert.toml) | Creates and troubleshoots Kubernetes manifests, Helm charts, scaling, networking, and RBAC. | `workspace-write` | `gpt-5.6-terra` |
| [CI/CD Expert](.codex/agents/cicd_expert.toml) | Builds CI/CD workflows for GitHub Actions, GitLab CI, test gates, deployment, and rollback. | `workspace-write` | `gpt-5.6-terra` |
| [Terraform Expert](.codex/agents/terraform_expert.toml) | Builds Terraform modules, state management, cloud resources, variables, outputs, and environment patterns. | `workspace-write` | `gpt-5.6-terra` |

### Debugging

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Debug Detective](.codex/agents/debug_detective.toml) | Investigates errors, stack traces, logs, failure modes, and likely root causes. | `read-only` | `gpt-5.6-terra` |
| [Performance Optimizer](.codex/agents/performance_optimizer.toml) | Finds bottlenecks and improves runtime, queries, memory, bundle size, and latency. | `read-only` | `gpt-5.6-terra` |
| [Legacy Modernizer](.codex/agents/legacy_modernizer.toml) | Plans and executes incremental modernization, refactors, migrations, and technical debt reduction. | `workspace-write` | `gpt-5.6-terra` |

### Integrations

| Agent | Description | Sandbox | Model |
|---|---|---|---|
| [Buffer API Expert](.codex/agents/buffer_api.toml) | Automates Buffer GraphQL workflows for social posting, scheduling, retrieval, editing, analytics, and campaigns. | `workspace-write` | `gpt-5.6-luna` |

## Validation

```bash
python3 scripts/generate-agents.py --check
./scripts/validate-agents.sh
```

`generate-agents.py --check` verifies that the checked-in runtime TOMLs match their layered sources. The validator checks that all 36 TOML files parse, use required Codex fields, match underscore filenames, avoid legacy fields, and use supported model/sandbox settings.

## Layered Agent Authoring

Codex consumes one complete TOML file per custom agent; it does not compose repository fragments at runtime. This repository therefore uses `agent-src/` as its authoring surface and keeps the generated `.codex/agents/*.toml` files checked in for immediate use after cloning.

Instructions are composed in this order:

1. Shared contract
2. Execution mode
3. Base role
4. Domain or capability overlays
5. Agent-specific instructions

All presets use the universal shared contract, with the orchestrator's coordination exception preserved. The first semantic family—Python, JavaScript/TypeScript, Go, Java, Rust, and SQL—also shares a compact Software Engineer base and uses focused language/tool overlays. Other families retain their agent-specific fragments until they are consolidated independently. All 36 public names and each agent's description, model, reasoning effort, sandbox, and nicknames remain stable.

After changing a source file, regenerate and verify the runtime files:

```bash
python3 scripts/generate-agents.py
python3 scripts/generate-agents.py --check
./scripts/validate-agents.sh
```

See [Contributing](CONTRIBUTING.md) for the source layout and contributor workflow.

## Documentation

- [Getting Started](docs/getting-started.md)
- [Create Custom Codex Subagents](docs/create-custom-codex-subagents.md)
- [Agent Guide](docs/agent-guide.md)
- [Examples](docs/examples.md)
- [Orchestration Patterns](docs/orchestration-patterns.md)
- [Best Practices](docs/best-practices.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Testing](TESTING.md)
- [Contributing](CONTRIBUTING.md)

## License

MIT. See [LICENSE](LICENSE).
