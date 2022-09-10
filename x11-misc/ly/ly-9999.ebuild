# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"
EGIT_REPO_URI="https://github.com/fairyglade/ly.git"

IUSE="openrc runit systemd"
LICENSE="WTFPL-2"
SLOT="0"

DEPEND="sys-libs/pam
		x11-libs/libxcb
		x11-base/xorg-server
		x11-apps/xauth"
RDEPEND="${DEPEND}
		openrc? ( sys-apps/openrc )
		runit? ( sys-process/runit )
		systemd? ( sys-apps/systemd )"
BDEPEND=""

src_install(){
	default
	use openrc && emake DESTDIR="${D}" install installopenrc
	use runit && emake DESTDIR="${D}" install installrunit
	use systemd && emake DESTDIR="${D}" install installsystemd
}
