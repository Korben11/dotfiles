#!/bin/bash

set -e

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

search_path="${1:?Usage: $0 <path>}"

find "${search_path}" -name "vault.*" ! -name "*.decrypted" | while read -r f; do
  out="${f}.decrypted"

  echo "Decrypting: $f -> $out"
  ansible-vault decrypt --output="$out" "$f"
done
