# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="DBDesigner 4 is a visual database design system that integrates database design, modeling, creation and maintenance."
HOMEPAGE="http://www.fabforce.net/dbdesigner4/"
SRC_URI="http://fabforce.net/downloads/DBDesigner${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND="x11-libs/qt
	sys-libs/lib-compat"
RDEPEND="x11-libs/kylixlibs3-borqt"

MY_PN="DBDesigner4"
S=${WORKDIR}/${MY_PN}
INSTALLDIR=/opt/${MY_PN}

pkg_setup() {
	ewarn
	ewarn "Note that I might not have all the dependencies worked"
	ewarn "out.  If you have problems, file a report at"
	ewarn "http://bugs.gentoo.org and assign them to allanonjl@gentoo.org"
	ewarn
}

src_install() {
	epatch ${FILESDIR}/add-kylix.patch

	dodir ${INSTALLDIR}
	cp -pPR ${S}/* ${D}/${INSTALLDIR}

	cd ${D}/${INSTALLDIR}/Linuxlib
	ln -s bplrtl.so.6.9.0 bplrtl.so.6.9
	ln -s dbxres.en.1.0 dbxres.en.1
	ln -s libmidas.so.1.0 libmidas.so.1
	ln -s libmysqlclient.so.10.0.0 libmysqlclient.so
	ln -s libborqt-6.9.0-qt2.3.so libqt.so.2
	ln -s libqtintf-6.9.0-qt2.3.so libqtintf-6.9-qt2.3.so
	ln -s libsqlmy23.so.1.0 libsqlmy23.so
	ln -s libsqlmy23.so libsqlmy.so
	ln -s libsqlora.so.1.0 libsqlora.so
	ln -s libDbxSQLite.so.2.8.5 libDbxSQLite.so
	ln -s liblcms.so.1.0.9 liblcms.so
	ln -s libpng.so.2.1.0.12 libpng.so.2
	ln -s libstdc++.so.5.0.0 libstdc++.so.5

	exeinto /usr/bin
	doexe ${S}/startdbd
}

pkg_postinst() {
	einfo
	einfo "To start DBDesigner4, run 'startdbd'"
	einfo
}
