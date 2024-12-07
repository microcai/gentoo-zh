#!/bin/bash

_ble_base_package_type=portage

function ble/base/package:portage/update {
	if ((EUID != 0)); then
		ble/util/print "Error: Please run as root!" >&2
		return 1
	fi
	smart-live-rebuild -f app-shells/blesh || return 1
	return 6
}
