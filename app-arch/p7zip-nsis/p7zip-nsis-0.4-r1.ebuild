# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A binary version of p7zip to decompress nsis. Latest version of p7zip doesn't decompress some nsis."
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="http://gentoo.org.cn/distfiles/p7zip-nsis-0.4.tar.xz"
RESTRICT="mirror"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	chmod 755 7z-nsis
	dodir /opt/p7zip-nsis/
	cp -R . "${D}/opt/p7zip-nsis/" || die "Install failed"

	exeinto /usr/bin/
	newexe "${FILESDIR}/7z-nsis" 7z-nsis
}
