#!/bin/sh
#
# Copyright (c) 2009 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

if ! grep -q /dev/shm /proc/mounts ; then
	xmessage -file - <<EOF
You don't have tmpfs mounted at /dev/shm.
The browser isn't going to work in that configuration.
Please uncomment the /dev/shm entry in /etc/fstab,
run 'mount /dev/shm' and try again.
EOF
	exit 1
fi

if [ `stat -c %a /dev/shm` -ne 1777 ]; then
	xmessage -file - <<EOF
/dev/shm does not have correct permissions.
The browser isn't going to work in that configuration.
Please run chmod 1777 /dev/shm and try again.
EOF
	exit 1
fi

# Let the wrapped binary know that it has been run through the wrapper
export CHROME_WRAPPER="`readlink -f "$0"`"

PROGDIR="`dirname "$CHROME_WRAPPER"`"

case ":$PATH:" in
  *:$PROGDIR:*)
    # $PATH already contains $PROGDIR
    ;;
  *)
    # Append $PROGDIR to $PATH
    export PATH="$PATH:$PROGDIR"
    ;;
esac

# Set the .desktop file name
export CHROME_DESKTOP="chromium-chromium.desktop"

exec "$PROGDIR/chrome" "$@"
