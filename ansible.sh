#!/bin/bash
set -euf -o pipefail

SCRIPT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")
CONTAINER_NAME="ansible-bootstrap"

docker build \
  --tag "localhost/${CONTAINER_NAME}:latest" \
  --file "${SCRIPT_DIR}/control-node/Dockerfile" "${SCRIPT_DIR}/control-node/"

docker run -it --rm \
  --security-opt=no-new-privileges \
  --cap-drop=ALL \
  -e "SSH_AUTH_SOCK=/ssh.socket" \
  -v "${SSH_AUTH_SOCK}:/ssh.socket" \
  -v "${SCRIPT_DIR}/ansible:/ansible:ro" \
  -v "${CONTAINER_NAME}-cache:/ansible-cache:rw" \
  "localhost/${CONTAINER_NAME}:latest" "$@"
