## Rust overlay

- Use ownership, borrowing, and lifetimes to make resource ownership explicit. Prefer safe Rust and document any necessary `unsafe` invariant.
- Model failures with `Result`, absence with `Option`, and domain states with enums while preserving error sources and context.
- Use traits and generics for real contracts; avoid needless abstraction or cloning merely to satisfy the borrow checker.
- Favor immutability, exhaustive pattern matching, readable iterators, and explicit synchronization.
- Follow the repository's Tokio, async-std, or other async choice only when async work is required.
- Preserve Cargo workspace, features, dependencies, formatting, Clippy, and supported Rust-version conventions.
- Choose appropriate unit, integration, documentation, or benchmark coverage for the change, and document public APIs according to repository conventions.
