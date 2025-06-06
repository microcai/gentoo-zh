#!/bin/bash

# Allow the user to override command-line flags, bug #357629.
# This is based on Debian's chromium-browser package, and is intended
# to be consistent with Debian.
for f in /etc/thorium/*; do
    [[ -f ${f} ]] && source "${f}"
done

# Prefer user defined CHROMIUM_USER_FLAGS (from env) over system
# default CHROMIUM_FLAGS (from /etc/thorium/default).
CHROMIUM_FLAGS=${CHROMIUM_USER_FLAGS:-"$CHROMIUM_FLAGS"}

# Let the wrapped binary know that it has been run through the wrapper
export CHROME_WRAPPER=$(readlink -f "$0")

PROGDIR=${CHROME_WRAPPER%/*}

case ":$PATH:" in
  *:$PROGDIR:*)
    # $PATH already contains $PROGDIR
    ;;
  *)
    # Append $PROGDIR to $PATH
    export PATH="$PATH:$PROGDIR"
    ;;
esac

if [[ ${EUID} == 0 && -O ${XDG_CONFIG_HOME:-${HOME}} ]]; then
	# Running as root with HOME owned by root.
	# Pass --user-data-dir to work around upstream failsafe.
	CHROMIUM_FLAGS="--user-data-dir=${XDG_CONFIG_HOME:-${HOME}/.config}/thorium
		${CHROMIUM_FLAGS}"
fi

# Select session type and platform
if @@OZONE_AUTO_SESSION@@; then
	platform=
	if [[ ${XDG_SESSION_TYPE} == x11 ]]; then
		platform=x11
	elif [[ ${XDG_SESSION_TYPE} == wayland ]]; then
		platform=wayland
	else
		if [[ -n ${WAYLAND_DISPLAY} ]]; then
			platform=wayland
		else
			platform=x11
		fi
	fi
	if ${DISABLE_OZONE_PLATFORM:-false}; then
		platform=x11
	fi
	CHROMIUM_FLAGS="--ozone-platform=${platform} ${CHROMIUM_FLAGS}"
fi

# Set the .desktop file name
export CHROME_DESKTOP="thorium-browser-thorium.desktop"

exec -a "thorium-browser" "$PROGDIR/thorium" --extra-plugin-dir=/usr/lib/nsbrowser/plugins ${CHROMIUM_FLAGS} "$@"
