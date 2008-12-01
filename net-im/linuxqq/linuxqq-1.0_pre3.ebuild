# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

MY_P=${PN}_v${PV/_pre/-preview}_i386
DESCRIPTION="Tencent QQ for Linux"
HOMEPAGE="http://im.qq.com/qq/linux"
SRC_URI="http://dl_dir.qq.com/linuxqq/${MY_P}.tar.gz"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64" # only works on amd64/x86 platform
IUSE=""

# FIXME: dependency. We have no amd64 env. still missing something here?
# http://www.gentoo.org/proj/en/base/amd64/emul/content.xml
DEPEND=""
RDEPEND="x86? ( >=x11-libs/gtk+-2.10.8 )
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
		app-emulation/emul-linux-x86-compat
	)"

S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

pkg_setup() {
	# x86 binary package, we need multilib
	# FIXME:
	# multilib profile should always have mutlilib USE flag ON,
	# so we can safely get rid of multilib USE flag check here?
	if use amd64 && ! has_multilib_profile ; then
		eerror "We need multilib profile to run Tencent QQ client!"
		die "We need multilib profile to run Tencent QQ client!"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	cat << DONE > qq.sh
#!/bin/bash
# for launch qq from every directory
pushd /opt/linuxqq/bin > /dev/null
./qq &
popd > /dev/null
DONE
}

src_install() {
	ebegin "Installing package"
		insinto /opt/${PN}/bin
		doins qq res.db || die "doins failed"
	eend $?

	ebegin "Installing icon, menu entry and launch script"
		insinto /opt/${PN}/icons
		doins "${FILESDIR}"/linuxqq.png || die "doins failed"
		insinto /usr/share/applications
		doins "${FILESDIR}"/linuxqq.desktop || die "doins failed"
		newbin qq.sh qq || die "newbin failed"
	eend $?

	ebegin "Fixing file permissions"
		fperms a+x /opt/${PN}/bin/qq || die "fperms failed"
	eend $?
}

pkg_postinst() {
	ewarn "This package is very experimental."
	echo
	elog "Please report your bugs to:"
	elog "http://support.qq.com/beta2/simple/index.html?fid=361"
	echo
}
