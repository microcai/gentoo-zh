# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group

# 1Password browser integration requires this GID to be >= GID_MIN.
# Explicitly assign a GID to ensure it doesn’t get allocated as a system GID.
ACCT_GROUP_ID=26753
# Since the previous ACCT_GROUP_ID=-1 does not meet the browser integration
# requirements, the old group needs to be removed with "groupdel onepassword"
# and then rerun emerge.
ACCT_GROUP_ENFORCE_ID=yes
