#!/bin/bash

set -euo pipefail

uri="${1:-}"

if [[ -z "${uri}" ]]; then
    echo "wechat-bwrap: missing URI for xdg-open" >&2
    exit 1
fi

if [[ -x /run/host/usr/bin/xdg-open ]]; then
    exec /run/host/usr/bin/xdg-open "${uri}"
fi

echo "wechat-bwrap: no host-side xdg-open helper available at /run/host/usr/bin/xdg-open" >&2
exit 1
