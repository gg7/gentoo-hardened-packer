#!/bin/bash

set -o errexit
set -o nounset

cd /tmp/scripts
for script in ./*-*.sh; do
  if [[ -x "$script" ]]; then
    echo "executing script $script..."
    "$script"
  else
    echo "skipping script $script (not executable)"
  fi
done

echo "$0: all done."
