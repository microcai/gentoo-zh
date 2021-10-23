#!/bin/sh
# A script to run Softmaker Presentations.

MACHINE=$(uname -m)

[[ $MACHINE == "x86_64" ]] && LIBDIR_SUFFIX="64" || LIBDIR_SUFFIX="32"

/usr/lib$LIBDIR_SUFFIX/freeoffice/presentations "$@"
