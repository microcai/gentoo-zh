# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=7

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/goagent/goagent.git"
	EGIT_BRANCH="3.0"
	KEYWORDS=""
	GOAGENT_SRC_URI=""
	GOAGENT_ECLASS="git-r3"
else
	GOAGENT_SRC_URI="https://github.com/goagent/goagent/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	GOAGENT_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ssl(+)"
inherit ${GOAGENT_ECLASS} fdo-mime python-single-r1 systemd

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="https://github.com/goagent/goagent"
SRC_URI="${GOAGENT_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
IUSE="+gtk systemd"

RDEPEND="${PYTHON_DEPS}
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/pygeoip[${PYTHON_USEDEP}]
	dev-libs/nss[utils]
	>=dev-python/gevent-1.0[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	gtk? ( x11-libs/vte:0[python,${PYTHON_USEDEP}] )
	net-libs/pacparser"

src_unpack() {
	${GOAGENT_ECLASS}_src_unpack
}

src_prepare() {
	if use gtk ; then
		python_convert_shebangs -r 2 ${S}/local/goagent-gtk.py
	else
		rm ${S}/local/goagent-gtk.py || die
	fi

	#sed -e "s|^#!/usr/bin/env python|#!/usr/bin/env python2|" \
	#	-e 's|^    geoip = .*)\( if.*\)$|    geoip = pygeoip.GeoIP("/usr/share/GeoIP/GeoIP.dat")\1|' \
	#	-i ${S}/local/proxy.py
}

src_install() {
	insinto "/etc/"
	newins "${FILESDIR}/goagent" goagent
	rm ${S}/*/*.{bat,exe,js,dll,manifest,command} || die
	rm ${S}/local/python27.zip || die

	if use gtk ; then
		exeinto "/usr/bin"
		exeopts -m0755
		doexe "${FILESDIR}/goagent-gtk"

		insinto "/usr/share/applications"
		doins "${FILESDIR}/goagent-gtk.desktop"

		insinto "/usr/share/pixmaps"
		doins "${FILESDIR}/goagent-logo.png"

		dosym /usr/share/pixmaps/goagent-logo.png \
		"/opt/goagent/local/goagent-logo.png"
	fi

	dosym /etc/goagent "/opt/goagent/local/proxy.user.ini"

	insinto "/opt/goagent"
	doins -r "${S}/local" "${S}/server"

	newinitd "${FILESDIR}/goagent-initd" goagent
	use systemd && systemd_dounit "${FILESDIR}/goagent.service"
}

#pkg_prerm() {
#	find ${ROOT}/opt/goagent/local/certs/ -type f -exec rm {} + || die
#}

pkg_postinst() {
	use gtk && fdo-mime_desktop_database_update

	elog
	elog "config file: /etc/goagent"
	elog "init script: /etc/init.d/goagent"
	elog
	if use gtk; then
		elog "Usage:"
		elog "goagent-gtk"
	else
		elog "Usage:"
		elog "vim /etc/goagent"
		elog "cd /opt/goagent/server"
		elog "upload={golang|python|php} python2.7 uploader.zip"
		elog "/etc/init.d/goagent start|stop|restart"
	fi
	elog
	elog "if you get some error in the uploading,"
	elog "please upload through other proxy."
	elog "e.g. 'export https_proxy=127.0.0.1:8087',"
	elog "and then upload again."
	elog
}

pkg_postrm() {
	use gtk && fdo-mime_desktop_database_update
}
