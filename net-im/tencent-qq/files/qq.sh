#!/bin/bash

if [ -d ~/.config/QQ/versions ]; then
	find ~/.config/QQ/versions -name sharp-lib -type d -exec rm -r {} \; 2>/dev/null
fi

export LD_PRELOAD=/usr/lib/gcc/x86_64-pc-linux-gnu/12/libstdc++.so.6

/opt/QQ/qq "$@"
