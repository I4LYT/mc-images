#!/bin/bash
set -e

MC_UID="${MC_UID:-10042}"
MC_GID="${MC_GID:-10042}"
MC_DATA_DIR="${MC_DATA_DIR:-/data}"

if ! [[ "$MC_UID" =~ ^[0-9]+$ && "$MC_GID" =~ ^[0-9]+$ ]]; then
    echo "MC_UID and MC_GID must be numeric" >&2
    exit 1
fi

if [ "$(id -u)" = "0" ]; then
    mkdir -p "$MC_DATA_DIR"
    chown -R "${MC_UID}:${MC_GID}" "$MC_DATA_DIR"
    chmod -R u+rwX,g+rwX "$MC_DATA_DIR"
    cd "$MC_DATA_DIR"
    exec gosu "${MC_UID}:${MC_GID}" "$@"
else
    cd "$MC_DATA_DIR"
    exec "$@"
fi