# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ESVN_REPO_URI="http://kgtp.googlecode.com/svn/trunk"
inherit linux-mod subversion
DESCRIPTION="A realtime and lightweight Linux debugger and tracer."
HOMEPAGE="http://kgtp.googlecode.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	BUILD_TARGETS="default"
	BUILD_PARAMS="KERNELSRC=${KERNEL_DIR}"
	CONFIG_CHECK="MODULES KPROBES DEBUG_FS DEBUG_INFO"

	linux-mod_pkg_setup
	MODULE_NAMES="gtp(extra:${S}:${S})"
}

src_install() {
	linux-mod_src_install || die "failed to install modules"
	dobin getframe getmod putgtprsp getmod.py getgtprsp.pl add-ons/*
	dodoc howto.txt howtocn.txt quickstart.txt
}
