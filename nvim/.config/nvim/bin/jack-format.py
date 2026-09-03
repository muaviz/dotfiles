#!/usr/bin/env python3
"""
Simple and robust code formatter for the Jack language (Nand2Tetris).
Reads Jack code from stdin and outputs properly formatted/indented code to stdout.
"""

import sys


def format_jack(text: str) -> str:
    lines = text.splitlines()
    indent = 0
    formatted = []
    in_block_comment = False

    for raw_line in lines:
        line = raw_line.strip()
        if not line:
            formatted.append("")
            continue

        if in_block_comment:
            prefix = " " * (indent * 4 + (1 if line.startswith("*") else 0))
            formatted.append(prefix + line)
            if "*/" in line:
                in_block_comment = False
            continue

        if line.startswith("/*") or line.startswith("/**"):
            formatted.append(" " * (indent * 4) + line)
            if "*/" not in line:
                in_block_comment = True
            continue

        leading_close = 0
        for ch in line:
            if ch == "}":
                leading_close += 1
            elif ch.isspace():
                continue
            else:
                break

        current_indent = max(0, indent - leading_close)
        formatted.append(" " * (current_indent * 4) + line)

        # Count net braces, ignoring string literals and line comments
        temp = ""
        in_str = False
        i = 0
        while i < len(line):
            if not in_str and line[i : i + 2] == "//":
                break
            if line[i] == '"':
                in_str = not in_str
            elif not in_str:
                temp += line[i]
            i += 1

        net = temp.count("{") - temp.count("}")
        indent = max(0, indent + net)

    # Ensure single trailing newline
    result = "\n".join(formatted).rstrip()
    return (result + "\n") if result else ""


if __name__ == "__main__":
    sys.stdout.write(format_jack(sys.stdin.read()))
