# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for reframe"
ACCT_USER_ID="947"
ACCT_USER_GROUPS=( "reframe" )

acct-user_add_deps
