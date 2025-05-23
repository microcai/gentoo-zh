# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( n2n )
ACCT_USER_HOME="/var/log/n2n"
ACCT_USER_HOME_OWNER="n2n:n2n"

acct-user_add_deps
