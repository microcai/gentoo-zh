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
# only tested x86 and amd64 with multilib
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=x11-libs/gtk+-2.10.8"

S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

pkg_setup() {
	if use amd64; then
		if ! built_with_use "sys-devel/gcc" multilib; then
			ewarn
			ewarn "You are under amd64, to use linuxqq,"
			ewarn "you need sys-devel/gcc (Change USE: +multilib)"
			ewarn
			epause 5
			die
		fi
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
