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
source_agents_dir = Path("agent-src/agents")
fragments_dir = Path("agent-src/fragments")
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
language_overlays = {
    "python_expert": "overlays/languages/python.md",
    "javascript_expert": "overlays/languages/javascript-typescript.md",
    "go_expert": "overlays/languages/go.md",
    "java_expert": "overlays/languages/java.md",
    "rust_expert": "overlays/languages/rust.md",
    "sql_expert": "overlays/languages/sql.md",
}
language_markers = {
    "python_expert": [("type annotation", "type hint", "typing"), ("pytest", "unittest"), ("asyncio", "async/await")],
    "javascript_expert": [("typescript",), ("jest", "vitest"), ("async", "promise")],
    "go_expert": [("context.context",), ("table-driven",), ("goroutine", "channel")],
    "java_expert": [("java version", "modern features"), ("spring",), ("junit",)],
    "rust_expert": [("ownership", "borrowing"), ("result", "option"), ("cargo",)],
    "sql_expert": [("parameterized", "sql injection"), ("execution plan", "explain"), ("index", "constraint")],
}

errors: list[str] = []
warnings: list[str] = []

print("Codex Subagent Library - Validation")
print("===================================")

if not agents_dir.is_dir():
    print("Error: .codex/agents directory not found")
    sys.exit(1)

if not source_agents_dir.is_dir():
    print("Error: agent-src/agents directory not found")
    sys.exit(1)

agent_files = sorted(agents_dir.glob("*.toml"))
source_agent_files = sorted(source_agents_dir.glob("*.toml"))
print(f"Found {len(agent_files)} Codex agent files")
print(f"Found {len(source_agent_files)} source agent presets")
if len(agent_files) != expected_agents:
    errors.append(f"Expected {expected_agents} agents, found {len(agent_files)}")
if len(source_agent_files) != expected_agents:
    errors.append(
        f"Expected {expected_agents} source agent presets, found {len(source_agent_files)}"
    )

output_names = {path.stem for path in agent_files}
source_names = {path.stem for path in source_agent_files}
missing_sources = sorted(output_names - source_names)
missing_outputs = sorted(source_names - output_names)
if missing_sources:
    errors.append(
        "Generated agents missing source preset(s): " + ", ".join(missing_sources)
    )
if missing_outputs:
    errors.append(
        "Source presets missing generated agent(s): " + ", ".join(missing_outputs)
    )

referenced_layers: set[str] = set()
for path in source_agent_files:
    try:
        data = tomllib.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        errors.append(f"{path}: invalid TOML: {exc}")
        continue

    name = data.get("name")
    if not isinstance(name, str) or not name_re.fullmatch(name):
        errors.append(f"{path}: name must be lowercase underscore_case")
    elif path.stem != name:
        errors.append(f"{path}: filename stem must match name '{name}'")

    layers = data.get("instruction_layers")
    if not isinstance(layers, list) or not layers:
        errors.append(f"{path}: instruction_layers must be a non-empty list")
    elif not all(isinstance(layer, str) and layer.strip() for layer in layers):
        errors.append(f"{path}: instruction_layers entries must be non-empty strings")
    elif len(layers) != len(set(layers)):
        errors.append(f"{path}: instruction_layers must not contain duplicates")
    else:
        referenced_layers.update(layers)

    if name in language_overlays:
        expected_layers = [
            "common/agent-contract.md",
            "bases/software-engineer.md",
            language_overlays[name],
        ]
        if layers != expected_layers:
            errors.append(
                f"{path}: language agent layers must be {expected_layers!r}"
            )

available_layers = {
    path.relative_to(fragments_dir).as_posix()
    for path in fragments_dir.rglob("*.md")
} if fragments_dir.is_dir() else set()
unused_layers = sorted(available_layers - referenced_layers)
if unused_layers:
    errors.append("Unused instruction layer(s): " + ", ".join(unused_layers))

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
    elif name in language_markers:
        normalized = instructions.lower()
        for alternatives in language_markers[name]:
            if not any(marker in normalized for marker in alternatives):
                errors.append(
                    f"{path}: missing language behavior marker from {alternatives!r}"
                )

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
print(f"Source presets: {len(source_agent_files)}")
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
