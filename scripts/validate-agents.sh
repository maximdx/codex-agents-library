#!/usr/bin/env bash
# Validate Codex custom subagent TOML files.

set -euo pipefail

python3 - <<'PYVALIDATOR'
from __future__ import annotations

from pathlib import Path
import re
import sys

try:
    import tomllib
except ModuleNotFoundError:
    print("Python 3.11+ is required for tomllib", file=sys.stderr)
    sys.exit(1)

agents_dir = Path(".codex/agents")
expected_agents = 36
required = {"name", "description", "developer_instructions"}
forbidden_keys = {"tools", "agents", "handoffs"}
valid_sandbox_modes = {"read-only", "workspace-write", "danger-full-access"}
valid_models = {"gpt-5.6-luna", "gpt-5.6-terra", "gpt-5.6-sol"}
valid_reasoning = {"minimal", "low", "medium", "high", "xhigh"}
name_re = re.compile(r"^[a-z0-9]+(_[a-z0-9]+)*$")
nickname_re = re.compile(r"^[A-Za-z0-9 _-]+$")
stale_patterns = [
    "clau" + "de --agent",
    "~/.clau" + "de",
    ".clau" + "de/agents",
    "model: sonnet",
    "\ntools:",
]

errors: list[str] = []
warnings: list[str] = []

print("Codex Subagent Library - Validation")
print("===================================")

if not agents_dir.is_dir():
    print("Error: .codex/agents directory not found")
    sys.exit(1)

agent_files = sorted(agents_dir.glob("*.toml"))
print(f"Found {len(agent_files)} Codex agent files")
if len(agent_files) != expected_agents:
    errors.append(f"Expected {expected_agents} agents, found {len(agent_files)}")

for path in agent_files:
    try:
        data = tomllib.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        errors.append(f"{path}: invalid TOML: {exc}")
        continue

    missing = sorted(required - data.keys())
    if missing:
        errors.append(f"{path}: missing required field(s): {', '.join(missing)}")

    forbidden = sorted(forbidden_keys & data.keys())
    if forbidden:
        errors.append(f"{path}: unsupported legacy field(s): {', '.join(forbidden)}")

    name = data.get("name")
    if not isinstance(name, str) or not name_re.fullmatch(name):
        errors.append(f"{path}: name must be lowercase underscore_case")
    elif path.stem != name:
        errors.append(f"{path}: filename stem must match name '{name}'")

    description = data.get("description")
    if not isinstance(description, str) or len(description.strip()) < 20:
        errors.append(f"{path}: description must be a useful string")

    instructions = data.get("developer_instructions")
    if not isinstance(instructions, str) or len(instructions.strip()) < 500:
        errors.append(f"{path}: developer_instructions is missing or too short")
    elif any(pattern in instructions for pattern in stale_patterns):
        errors.append(f"{path}: developer_instructions contains stale legacy agent syntax")

    model = data.get("model")
    if model is None:
        warnings.append(f"{path}: model omitted; agent will inherit parent setting")
    elif model not in valid_models:
        errors.append(f"{path}: model must be one of {', '.join(sorted(valid_models))}")

    reasoning = data.get("model_reasoning_effort")
    if reasoning is not None and reasoning not in valid_reasoning:
        errors.append(f"{path}: invalid model_reasoning_effort '{reasoning}'")

    sandbox = data.get("sandbox_mode")
    if sandbox is not None and sandbox not in valid_sandbox_modes:
        errors.append(f"{path}: invalid sandbox_mode '{sandbox}'")

    nicknames = data.get("nickname_candidates")
    if nicknames is not None:
        if not isinstance(nicknames, list) or not nicknames or len(set(nicknames)) != len(nicknames):
            errors.append(f"{path}: nickname_candidates must be a non-empty unique list")
        elif not all(isinstance(nick, str) and nickname_re.fullmatch(nick) for nick in nicknames):
            errors.append(f"{path}: nickname_candidates may only use ASCII letters, digits, spaces, hyphens, and underscores")

    print(f"OK {name or path.name}")

print("")
print("Validation Summary")
print("==================")
print(f"Total agents: {len(agent_files)}")
print(f"Errors: {len(errors)}")
print(f"Warnings: {len(warnings)}")

for warning in warnings:
    print(f"Warning: {warning}")
for error in errors:
    print(f"Error: {error}")

if errors:
    sys.exit(1)

print("All Codex subagent validations passed.")
PYVALIDATOR
