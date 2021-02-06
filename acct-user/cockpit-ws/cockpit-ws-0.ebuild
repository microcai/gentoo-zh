# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for the cockpit server"
ACCT_USER_ID=501
ACCT_USER_HOME=/var/lib/cockpit
ACCT_USER_HOME_PERMS=0755
ACCT_USER_GROUPS=( cockpit-ws )

acct-user_add_deps
