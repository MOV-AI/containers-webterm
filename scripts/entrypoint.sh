#!/bin/bash
COMMAND="${1:-}"
SSH_HOST="${SSH_HOST:-127.0.0.1}"
SSH_USER="${SSH_USER:-movai}"
SSH_PASS="${SSH_PASS:-M0va1}"
SSH_CMD="${SSH_CMD:-movai-shell}"

if [ $UID -ne 0 ]; then
    echo "$SSH_PASS" | sudo -S service ssh start
fi

cat /opt/mov.ai/.welcome

if [[ ${COMMAND} == "bash" ]]; then
    shift
    exec "/bin/bash" "${@}"
else
    exec wetty \
    -p 3000 \
    --base /terminal \
    --ssh-host "$SSH_HOST" \
    --ssh-user "$SSH_USER" \
    --ssh-pass "$SSH_PASS" \
    --title MOVAI CLI \
    -c "${SSH_CMD}"
fi