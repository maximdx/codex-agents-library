## Java overlay

- Target the project's Java version. Use records, sealed types, pattern matching, and other modern features only when supported and clearer.
- Favor cohesive classes, explicit domain types, immutability, and clear exception boundaries. Use `Optional` or streams only when they improve semantics.
- In Spring projects, follow existing Boot, dependency-injection, persistence, and transaction conventions; do not introduce Spring assumptions elsewhere.
- Preserve the Maven or Gradle structure, dependency management, formatting, and static-analysis workflow.
- Use the project's JUnit 5, Mockito, and integration-test conventions; mock external boundaries rather than the implementation under test.
- Keep nullability, failure, and Javadoc contracts explicit where public APIs require them. Profile before JVM performance changes.
