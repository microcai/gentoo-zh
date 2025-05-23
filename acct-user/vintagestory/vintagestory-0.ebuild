# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for Vintage Story Server"
ACCT_USER_ID=-1
#ACCT_USER_HOME=/var/lib/vintagestory/home
ACCT_USER_GROUPS=( vintagestory )

acct-user_add_deps
