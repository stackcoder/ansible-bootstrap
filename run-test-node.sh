#!/bin/bash
set -euf -o pipefail

SCRIPT_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")
CONTAINER_NAME="ansible-bootstrap-test-node"

docker build \
  --tag "localhost/${CONTAINER_NAME}:latest" \
  --file "${SCRIPT_DIR}/test-node/Dockerfile" "${SCRIPT_DIR}/test-node/"

docker run --rm \
  --cap-drop=ALL \
  --cap-add=SYS_CHROOT \
  --cap-add=SETGID \
  --cap-add=SETUID \
  --cap-add=CHOWN \
  --cap-add=AUDIT_WRITE \
  --cap-add=DAC_OVERRIDE \
  -p 2222:22 \
  --name="${CONTAINER_NAME}" \
  "localhost/${CONTAINER_NAME}:latest"
