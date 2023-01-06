# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( aptly )
ACCT_USER_HOME="/var/lib/aptly"
ACCT_USER_HOME_OWNER="aptly:aptly"

acct-user_add_deps
