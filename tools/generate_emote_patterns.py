#!/usr/bin/env python3
"""Update existing Mylune's Champions chat patterns from Wago CSV exports.

The Wago exports are expected to contain the EmotesText and EmotesTextData
tables for one locale. The script deliberately updates only emote names and
variant keys already present in the matching locale_*.lua and general_*.lua
files; it never adds new emotes or new variants.

Example:
    python3 tools/generate_emote_patterns.py --locale enUS \
        --emotes EmotesText.12.1.5.69848.csv \
        --data EmotesTextData.12.1.5.69848.csv

Run the command again with the German Wago exports and ``--locale deDE``.
"""

from __future__ import annotations

import argparse
import csv
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LOCALE_DIR = ROOT / "Locales"

# RelationshipFlags values used by the variants which this addon currently
# understands.  8 is the female form of 0, 9 of 1, and 12 of 4. Prefer the
# male row because the addon uses one gender-neutral incoming-chat pattern.
VARIANT_FLAGS = {
    "someoneAtTarget": (0, 8),
    "someoneAtYou": (1, 9),
    "someoneNoTarget": (4, 12),
    "youAtTarget": (2,),
    "youNoTarget": (6,),
}


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as stream:
        return list(csv.DictReader(stream))


def lua_quote(value: str) -> str:
    """Quote a value as a Lua double-quoted string."""

    return (
        '"'
        + value.replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("\r", "\\r")
        .replace("\n", "\\n")
        .replace("\t", "\\t")
        + '"'
    )


def convert_text(text: str, variant: str) -> str | None:
    """Convert Wago's placeholders to this addon's placeholders."""

    if variant == "someoneAtTarget":
        # Wago uses %s for both the speaker and target. The addon uses %t for
        # the target, so replace only the second occurrence.
        matches = list(re.finditer(r"%s", text))
        if len(matches) < 2:
            return None
        second = matches[1]
        return text[: second.start()] + "%t" + text[second.end() :]

    if variant == "youAtTarget":
        if "%s" not in text:
            return None
        return text.replace("%s", "%t", 1)

    if variant == "youNoTarget":
        return text if "%s" not in text else None

    if variant in {"someoneAtYou", "someoneNoTarget"}:
        if "%s" not in text or text.startswith("You "):
            return None
        return text

    return None


def load_patterns(emotes_path: Path, data_path: Path) -> dict[str, dict[str, str]]:
    emotes = read_csv(emotes_path)
    data = read_csv(data_path)

    names_by_id = {row["ID"]: row["Name"] for row in emotes if row.get("Name")}
    rows_by_emote: dict[str, list[dict[str, str]]] = {}
    for row in data:
        name = names_by_id.get(row.get("EmotesTextID", ""))
        if name:
            rows_by_emote.setdefault(name, []).append(row)

    patterns: dict[str, dict[str, str]] = {}
    for name, rows in rows_by_emote.items():
        variants: dict[str, str] = {}
        for variant, flags in VARIANT_FLAGS.items():
            row = next(
                (
                    item
                    for flag in flags
                    for item in rows
                    if item.get("RelationshipFlags") == str(flag)
                ),
                None,
            )
            if row:
                converted = convert_text(row["Text_lang"], variant)
                if converted is not None:
                    variants[variant] = converted
        if variants:
            patterns[name] = variants
    return patterns


def update_locale(path: Path, patterns: dict[str, dict[str, str]]) -> int:
    lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    in_table = False
    current_emote: str | None = None
    changed = 0

    entry_start = re.compile(r"^(\s*)([A-Z][A-Z0-9_]*)\s*=\s*\{\s*$")
    field = re.compile(
        r"^(\s*)([A-Za-z][A-Za-z0-9_]*)\s*=\s*(.*?)(,?\s*(?:\r?\n)?$)"
    )

    for index, line in enumerate(lines):
        if not in_table:
            if line.strip() == "L.EMOTE_PATTERNS = {":
                in_table = True
            continue

        if line.strip() == "}":
            in_table = False
            current_emote = None
            continue

        match = entry_start.match(line)
        if match:
            current_emote = match.group(2)
            continue

        if current_emote not in patterns:
            continue

        match = field.match(line)
        if not match:
            continue

        variant = match.group(2)
        replacement = patterns[current_emote].get(variant)
        if replacement is None:
            continue

        comma = "," if match.group(4).lstrip().startswith(",") else ""
        ending = "\r\n" if line.endswith("\r\n") else "\n" if line.endswith("\n") else ""
        lines[index] = f"{match.group(1)}{variant} = {lua_quote(replacement)}{comma}{ending}"
        changed += 1

    path.write_text("".join(lines), encoding="utf-8")
    return changed


def update_general(path: Path, patterns: dict[str, dict[str, str]]) -> int:
    lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    in_emotes = False
    current_emote: str | None = None
    changed = 0

    entry_start = re.compile(r"^\s*([A-Z][A-Z0-9_]*)\s*=\s*\{\s*$")
    field = re.compile(
        r"^(\s*)([A-Za-z][A-Za-z0-9_]*)\s*=\s*(.*?)(,?\s*(?:\r?\n)?$)"
    )

    for index, line in enumerate(lines):
        if not in_emotes:
            if line.strip() == "EMOTES = {":
                in_emotes = True
            continue

        if line.strip() == "},":
            if current_emote is None:
                in_emotes = False
            current_emote = None
            continue

        match = entry_start.match(line)
        if match:
            current_emote = match.group(1)
            continue

        if current_emote not in patterns:
            continue

        match = field.match(line)
        if not match:
            continue

        variant = match.group(2)
        replacement = patterns[current_emote].get(variant)
        if replacement is None:
            continue

        comma = "," if match.group(4).lstrip().startswith(",") else ""
        ending = "\r\n" if line.endswith("\r\n") else "\n" if line.endswith("\n") else ""
        lines[index] = f"{match.group(1)}{variant} = {lua_quote(replacement)}{comma}{ending}"
        changed += 1

    path.write_text("".join(lines), encoding="utf-8")
    return changed


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--locale", choices=("enUS", "deDE"), required=True)
    parser.add_argument("--emotes", type=Path, required=True)
    parser.add_argument("--data", type=Path, required=True)
    args = parser.parse_args()

    locale_path = LOCALE_DIR / f"locale_{args.locale}.lua"
    if not locale_path.is_file():
        parser.error(f"locale file does not exist: {locale_path}")
    general_path = LOCALE_DIR / f"general_{args.locale}.lua"
    if not general_path.is_file():
        parser.error(f"general locale file does not exist: {general_path}")

    patterns = load_patterns(args.emotes, args.data)
    locale_changed = update_locale(locale_path, patterns)
    general_changed = update_general(general_path, patterns)
    print(f"Updated {locale_changed} existing pattern(s) in {locale_path}")
    print(f"Updated {general_changed} existing pattern(s) in {general_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())