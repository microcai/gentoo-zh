# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="UTF-8 patchset + TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches/ http://www.tuxonice.net http://blog.chinaunix.net/u/13265/showart.php?id=1008020"
IUSE=""

TUXONICE_SNAPSHOT=""
TUXONICE_VERSION="3.0.1"
TUXONICE_TARGET="${PV}"

if [[ -n "${TUXONICE_SNAPSHOT}" ]]; then
	TUXONICE_SRC="current-tuxonice-for-${TUXONICE_TARGET}.patch-${TUXONICE_SNAPSHOT}"
else
	TUXONICE_SRC="tuxonice-${TUXONICE_VERSION}-for-${TUXONICE_TARGET}.patch"
fi

TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}.bz2"

UTF8_BASE="http://zdbr.net.cn/download"
UTF8_CORE="utf8-kernel-${PV}-core-1.patch.bz2"
UTF8_FONTS="utf8-kernel-${KV_MAJOR}.${KV_MINOR}-fonts-2.patch.bz2"
UTF8_FBCONDECOR="utf8-kernel-${KV_MAJOR}.${KV_MINOR}.28-fbcondecor-1.patch.bz2"

UNIPATCH_LIST="${DISTDIR}/${TUXONICE_SRC}.bz2 ${DISTDIR}/${UTF8_CORE} ${DISTDIR}/${UTF8_FONTS} ${DISTDIR}/${UTF8_FBCONDECOR}"
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI} ${UTF8_BASE}/${UTF8_CORE} ${UTF8_BASE}/${UTF8_FONTS} ${UTF8_BASE}/${UTF8_FBCONDECOR}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
	>=sys-apps/tuxonice-userui-1.0
	>=sys-power/hibernate-script-2.0"

src_unpack() {
	kernel-2_src_unpack
	mv "${S}"/{linux-2.6.29.1,}/drivers/video/console/fonts_utf8.h || die
	rm -Rf "${S}"/linux-2.6.29.1
}

K_EXTRAEINFO="For more info on ${PN} and details on how to report problems, see: ${HOMEPAGE}."
