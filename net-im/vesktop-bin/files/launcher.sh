#!/usr/bin/env bash
# Vesktop launcher script

declare -a vesktop_flags

# Variables set during ebuild configuration
EBUILD_SECCOMP=false
EBUILD_WAYLAND=false

# Seccomp sandbox
"${EBUILD_SECCOMP}" || vesktop_flags+=( --disable-seccomp-filter-sandbox )

# Wayland support
if "${EBUILD_WAYLAND}" && [[ -n "${WAYLAND_DISPLAY}" ]]; then
	vesktop_flags+=(
		--enable-features=UseOzonePlatform
		--ozone-platform=wayland
		--enable-wayland-ime
	)
fi

exec @@DESTDIR@@/vesktop "${vesktop_flags[@]}" "$@"
