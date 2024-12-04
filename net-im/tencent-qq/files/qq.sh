#!/bin/bash

if [ -d ~/.config/QQ/versions ]; then
	find ~/.config/QQ/versions -name sharp-lib -type d -exec rm -r {} \; 2>/dev/null
fi

# Allow users to override command-line options
if [[ -f $XDG_CONFIG_HOME/qq-flags.conf ]]; then
    QQ_USER_FLAGS="$(grep -v '^#' $XDG_CONFIG_HOME/qq-flags.conf)"
fi

exec /opt/QQ/qq $QQ_USER_FLAGS "$@"
