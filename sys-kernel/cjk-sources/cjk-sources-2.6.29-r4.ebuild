# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="UTF-8 CJK characters patchset sources based on tuxonice-sources"
HOMEPAGE="http://blog.chinaunix.net/u/13265/showart.php?id=1008020 http://dev.gentoo.org/~dsd/genpatches/ http://www.tuxonice.net"
IUSE=""

TUXONICE_VERSION="3.0.1"
TUXONICE_TARGET="2.6.29"
TUXONICE_SRC="tuxonice-${TUXONICE_VERSION}-for-${TUXONICE_TARGET}.patch"
TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}.bz2"

UTF8_BASE="http://zdbr.net.cn/download"
UTF8_CORE="utf8-kernel-2.6.29-core-1.patch.bz2"
UTF8_FONTS="utf8-kernel-2.6-fonts-2.patch.bz2"
UTF8_FBCONDECOR="utf8-kernel-2.6.28-fbcondecor-1.patch.bz2"
UTF8_URI="${UTF8_BASE}/${UTF8_CORE} ${UTF8_BASE}/${UTF8_FONTS} ${UTF8_BASE}/${UTF8_FBCONDECOR}"

UNIPATCH_LIST="${DISTDIR}/${TUXONICE_SRC}.bz2 ${DISTDIR}/${UTF8_CORE} ${DISTDIR}/${UTF8_FONTS} ${DISTDIR}/${UTF8_FBCONDECOR}"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI} ${UTF8_URI}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
		>=sys-apps/tuxonice-userui-1.0
		>=sys-power/hibernate-script-2.0"

K_EXTRAELOG="If there are issues with this kernel, please direct any
queries to the tuxonice-users mailing list:
http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"

src_install(){
	mv "${S}"/{linux-2.6.29.1,}/drivers/video/console/fonts_utf8.h || die
	rm -Rf "${S}"/linux-2.6.29.1
	kernel-2_src_install
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
