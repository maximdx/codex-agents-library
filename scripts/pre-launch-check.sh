#!/usr/bin/env bash
# Lightweight release check for the Codex Subagent Library.

set -euo pipefail

echo "Pre-launch verification for Codex Subagent Library"
echo "==============================================="

python3 ./scripts/generate-agents.py --check
./scripts/validate-agents.sh

required_docs="README.md CONTRIBUTING.md TESTING.md CODE_OF_CONDUCT.md LICENSE"
for doc in $required_docs; do
  test -f "$doc" || { echo "Missing $doc"; exit 1; }
done

pattern="clau""de --agent|~/.clau""de|\.clau""de/agents|model: sonnet|^tools:"
if grep -RInE "$pattern" README.md CONTRIBUTING.md TESTING.md docs scripts/README.md templates agent-src .codex/agents; then
  echo "Found stale legacy agent syntax"
  exit 1
fi

echo "Pre-launch checks passed."
