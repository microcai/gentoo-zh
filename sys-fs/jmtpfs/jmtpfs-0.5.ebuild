# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A FUSE and libmtp based filesystem for accessing MTP devices."
HOMEPAGE="http://research.jacquette.com/jmtpfs-exchanging-files-between-android-devices-and-linux"
SRC_URI="https://github.com/JasonFerrara/jmtpfs/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse
	media-libs/libmtp"
RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "To mount your MTP device, issue:"
	einfo "    /usr/bin/jmtpfs <mountpoint>"
	echo
	einfo "To unmount your MTP device, issue:"
	einfo "    /usr/bin/fusermount -u <mountpoint>"
}
