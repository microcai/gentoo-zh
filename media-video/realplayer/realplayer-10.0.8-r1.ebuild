# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit nsplugins eutils

MY_SOURCE=realplay-${PV}-source
DESCRIPTION="Real Media Player built from source"
HOMEPAGE="http://www.helixplayer.org/"
SRC_URI="https://helixcommunity.org/frs/download.php/2153/realplay-10.0.8-source.tar.bz2
	amd64? ( http://gentoo-china-overlay.googlecode.com/svn/distfiles/realplay_gtk_current-20060824-dist_linux-2.6-glibc23-amd64.zip )"
LICENSE="GPL-2"
SLOT="0"
# -sparc -amd64: 1.0_beta1: build fails on both platforms... --eradicator
KEYWORDS="-* ~x86 ~amd64 -sparc"
IUSE="mozilla nptl cjk alsa"
RDEPEND=">=dev-libs/glib-2
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2
	alsa? ( >=media-libs/alsa-oss-1.0 )"
DEPEND="${RDEPEND}
	media-libs/libtheora
	media-libs/libogg"

RESTRICT="primaryuri"

# Had to change the source directory because of this somewhat
# non-standard naming convention
S=${WORKDIR}/realplay-${PV}

pkg_nofetch() {
	einfo "Please download"
	einfo " - ${MY_SOURCE}/.tar.bz2"
	einfo " from ${SRC_URI}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	
	if use x86; then
		cp -ru distribution/linux-2.2-libc6-gcc32-i586/* .
	elif use amd64; then
		cp -ru ../distribution .
		cp -ru distribution/linux-2.6-glibc23-amd64/* .
	fi

	#adjust strange naming for helixplayer tarball
	epatch ${FILESDIR}/installer-naming.patch

	#fixes the .bif file to create a gentoo_player custom target
	#epatch ${FILESDIR}/${P}-bif.patch

	#fixes sem_t based issues
	use nptl && epatch ${FILESDIR}/${PN}-10.0.4-sem_t.patch
	
	#fixes cjk issues
	use cjk && epatch ${FILESDIR}/realplayer-10.0.4-cjk-hack.patch

	#dirty hack,, use alsa oss emulation
	use alsa && epatch ${FILESDIR}/realplayer-10.0.4-oss-use-aoss.patch
	
	#disable asm code ...
	epatch ${FILESDIR}/realplayer-10.0.4-disable-asm.patch

	#gcc4 fixes
	epatch ${FILESDIR}/realplayer-10.0.4-sysinfo-gcc4-i586-fix.patch
	epatch ${FILESDIR}/realplayer-10.0.5-gcc4-fix.patch
	
	#fixes icon name in .desktop file
	sed -i -e 's:realplay.png:realplay:' ${S}/player/installer/common/realplay.desktop
}

src_compile() {

	#copies our buildrc file over with information on where
	#ogg and theora libs are kept
	cp ${FILESDIR}/buildrc ${S}

	export BUILDRC="${S}/buildrc"
	export BUILD_ROOT="${S}/build"

	# FIXME: how to handle CFLAGS, CXXFLAGS, LDFLAGS? unset them for safety
	unset CFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	#now we can begin the build
	${S}/build/bin/build.py -m realplay_gtk_release -t release -k -p green -P helix-client-all-defines player_all || die
}

src_install() {
	# install the tarballed installation into 
	# the /opt directory
	keepdir /opt/RealPlayer
	tar -jxf ${S}/release/realplayer.tar.bz2 -C ${D}/opt/RealPlayer

	if use mozilla ; then
		cd ${D}/opt/RealPlayer/mozilla
		exeinto /opt/netscape/plugins
		doexe nphelix.so
		inst_plugin /opt/netscape/plugins/nphelix.so
	fi

	doenvd ${FILESDIR}/50realplay

	for res in 16 192 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins ${S}/player/app/gtk/res/icons/realplay/realplay_${res}x${res}.png \
				realplay.png
	done
	# Remove setup script as it's dangerous, and the directory if it's empty
	#rm -rf ${D}/opt/RealPlayer/Bin/setup
	rm -fr ${D}/opt/RealPlayer/Bin
	
	# Language resources
	cd ${D}/opt/RealPlayer/share/locale
	for LC in *; do
		dodir /usr/share/locale/${LC}/LC_MESSAGES
		dosym /opt/RealPlayer/share/locale/${LC}/player.mo /usr/share/locale/${LC}/LC_MESSAGES/realplay.mo
		dosym /opt/RealPlayer/share/locale/${LC}/widget.mo /usr/share/locale/${LC}/LC_MESSAGES/libgtkhx.mo
	done
										
	dosym /opt/RealPlayer/realplay /usr/bin/realplay
	doicon ${D}/opt/RealPlayer/share/realplay.png
	domenu ${D}/opt/RealPlayer/share/realplay.desktop
}

