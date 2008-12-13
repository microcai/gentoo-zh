# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic qt4

DESCRIPTION="Linux Fetion, a QT4 IM client using CHINA MOBILE's Fetion Protocol"
HOMEPAGE="http://www.libfetion.cn/"
SRC_URI="http://libfetion-gui.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="dev-libs/openssl
	net-misc/curl
	|| ( ( x11-libs/qt-gui x11-libs/qt-qt3support ) )"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_compile() {
	filter-ldflags -Wl,--as-needed

	use amd64 && sed -i \
		-e "/libfetion_32.a/c    LIBS +=  -lcurl ./lib/libfetion_64.a" \
		-e "/libfetion.a/c    LIBS +=  -lcurl ./lib/libfetion_64.a" \
		${PN}.pro

	# eqmake4 dies on itself.
	eqmake4
	emake || die "emake fail"
}

src_install() {
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm || die "doins failed"
	doins -r skins sound || die "doins failed"

	insinto /usr/share/pixmaps
	doins misc/fetion.png || die "doins failed"

	if use doc ; then
		insinto /usr/share/doc/${PF}
		dohtml APIDocs/html/* || die "dohtml failed"
	fi

	ebegin "Remove empty directories"
		rm -rf $(find "${D}" -name .svn)
	eend $?

	insinto /usr/share/applications
	doins misc/LibFetion.desktop || die "failed to install desktop entry"

	dobin ${PN} || die "dobin failed"
}

pkg_postinst() {
	echo
	elog "Try to remove your user configuration file in home"
	elog "directory (~/.libfeion.conf) if you were experiencing"
	elog "some problem with Linux Fetion GUI."
	echo
}
