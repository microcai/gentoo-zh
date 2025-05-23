# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for ntpd-rs-observe daemon"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( ntpd-rs-observe )

acct-user_add_deps
