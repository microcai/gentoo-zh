# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Systemd service for automatic ZFS zpool scrubbing"
HOMEPAGE="https://github.com/lnicola/systemd-zpool-scrub"
SRC_URI=""

EGIT_REPO_URI="https://github.com/lnicola/systemd-zpool-scrub.git"

inherit git-r3 systemd

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 arm64 arm mips"

DEPEND=""
RDEPEND="sys-fs/zfs"
BDEPEND=""

src_install(){
    systemd_dounit zpool-scrub@.service
    systemd_dounit zpool-scrub@.timer
}