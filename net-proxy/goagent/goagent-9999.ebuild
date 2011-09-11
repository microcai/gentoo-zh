# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="2"

inherit git

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
	insinto "/opt/goagent/server"
	doins "${S}"/server/*

	insinto "/opt/goagent/local"
	doins "${S}"/local/*

	insinto "/opt/goagent/local/certs"
	doins "${S}"/local/certs/*

	newinitd "${FILESDIR}"/goagent-initd goagent
	dosym "/opt/goagent/local/proxy.ini" /etc/goagent
}

pkg_postinst() {
	elog
	elog "config file: /etc/goagent"
	elog "init script: /etc/init.d/goagent"
	elog "Usage:"
	elog "sudo vim /etc/goagent"
	elog "sudo vim /opt/goagent/server/fetch.py"
	elog "sudo python2 /opt/goagent/server/uploader.py"
	elog "sudo /etc/init.d/goagent start|stop|restart"
}
