# GitHub Setup

This repository validates Codex subagents with GitHub Actions.

The workflow at `.github/workflows/validate.yml` runs:

```bash
./scripts/validate-agents.sh
```

It also checks that primary docs do not contain stale legacy command syntax. For pull requests, update the relevant docs and include the validator output in the PR notes.
