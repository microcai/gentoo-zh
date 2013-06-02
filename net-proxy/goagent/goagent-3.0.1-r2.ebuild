# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="5"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/goagent/goagent.git"
	EGIT_BRANCH="3.0"
	KEYWORDS=""
	GOAGENT_SRC_URI=""
	GOAGENT_ECLASS="git-2"
else
	GOAGENT_SRC_URI="https://github.com/goagent/goagent/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	GOAGENT_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

inherit ${GOAGENT_ECLASS} fdo-mime

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="https://github.com/goagent/goagent"
SRC_URI="${GOAGENT_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-lang/python:3.3[ssl]
	dev-libs/nss[utils]
	dev-python/gevent
	dev-python/pyopenssl
	x11-libs/vte:0[python]"

src_unpack() {
	${GOAGENT_ECLASS}_src_unpack
}

src_prepare() {
#	find ${S}/local -type f -name *.py \
#	-exec sed -i -re "1s/python2?/python2/" {} \; || die "Failed to sed"
	sed -i -re "1s/python2?/python2/" local/goagent-gtk.py || die "Failed to sed"
}

src_install() {
	insinto "/etc/"
	newins "${S}/local/proxy.ini" goagent
	rm ${S}/*/*.{bat,exe,vbs,dll,ini} || die

	exeinto "/usr/bin"
	exeopts -m0755
	doexe "${FILESDIR}/goagent-gtk"

	insinto "/usr/share/applications"
	doins "${FILESDIR}/goagent-gtk.desktop"

	cp -rf ${FILESDIR}/goagent-logo.png ${S}/local/ || die

	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/goagent-logo.png"

#	newinitd "${FILESDIR}/goagent-initd" goagent
	dosym /etc/goagent "/opt/goagent/local/proxy.ini"

	insinto "/opt/goagent"
	doins -r "${S}/local" "${S}/server"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog
	elog "config file: /etc/goagent"
	elog
	elog "Usage:"
	elog "goagent-gtk"
	elog
	elog "if you get some error in the uploading,"
	elog "please upload through other proxy."
	elog "e.g. 'export https_proxy=127.0.0.1:8087',"
	elog "and then upload again."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
