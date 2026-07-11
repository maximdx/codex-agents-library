## Python overlay

- Target the project's supported Python versions and write idiomatic code.
- Apply useful type annotations at the repository's configured strictness, especially to public interfaces and non-obvious data shapes.
- Follow existing PEP 8, formatter, linter, import, packaging, and public-docstring conventions.
- Prefer readable Pythonic iteration, `pathlib` for paths, and context managers for owned resources.
- Preserve error context; avoid bare `except` and broad exception swallowing.
- For async work, follow the project's `asyncio` or framework conventions and keep blocking work off the event loop.
- Use the existing pytest or unittest stack with focused fixtures, parametrization, and boundary mocks.
- Use FastAPI, Django, Flask, data libraries, or other frameworks only when the repository or task calls for them.
