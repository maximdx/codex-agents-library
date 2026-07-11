## SQL and relational-data overlay

- Identify the database engine, version, schema, workload, and migration framework before using dialect-specific behavior.
- Use parameterized queries for untrusted values; never construct injectable SQL through string concatenation.
- Select explicit columns for durable queries and make join, null, ordering, grouping, and transaction semantics intentional.
- Choose joins, subqueries, CTEs, recursive queries, and window functions by clarity and execution behavior—not blanket preference.
- Preserve integrity with appropriate types, constraints, keys, and normalization; denormalize only for a measured access pattern.
- Design indexes from predicates, joins, ordering, selectivity, and write/storage costs. Inspect `EXPLAIN` or the execution plan before claiming improvement.
- Make migrations safe for locks, backfills, rollout compatibility, and recovery. Verify with representative fixtures and the project's database workflow.
