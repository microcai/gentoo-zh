# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit eutils

DESCRIPTION="linux QQ"
HOMEPAGE="http://qq.cm \
http://im.qq.com/qq/linux/download.shtml"
SRC_URI="http://dl_dir.qq.com/linuxqq/${PN}_v${PV/_p/-preview}_i386.tar.gz"

LICENSE="Tencent"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="gtk? ( >=x11-libs/gtk+-2.10.8 )"

RDEPEND="${DEPEND}"

src_install() {
einfo "Install packages"
dodir /opt/linuxqq/bin
dodir /opt/linuxqq/icons
for MYFILE in "${WORKDIR}"/*/*; do
einfo "${MYFILE}"
cp "${MYFILE}" "${D}"/opt/linuxqq/bin
done
cp "${FILESDIR}/qq.png" "${D}"/opt/linuxqq/icons/linuxqq.png
make_desktop_entry "qq" "linuxqq" "/opt/linuxqq/icons/linuxqq.png" "Network;InstantMessaging"
exeinto /usr/bin
newexe "${FILESDIR}"/qq.sh qq
}

pkg_postinst() {
ewarn "This package is very experimental version :)"
elog
elog "Please DO NOT report any bugs of linuxqq to Gentoo,"
elog "report them directely to Tencent Inc."
elog
}
