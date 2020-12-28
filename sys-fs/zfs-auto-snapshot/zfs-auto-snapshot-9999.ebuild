# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-9999.ebuild,v 1.5 2011/05/03 11:32:59 scarabeus Exp $

# Maintainer: check IUSE-defaults at DefineOptions.cmake

EAPI=7

inherit eutils git-r3

DESCRIPTION="An alternative implementation of the zfs-auto-snapshot service for Linux"
HOMEPAGE="https://github.com/zfsonlinux/zfs-auto-snapshot"
EGIT_REPO_URI="https://github.com/zfsonlinux/zfs-auto-snapshot.git"

LICENSE="GPL-2"
KEYWORDS="amd64"
SLOT="0"
IUSE=""

DEPEND="sys-fs/zfs"
RDEPEND="${DEPEND}"

#DOCS=( AUTHORS README ChangeLog )

src_prepare() {
	# just install the examples do not compile them
	einfo "prepare do nothing"
}

src_configure() {
	einfo "configure do nothing"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	chmod -x ${D}/etc/cron.d/zfs-auto-snapshot
}

pkg_postinst() {
    elog "use properties com.sun:auto-snapshot:[true/false] to make snapshot for zfs"
    elog ""
    elog "for detail pls visit http://docs.oracle.com/cd/E19082-01/817-2271/ghzuk/"
}
