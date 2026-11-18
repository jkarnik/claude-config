#!/usr/bin/env bash
# Links this repo's CLAUDE.md and reference/ into ~/.claude and creates
# ~/.claude/personal.md if it is missing. Anything already at a link's path is
# renamed to <name>.backup-<timestamp>. Usage: ./install.sh [--dry-run]
set -euo pipefail

usage() { echo "usage: install.sh [--dry-run]" >&2; exit 2; }
DRY=0
if [ $# -gt 1 ]; then usage; fi
if [ $# -eq 1 ]; then [ "$1" = "--dry-run" ] && DRY=1 || usage; fi

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
CLAUDE_DIR="$HOME/.claude"
STAMP="$(date +%Y%m%d-%H%M%S)"

# act "what it does" command args...  Prints the description; runs the command unless --dry-run.
act() {
  local what=$1; shift
  if [ "$DRY" = 1 ]; then echo "would: $what"; else "$@"; echo "$what"; fi
}

for name in CLAUDE.md reference personal.example.md; do
  [ -e "$REPO/$name" ] || { echo "error: $REPO/$name is missing" >&2; exit 1; }
done

[ -d "$CLAUDE_DIR" ] || act "create $CLAUDE_DIR" mkdir -p "$CLAUDE_DIR"

for name in CLAUDE.md reference; do
  src="$REPO/$name"
  dest="$CLAUDE_DIR/$name"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok: $name already linked"
    continue
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    act "back up $dest to $dest.backup-$STAMP" mv "$dest" "$dest.backup-$STAMP"
  fi
  act "link $dest -> $src" ln -s "$src" "$dest"
done

if [ -e "$CLAUDE_DIR/personal.md" ]; then
  echo "ok: personal.md already exists, left as is"
else
  act "copy personal.example.md to $CLAUDE_DIR/personal.md" \
    cp "$REPO/personal.example.md" "$CLAUDE_DIR/personal.md"
fi

echo
if [ "$DRY" = 1 ]; then echo "Dry run: nothing was changed. Run ./install.sh to apply."; fi
echo "Next steps:"
echo "  1. Edit the User Role section of $REPO/CLAUDE.md to fit you."
echo "  2. Add notes that are true only on this machine to $CLAUDE_DIR/personal.md."
echo "  3. Start a new Claude Code session and run /memory to check both files load."
