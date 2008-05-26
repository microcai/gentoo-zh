#!/bin/bash
user_xim="${HOME}/.gentoo/eselect-xim/current-user-xim"
system_xim="/etc/eselect-xim/current-system-xim"

if [ -z "${UID}" ] ; then
	# id lives in /usr/bin which might not be mounted
	if type id >/dev/null 2>/dev/null ; then
		user_id=$(id -u)
	else
		[ "${USER}" = "root" ] && user_id=0
	fi
else
	user_id=${UID}
fi

if [ "${user_id}" != 0 -a -L "${user_xim}" ]; then
	source ${user_xim}
elif [ -L "${system_xim}" ]; then
	source ${system_xim}
fi

unset user_xim
unset system_xim
unset user_id
