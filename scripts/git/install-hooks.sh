#!/bin/bash
set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"
SRC_DIR="$REPO_ROOT/scripts/git/hooks"
DEST_DIR="$REPO_ROOT/.git/hooks"

if [ ! -d "$SRC_DIR" ]; then
  echo "ERROR: hooks source directory not found at $SRC_DIR"
  exit 1
fi

echo "Installing git hooks from $SRC_DIR to $DEST_DIR ..."

for hook in "$SRC_DIR"/*; do
  hook_name="$(basename "$hook")"
  dest="$DEST_DIR/$hook_name"

  # Backup existing hook if present and not already a symlink to ours
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  Backing up existing $hook_name -> ${hook_name}.bak"
    mv "$dest" "${dest}.bak"
  fi

  ln -sf "$hook" "$dest"
  chmod +x "$hook"
  echo "  Installed: $hook_name"
done

echo "Done. Hooks installed:"
ls -la "$DEST_DIR" | grep -v '\.sample$'
