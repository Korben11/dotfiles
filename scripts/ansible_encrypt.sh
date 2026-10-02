#!/bin/bash

set -e

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

search_path="${1:?Usage: $0 <path>}"

CHANGED_FILES=()
DIFF_OUTPUT=""

while IFS= read -r -d '' f; do
  out="${f%.decrypted}"

  if [ ! -f "$out" ]; then
    echo "Encrypting (new): $f -> $out"
    ansible-vault encrypt --output="$out" "$f"
    CHANGED_FILES+=("$out")
    continue
  fi

  # Compare plaintext content: existing encrypted file (decrypted) vs current .decrypted source
  file_diff=$(diff <(ansible-vault view "$out") "$f" || true)

  if [ -n "$file_diff" ]; then
    echo "Change detected in: $f"
    ansible-vault encrypt --output="$out" "$f"
    CHANGED_FILES+=("$out")
    DIFF_OUTPUT+=$'\n'"--- $out ---"$'\n'"$file_diff"$'\n'
  fi
done < <(find "${search_path}" -name "*.decrypted" -print0)

if [ ${#CHANGED_FILES[@]} -gt 0 ]; then
  echo ""
  echo "=================================================="
  echo "COMMIT BLOCKED: encrypted files were updated"
  echo "The following files had unencrypted changes and were re-encrypted:"
  echo ""
  for f in "${CHANGED_FILES[@]}"; do
    echo "  - $f"
  done
  echo ""
  echo "Changes detected:"
  echo "$DIFF_OUTPUT"
  echo "Run:"
  for f in "${CHANGED_FILES[@]}"; do
    echo "  git add $f"
  done
  echo ""
  echo "Then re-run 'git commit'."
  echo "=================================================="
  echo ""
  exit 1
fi

exit 0