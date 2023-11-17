# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-vm-2

MY_PV=${PV/./u}
SLOT=$(ver_cut 1)

SRC_URI="jdk-${MY_PV}-linux-x64.tar.gz"

DESCRIPTION="Oracle's Java SE Development Kit"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
LICENSE="OTN"
KEYWORDS="~amd64"
IUSE="alsa cups headless-awt selinux +source"
QA_PREBUILT="*"

RDEPEND="
	>=sys-apps/baselayout-java-0.1.0-r1
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/harfbuzz
	elibc_glibc? ( >=sys-libs/glibc-2.2.5:* )
	elibc_musl? ( sys-libs/musl )
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	selinux? ( sec-policy/selinux-java )
	!headless-awt? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXtst
	)"

pkg_nofetch() {
	einfo "############################################################################## "
	einfo "# Portage can not download JDK tar file directly from Oracle's website	# "
	einfo "# Please download it manually to your distfiles directory			# "
	einfo "# Distfile directory is '/var/cache/distfile' by default			# "
	einfo "# Please download 'x64 Compressed Archive' file from following url:		# "
	einfo "# https://www.oracle.com/java/technologies/downloads/#java8-linux		# "
	einfo "# If the above mentioned URL does not point to the correct version anymore,	# "
	einfo "# please download the file from Oracle's Java download archive		# "
	einfo "############################################################################## "
	einfo "# Potage没法直接从甲骨文官网下载jdk压缩包文件"
	einfo "# 请仔细读上述提示！！"
}

RESTRICT="preserve-libs splitdebug mirror"
QA_PREBUILT="*"

S="${WORKDIR}/jdk1.8.0_${PV/8./}"

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest#/}"
	# Notion:
	# There is a libav*.so* related problem not yet get fixed
	# Maybe downgrading ffmpeg version can resolve this,or maybe should wait for Oracle to make
	# jdk use high versioned .so stuff.
	rm COPYRIGHT LICENSE README.html THIRDPARTYLICENSEREADME-JAVAFX.txt THIRDPARTYLICENSEREADME.txt || die

	if ! use alsa ; then
		rm -v jre/lib/*/libjsoundalsa.so* || die
	fi

	if use headless-awt ; then
		rm -fvr {,jre/}lib/*/lib*{[jx]awt,splashscreen}* \
			{,jre/}bin/policytool bin/appletviewer || die
	fi

	if ! use source ; then
		rm -v src.zip javafx-src.zip || die
	fi

	rm -v jre/lib/security/cacerts || die
	dosym ../../../../../etc/ssl/certs/java/cacerts \
		"${dest}"/jre/lib/security/cacerts

	dodir "${dest}"
	cp -pPR * "${ddest}" || die

	# provide stable symlink
	dosym "${P}" "/opt/${PN}-${SLOT}"

	java-vm_install-env "${FILESDIR}"/"${PN}"-"${SLOT}".env.sh
	java-vm_set-pax-markings "${ddest}"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

pkg_postinst() {
	java-vm-2_pkg_postinst
}
