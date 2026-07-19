#!/usr/bin/env python3
"""Generate standalone Codex agent TOMLs from layered source descriptors."""

from __future__ import annotations

import argparse
import json
import re
import sys
import tomllib
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE_DIR = ROOT / "agent-src" / "agents"
FRAGMENT_DIR = ROOT / "agent-src" / "fragments"
OUTPUT_DIR = ROOT / ".codex" / "agents"
REQUIRED_KEYS = {
    "name",
    "description",
    "model",
    "model_reasoning_effort",
    "sandbox_mode",
    "nickname_candidates",
    "instruction_layers",
}
PLACEHOLDER = re.compile(r"{{\s*([A-Za-z_][A-Za-z0-9_]*)\s*}}")
AGENT_NAME = re.compile(r"[a-z][a-z0-9_]*\Z")


class GenerationError(Exception):
    """A source descriptor or fragment is invalid."""


def toml_string(value: str) -> str:
    """Return a TOML-compatible basic string."""
    return json.dumps(value, ensure_ascii=False)


def load_descriptor(path: Path) -> dict[str, object]:
    try:
        data = tomllib.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, tomllib.TOMLDecodeError) as exc:
        raise GenerationError(f"cannot read descriptor {path.relative_to(ROOT)}: {exc}") from exc

    missing = REQUIRED_KEYS - data.keys()
    extra = data.keys() - REQUIRED_KEYS
    if missing:
        raise GenerationError(f"{path.relative_to(ROOT)} is missing keys: {', '.join(sorted(missing))}")
    if extra:
        raise GenerationError(f"{path.relative_to(ROOT)} has unknown keys: {', '.join(sorted(extra))}")

    scalar_keys = REQUIRED_KEYS - {"nickname_candidates", "instruction_layers"}
    for key in scalar_keys:
        if not isinstance(data[key], str) or not data[key]:
            raise GenerationError(f"{path.relative_to(ROOT)}: {key} must be a non-empty string")
    for key in ("nickname_candidates", "instruction_layers"):
        value = data[key]
        if not isinstance(value, list) or not value or not all(isinstance(item, str) and item for item in value):
            raise GenerationError(f"{path.relative_to(ROOT)}: {key} must be a non-empty string array")

    name = data["name"]
    if not AGENT_NAME.fullmatch(name):
        raise GenerationError(f"{path.relative_to(ROOT)}: invalid agent name {name!r}")
    return data


def read_layer(layer: str, descriptor_path: Path) -> str:
    relative = Path(layer)
    if relative.is_absolute() or relative.suffix != ".md" or ".." in relative.parts:
        raise GenerationError(f"{descriptor_path.relative_to(ROOT)}: unsafe instruction layer {layer!r}")

    root = FRAGMENT_DIR.resolve()
    path = (FRAGMENT_DIR / relative).resolve()
    if not path.is_relative_to(root):
        raise GenerationError(f"{descriptor_path.relative_to(ROOT)}: unsafe instruction layer {layer!r}")
    if not path.is_file():
        raise GenerationError(f"{descriptor_path.relative_to(ROOT)}: missing instruction layer {layer!r}")
    try:
        return path.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as exc:
        raise GenerationError(f"cannot read fragment {path.relative_to(ROOT)}: {exc}") from exc


def render_instructions(descriptor: dict[str, object], path: Path) -> str:
    instructions = "".join(read_layer(layer, path) for layer in descriptor["instruction_layers"])
    values = {"name": descriptor["name"]}

    def replace(match: re.Match[str]) -> str:
        key = match.group(1)
        if key not in values:
            return match.group(0)
        return str(values[key])

    instructions = PLACEHOLDER.sub(replace, instructions)
    unresolved = sorted(set(PLACEHOLDER.findall(instructions)))
    if unresolved:
        raise GenerationError(
            f"{path.relative_to(ROOT)}: unresolved placeholders: {', '.join(unresolved)}"
        )
    if '"""' in instructions:
        raise GenerationError(
            f"{path.relative_to(ROOT)}: rendered instructions contain an unescaped triple quote"
        )
    return instructions


def render_agent(descriptor: dict[str, object], path: Path) -> bytes:
    nicknames = ", ".join(toml_string(item) for item in descriptor["nickname_candidates"])
    instructions = render_instructions(descriptor, path)
    lines = [
        f'name = {toml_string(descriptor["name"])}',
        f'description = {toml_string(descriptor["description"])}',
        f'model = {toml_string(descriptor["model"])}',
        f'model_reasoning_effort = {toml_string(descriptor["model_reasoning_effort"])}',
        f'sandbox_mode = {toml_string(descriptor["sandbox_mode"])}',
        f"nickname_candidates = [{nicknames}]",
    ]
    content = (
        "\n".join(lines)
        + '\ndeveloper_instructions = """\n'
        + instructions
        + '"""\n'
    ).encode("utf-8")
    try:
        tomllib.loads(content.decode("utf-8"))
    except tomllib.TOMLDecodeError as exc:
        raise GenerationError(f"generated invalid TOML for {descriptor['name']}: {exc}") from exc
    return content


def build_outputs() -> dict[str, bytes]:
    if not SOURCE_DIR.is_dir():
        raise GenerationError(f"missing source directory {SOURCE_DIR.relative_to(ROOT)}")
    paths = sorted(SOURCE_DIR.glob("*.toml"))
    if not paths:
        raise GenerationError(f"no descriptors found in {SOURCE_DIR.relative_to(ROOT)}")

    outputs: dict[str, bytes] = {}
    names: dict[str, Path] = {}
    for path in paths:
        descriptor = load_descriptor(path)
        name = str(descriptor["name"])
        if name in names:
            raise GenerationError(
                f"duplicate agent name {name!r} in {names[name].relative_to(ROOT)} and {path.relative_to(ROOT)}"
            )
        if path.stem != name:
            raise GenerationError(f"{path.relative_to(ROOT)}: filename must match agent name {name!r}")
        names[name] = path
        outputs[f"{name}.toml"] = render_agent(descriptor, path)
    return outputs


def check_outputs(outputs: dict[str, bytes]) -> int:
    actual = {path.name for path in OUTPUT_DIR.glob("*.toml")} if OUTPUT_DIR.is_dir() else set()
    expected = set(outputs)
    problems: list[str] = []
    for name in sorted(expected - actual):
        problems.append(f"missing generated file: .codex/agents/{name}")
    for name in sorted(actual - expected):
        problems.append(f"unexpected generated file: .codex/agents/{name}")
    for name in sorted(actual & expected):
        if (OUTPUT_DIR / name).read_bytes() != outputs[name]:
            problems.append(f"out of date: .codex/agents/{name}")
    if problems:
        print("Generated agents are not up to date:", file=sys.stderr)
        for problem in problems:
            print(f"  - {problem}", file=sys.stderr)
        return 1
    print(f"All {len(outputs)} generated agents are up to date.")
    return 0


def write_outputs(outputs: dict[str, bytes]) -> int:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    actual = {path.name for path in OUTPUT_DIR.glob("*.toml")}
    unexpected = actual - set(outputs)
    if unexpected:
        names = ", ".join(sorted(unexpected))
        raise GenerationError(f"refusing to overwrite output directory with unexpected agents: {names}")
    for name, content in outputs.items():
        (OUTPUT_DIR / name).write_bytes(content)
    print(f"Generated {len(outputs)} agents in {OUTPUT_DIR.relative_to(ROOT)}.")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="verify generated files without writing")
    args = parser.parse_args()
    try:
        outputs = build_outputs()
        return check_outputs(outputs) if args.check else write_outputs(outputs)
    except GenerationError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
