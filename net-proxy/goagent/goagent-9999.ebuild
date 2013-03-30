# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="5"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/goagent/goagent.git"
	EGIT_BRANCH="2.0"
	KEYWORDS=""
	GOAGENT_SRC_URI=""
	GOAGENT_ECLASS="git-2"
else
	GOAGENT_SRC_URI="https://github.com/goagent/goagent/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	GOAGENT_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

inherit ${GOAGENT_ECLASS}

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="https://github.com/goagent/goagent"
SRC_URI="${GOAGENT_SRC_URI}"

LICENSE="GPL-3"
SLOT="2.1"
IUSE=""

RDEPEND="dev-lang/python:2.7[ssl]
	dev-python/gevent
	dev-python/pyopenssl"

src_unpack() {
	${GOAGENT_ECLASS}_src_unpack
}

src_prepare() {
	find ${S}/local -type f -name *.py \
	-exec sed -i -re "1s/python2?/python2/" {} \; || die "Failed to sed"
}

src_install() {
	insinto "/etc/"
	newins "${S}/local/proxy.ini" goagent
	rm ${S}/*/*.{bat,exe,vbs,dll,manifest,ini} || die

	insinto "/opt/goagent"
	doins -r "${S}/local" "${S}/server"

	newinitd "${FILESDIR}/goagent-initd" goagent
	dosym /etc/goagent "/opt/goagent/local/proxy.ini"
}

pkg_postinst() {
	elog
	elog "config file: /etc/goagent"
	elog "init script: /etc/init.d/goagent"
	elog
	elog "Usage:"
	elog "vim /etc/goagent"
	elog "cd /opt/goagent/server"
	elog "upload={golang|python|php} python2.7 uploader.zip"
	elog "/etc/init.d/goagent start|stop|restart"
	elog
	elog "if you get some error in the uploading,"
	elog "please upload through other proxy."
	elog "e.g. 'export https_proxy=127.0.0.1:8087',"
	elog "and then upload again."
	elog
}
