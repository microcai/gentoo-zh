# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( mihomo )
ACCT_USER_HOME="/etc/mihomo"
ACCT_USER_HOME_OWNER="mihomo:mihomo"

acct-user_add_deps
