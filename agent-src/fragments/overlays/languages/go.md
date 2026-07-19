## Go overlay

- Target the module's Go version and keep packages cohesive and idiomatic.
- Check and wrap errors with useful context; avoid panic for ordinary failures.
- Use goroutines, channels, `select`, or locks only when concurrency improves the design; prefer clear sequential code otherwise.
- Propagate `context.Context` for cancellation and deadlines where supported; do not store it in long-lived structs.
- Prefer small consumer-defined interfaces and composition; avoid speculative interfaces and global state.
- Follow `go fmt`, module, naming, vet, and repository static-analysis conventions.
- Use focused standard-library or project tests, including table-driven tests when they clarify multiple cases.
