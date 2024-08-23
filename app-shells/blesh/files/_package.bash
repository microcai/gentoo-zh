#!/bin/bash

_ble_base_package_type=portage

function _binary_exists {
	while (($#)); do
		type -t -- "$1" &>/dev/null || return 1
	shift
	done
}

function ble/base/package:portage/update {
	if ((EUID != 0)); then
		ble/util/print "Error: Please run as root!" >&2
		return 1
	fi
	if ! _binary_exists qatom || ! _binary_exists pquery; then
		ble/util/print "Warning: Unable to check the version of app-shells/blesh: app-portage/portage-utils and/or sys-apps/pkgcore is not installed."
		ble/util/print "Assuming non-live package is installed."
		emerge -avu app-shells/blesh || return 1
	else
		if [[ $(qatom --format '%{PV}' $(pquery -I app-shells/blesh)) == 9999 ]]; then
			if _binary_exists smart-live-rebuild; then
				smart-live-rebuild -f app-shells/blesh || return 1
			else
				ble/util/print "Error: app-shells/blesh-9999 live package is installed but app-portage/smart-live-rebuild is not installed!" >&2
				ble/util/print "Unable to update. Quiting..." >&2
				return 1
			fi
		else
			emerge -avu app-shells/blesh || return 1
		fi
	fi
	return 6
}
