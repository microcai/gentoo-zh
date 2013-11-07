# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="5"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/wallproxy/wallproxy.git"
	EGIT_BRANCH="${EGIT_MASTER}" 
	KEYWORDS=""
	WALLPROXY_SRC_URI=""
	WALLPROXY_ECLASS="git-2"
else
	WALLPROXY_SRC_URI="https://github.com/wallproxy/wallproxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	WALLPROXY_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

PYTHON_DEPEND="2"
PYTHON_USE_WITH="ssl"

inherit ${WALLPROXY_ECLASS} python systemd

DESCRIPTION="New version of wallproxy, a general purpose proxy framework in Python."
HOMEPAGE="https://github.com/wallproxy/wallproxy"
SRC_URI="${WALLPROXY_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/nss[utils]
	dev-python/gevent
	dev-python/pyopenssl"

src_unpack() {
	${WALLPROXY_ECLASS}_src_unpack
}

src_prepare() {
	python_convert_shebangs -r 2 ${S}/local/startup.py
}

src_install() {
	insinto "/etc/"
	newins "${S}/local/proxy.ini" "wallproxy.conf"

	rm "${S}/local/proxy.ini" || die
	rm -f ${S}/*/*.{bat,exe,dll,doc}

	insinto "/opt/wallproxy"
	doins -r "${S}/local" "${S}/server"

	exeinto "/usr/bin"
	doexe "${FILESDIR}/wallproxy"
	doexe "${FILESDIR}/wallproxy-uploader"

	newinitd "${FILESDIR}/wallproxy.init" "wallproxy"
	systemd_dounit "${FILESDIR}"/${PN}.service

	chmod 755 "${D}/opt/wallproxy/local/startup.py" || die
	chmod 755 "${D}/opt/wallproxy/server/uploader.py" || die

	dosym "/etc/wallproxy.conf" "/opt/wallproxy/local/proxy.ini"
}

pkg_postinst() {
	elog
	elog "Configuration:"
	elog "    /etc/wallproxy.conf"
	elog
	elog "Usage:"
	elog "    wallproxy"
	elog "        Start a wallproxy daemon manually."
	elog
	elog "    wallproxy-uploader"
	elog "        Uploader wallproxy server to GAE."
	elog "        Use it at the first time or after a major upgrade."
	elog "        Notice that wallproxy server is NOT compatible with goagent."
	elog
	elog "    /etc/init.d/wallproxy"
	elog "        An OpenRC script so that you can launch wallproxy automatically."
	elog
	elog "For https cerfiticate error, please import /opt/wallproxy/local/CA.crt"
	elog "to your broswer"
}
