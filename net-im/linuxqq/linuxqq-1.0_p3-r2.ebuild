# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${PN}_v${PV/_p/-preview}_i386
DESCRIPTION="linux QQ"
HOMEPAGE="http://im.qq.com/qq/linux"
SRC_URI="http://dl_dir.qq.com/linuxqq/${MY_P}.tar.gz"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~x86" # only x86 works? we could use "-* ~x86" here?
IUSE=""

DEPEND=""
RDEPEND=">=x11-libs/gtk+-2.10.8"

S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

pkg_setup() {
	# message from Yu Yuwei <acevery++>
	if use amd64 ; then
		einfo "We haven't test whether amd64 can use linuxqq."
		einfo "If you have test it, please report back."
		epause 5
	fi
}

src_install() {
	ebegin "Installing package"
		insinto /opt/${PN}/bin
		doins * || die "doins failed"
	eend $?

	insinto /opt/${PN}/icons
	newins "${FILESDIR}"/qq.png linuxqq.png || die "newins failed"
	insinto /usr/share/applications
	newins "${FILESDIR}"/qq.desktop linuxqq.desktop || die "newins failed"
	# t?e?n_cent ?= ten cent...比M$还$
	exeinto /usr/bin
	newexe "${FILESDIR}"/qq.sh qq || die "newexe failed"

	ebegin "Fixing file permission"
		fperms a+x /opt/${PN}/bin/qq || die "fperms failed"
	eend $?
}

pkg_postinst() {
	ewarn "This package is very experimental."
	echo
	elog "Please DO NOT report any bugs of linuxqq to Gentoo,"
	elog "report them directely to Tencent Inc."
	echo
}
