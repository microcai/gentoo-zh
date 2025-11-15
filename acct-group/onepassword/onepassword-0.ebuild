# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-group

# Note: acct-group uses 'groupadd --system' which assigns GID < 1000
# However, 1Password browser extension requires GID >= 1000
# See: https://github.com/jaredallard/overlay/commit/82c89af80d804e29b8e899b9b710d892a81e713a#diff-95022fe9fe6c216d7e0d8c8454d45699da0904e13a1c8c14e9bd1f95559feb4bR19-R21
# Users should override this in /etc/portage/make.conf:
#   ACCT_GROUP_ONEPASSWORD_ID=1010
# Or any value >= 1000 and not conflicting with existing groups
ACCT_GROUP_ID=-1
