# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( clash-meta )
ACCT_USER_HOME="/etc/Clash-Meta"
ACCT_USER_HOME_OWNER="clash-meta:clash-meta"

acct-user_add_deps
