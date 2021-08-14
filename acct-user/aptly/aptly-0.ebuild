# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( aptly )
ACCT_USER_HOME="/var/lib/aptly"
ACCT_USER_HOME_OWNER="aptly:aptly"

acct-user_add_deps
