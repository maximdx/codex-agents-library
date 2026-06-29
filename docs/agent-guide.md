# Codex Agent Guide

This guide lists all 36 Codex custom subagents and their intended use.

## Orchestration

### Orchestrator
- File: `.codex/agents/orchestrator.toml`
- Use when: Coordinates complex multi-agent software workflows and integrates specialist outputs.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn orchestrator to handle a focused task in its specialty.`

### Workflow Manager
- File: `.codex/agents/workflow_manager.toml`
- Use when: Designs sequential and parallel execution workflows with dependencies, retries, and handoffs.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn workflow_manager to handle a focused task in its specialty.`

### Project Manager
- File: `.codex/agents/project_manager.toml`
- Use when: Plans sprints, backlogs, stakeholder updates, risks, and delivery milestones.
- Defaults: `gpt-5.4`, `high` reasoning, `read-only` sandbox
- Example: `Spawn project_manager to handle a focused task in its specialty.`

## Full-Stack Development

### Frontend Developer
- File: `.codex/agents/frontend_developer.toml`
- Use when: Builds modern web interfaces with React, Vue, Angular, TypeScript, state management, and accessibility.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn frontend_developer to handle a focused task in its specialty.`

### Backend Developer
- File: `.codex/agents/backend_developer.toml`
- Use when: Builds APIs, authentication, authorization, validation, database access, and server-side business logic.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn backend_developer to handle a focused task in its specialty.`

### Full-Stack Expert
- File: `.codex/agents/fullstack_expert.toml`
- Use when: Implements complete features across frontend, backend, database, tests, and integration boundaries.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn fullstack_expert to handle a focused task in its specialty.`

### Mobile Developer
- File: `.codex/agents/mobile_developer.toml`
- Use when: Builds cross-platform and native mobile features with React Native, Flutter, iOS, and Android patterns.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn mobile_developer to handle a focused task in its specialty.`

### API Designer
- File: `.codex/agents/api_designer.toml`
- Use when: Designs REST, GraphQL, OpenAPI contracts, versioning strategy, and API documentation.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn api_designer to handle a focused task in its specialty.`

### Database Architect
- File: `.codex/agents/database_architect.toml`
- Use when: Designs schemas, data models, indexes, migrations, and query optimization strategies.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn database_architect to handle a focused task in its specialty.`

## Language Experts

### Python Expert
- File: `.codex/agents/python_expert.toml`
- Use when: Implements modern Python with type hints, pytest, async patterns, and framework best practices.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn python_expert to handle a focused task in its specialty.`

### JavaScript Expert
- File: `.codex/agents/javascript_expert.toml`
- Use when: Implements modern JavaScript and TypeScript across React, Node.js, testing, and build tooling.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn javascript_expert to handle a focused task in its specialty.`

### Rust Expert
- File: `.codex/agents/rust_expert.toml`
- Use when: Implements Rust with ownership, borrowing, async, error handling, and performance-aware design.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn rust_expert to handle a focused task in its specialty.`

### Go Expert
- File: `.codex/agents/go_expert.toml`
- Use when: Implements idiomatic Go services with concurrency, interfaces, error handling, and testing.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn go_expert to handle a focused task in its specialty.`

### Java Expert
- File: `.codex/agents/java_expert.toml`
- Use when: Implements Java and Spring Boot code with Maven or Gradle, JUnit, and enterprise patterns.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn java_expert to handle a focused task in its specialty.`

### SQL Expert
- File: `.codex/agents/sql_expert.toml`
- Use when: Writes and optimizes SQL queries, indexes, relational schemas, migrations, and execution plans.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn sql_expert to handle a focused task in its specialty.`

## Testing & Quality

### E2E Tester
- File: `.codex/agents/e2e_tester.toml`
- Use when: Creates end-to-end tests with Playwright, Cypress, Selenium, page objects, and CI integration.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn e2e_tester to handle a focused task in its specialty.`

### A/B Test Ideas
- File: `.codex/agents/ab_test_ideas.toml`
- Use when: Generates experiment hypotheses, variants, metrics, guardrails, and product test plans.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `read-only` sandbox
- Example: `Spawn ab_test_ideas to handle a focused task in its specialty.`

### Code Reviewer
- File: `.codex/agents/code_reviewer.toml`
- Use when: Reviews changes for correctness, maintainability, regressions, security risk, and missing tests.
- Defaults: `gpt-5.4`, `high` reasoning, `read-only` sandbox
- Example: `Spawn code_reviewer to handle a focused task in its specialty.`

### Security Auditor
- File: `.codex/agents/security_auditor.toml`
- Use when: Audits code and designs for OWASP risks, auth flaws, data exposure, and dependency issues.
- Defaults: `gpt-5.4`, `high` reasoning, `read-only` sandbox
- Example: `Spawn security_auditor to handle a focused task in its specialty.`

### Test Generator
- File: `.codex/agents/test_generator.toml`
- Use when: Creates unit, integration, contract, and regression tests with appropriate mocks and coverage focus.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn test_generator to handle a focused task in its specialty.`

## Design & UI/UX

### UI/UX Designer
- File: `.codex/agents/uiux_designer.toml`
- Use when: Designs user flows, wireframes, interaction patterns, information architecture, and usability improvements.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn uiux_designer to handle a focused task in its specialty.`

### Figma to HTML
- File: `.codex/agents/figma_to_html.toml`
- Use when: Converts Figma designs or screenshots into accessible HTML, CSS, React, and design tokens.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn figma_to_html to handle a focused task in its specialty.`

### Responsive Design
- File: `.codex/agents/responsive_design.toml`
- Use when: Improves mobile-first responsive layouts, breakpoints, touch targets, accessibility, and cross-browser behavior.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn responsive_design to handle a focused task in its specialty.`

### Design System
- File: `.codex/agents/design_system.toml`
- Use when: Builds component libraries, design tokens, theming, accessibility standards, and usage documentation.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn design_system to handle a focused task in its specialty.`

## Productivity

### Enhanced Planner
- File: `.codex/agents/enhanced_planner.toml`
- Use when: Creates multi-step implementation plans with dependencies, milestones, risks, and success criteria.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `read-only` sandbox
- Example: `Spawn enhanced_planner to handle a focused task in its specialty.`

### Research Agent
- File: `.codex/agents/research_agent.toml`
- Use when: Researches technical options, documentation, tradeoffs, and current best practices with source citations.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `read-only` sandbox
- Example: `Spawn research_agent to handle a focused task in its specialty.`

### Task Breakdown
- File: `.codex/agents/task_breakdown.toml`
- Use when: Breaks epics and large asks into stories, tasks, estimates, dependencies, and acceptance criteria.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `read-only` sandbox
- Example: `Spawn task_breakdown to handle a focused task in its specialty.`

### Doc Generator
- File: `.codex/agents/doc_generator.toml`
- Use when: Writes README files, API docs, architecture notes, migration guides, and user-facing documentation.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn doc_generator to handle a focused task in its specialty.`

## DevOps

### Docker Expert
- File: `.codex/agents/docker_expert.toml`
- Use when: Creates and reviews Dockerfiles, compose files, image optimization, build caching, and container security.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn docker_expert to handle a focused task in its specialty.`

### Kubernetes Expert
- File: `.codex/agents/kubernetes_expert.toml`
- Use when: Creates and troubleshoots Kubernetes manifests, Helm charts, scaling, networking, and RBAC.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn kubernetes_expert to handle a focused task in its specialty.`

### CI/CD Expert
- File: `.codex/agents/cicd_expert.toml`
- Use when: Builds CI/CD workflows for GitHub Actions, GitLab CI, test gates, deployment, and rollback.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn cicd_expert to handle a focused task in its specialty.`

### Terraform Expert
- File: `.codex/agents/terraform_expert.toml`
- Use when: Builds Terraform modules, state management, cloud resources, variables, outputs, and environment patterns.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn terraform_expert to handle a focused task in its specialty.`

## Debugging

### Debug Detective
- File: `.codex/agents/debug_detective.toml`
- Use when: Investigates errors, stack traces, logs, failure modes, and likely root causes.
- Defaults: `gpt-5.4`, `high` reasoning, `read-only` sandbox
- Example: `Spawn debug_detective to handle a focused task in its specialty.`

### Performance Optimizer
- File: `.codex/agents/performance_optimizer.toml`
- Use when: Finds bottlenecks and improves runtime, queries, memory, bundle size, and latency.
- Defaults: `gpt-5.4`, `high` reasoning, `read-only` sandbox
- Example: `Spawn performance_optimizer to handle a focused task in its specialty.`

### Legacy Modernizer
- File: `.codex/agents/legacy_modernizer.toml`
- Use when: Plans and executes incremental modernization, refactors, migrations, and technical debt reduction.
- Defaults: `gpt-5.4`, `high` reasoning, `workspace-write` sandbox
- Example: `Spawn legacy_modernizer to handle a focused task in its specialty.`

## Integrations

### Buffer API Expert
- File: `.codex/agents/buffer_api.toml`
- Use when: Automates Buffer GraphQL workflows for social posting, scheduling, retrieval, editing, analytics, and campaigns.
- Defaults: `gpt-5.4-mini`, `medium` reasoning, `workspace-write` sandbox
- Example: `Spawn buffer_api to schedule three LinkedIn posts from this launch brief.`

## Naming Conventions

All agent names use lowercase `underscore_case`. Ask Codex to spawn the exact name, for example `Spawn sql_expert to optimize this query.`
