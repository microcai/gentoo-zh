# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

inherit git-2

DESCRIPTION="A GAE proxy forked from gappproxy/wallproxy"
HOMEPAGE="https://github.com/phus/goagent"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""
EGIT_REPO_URI="git://github.com/phus/goagent.git"
EGIT_BRANCH="1.0"

RDEPEND="dev-lang/python:2.7[ssl]"

src_prepare() {
	find . -type f -name *.py \
	-exec sed -i -re "1s/python2?/python2/" {} \; || die "Failed to sed"
}

src_install() {
	insinto "/etc/"
	newins "${S}/local/proxy.ini" goagent
	rm "${S}/local/proxy.ini"

	insinto "/opt/goagent"
	doins -r "${S}"/local "${S}"/server

	newinitd "${FILESDIR}"/goagent-initd goagent
	dosym /etc/goagent "/opt/goagent/local/proxy.ini"
}

pkg_postinst() {
	elog
	elog "config file: /etc/goagent"
	elog "init script: /etc/init.d/goagent"
	elog
	elog "Usage:"
	elog "vim /etc/goagent"
	elog "vim /opt/goagent/server/golang/fetch/fetch.go"
	elog "vim /opt/goagent/server/golang/app.yaml"
	elog "cd /opt/goagent/server/golang"
	elog "python2 appcfg.zip update ./"
	elog "/etc/init.d/goagent start|stop|restart"
}
