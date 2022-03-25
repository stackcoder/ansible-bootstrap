#!/bin/bash
set -euf -o pipefail

if ! ( [[ "${1:-}" =~ ^ansible(-[a-z]+)?$ ]] && command -v "$1" >/dev/null 2>&1 ); then
  set -- ansible-playbook "$@"
fi

exec "$@"
