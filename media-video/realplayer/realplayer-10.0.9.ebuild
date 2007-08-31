# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit nsplugins eutils

MY_PN="RealPlayer"
MY_SOURCE=realplay-${PV}-source
DESCRIPTION="Real Media Player built from source"
HOMEPAGE="http://www.helixplayer.org/"
SRC_URI="https://helixcommunity.org/frs/download.php/2480/realplay-10.0.9-source.tar.bz2
	amd64? ( http://gentoo-china-overlay.googlecode.com/svn/distfiles/realplay_gtk_current-20060824-dist_linux-2.6-glibc23-amd64.zip )"
LICENSE="HBRL"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="X alsa cjk nptl nsplugin"
DEPEND="media-libs/libvorbis
		media-libs/libtheora"
RDEPEND="${DEPEND}
		!amd64? (
			X? ( >=dev-libs/glib-2
				>=x11-libs/pango-1.2
				>=x11-libs/gtk+-2.2 )
			=virtual/libstdc++-3.3*
		)
		amd64? (
			X? ( app-emulation/emul-linux-x86-gtklibs )
			app-emulation/emul-linux-x86-compat
		)"
RESTRICT="strip nomirror test"

QA_TEXTRELS="opt/RealPlayer/codecs/raac.so
	opt/RealPlayer/codecs/cvt1.so
	opt/RealPlayer/codecs/colorcvt.so
	opt/RealPlayer/codecs/drv2.so
	opt/RealPlayer/codecs/drvc.so
	opt/RealPlayer/plugins/theorarend.so
	opt/RealPlayer/plugins/vorbisrend.so
	opt/RealPlayer/plugins/swfrender.so
	opt/RealPlayer/plugins/vidsite.so
	opt/RealPlayer/plugins/oggfformat.so"

S=${WORKDIR}/realplay-${PV}

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
	keepdir /opt/${MY_PN}
	mkdir ${S}/${MY_PN}
	tar jxf ${S}/release/realplayer.tar.bz2 -C ${S}/${MY_PN}
	cd ${S}/${MY_PN}

	fperms 644 codecs/*
	insinto /opt/${MY_PN}/codecs
	doins codecs/*
	for x in drvc drv2 atrc sipr; do
		dosym ${x}.so /opt/${MY_PN}/codecs/${x}.so.6.0
	done

	dodoc README
	dohtml share/hxplay_help.html share/tigris.css

	if use X; then
		for x in common lib mozilla plugins postinst realplay realplay.bin share; do
			mv $x ${D}/opt/${MY_PN}
		done;

		dodir /usr/bin
		dosym /opt/${MY_PN}/realplay /usr/bin/realplay

		cd ${D}/opt/${MY_PN}/share
		domenu realplay.desktop

		for res in 16 192 32 48; do
			insinto /usr/share/icons/hicolor/${res}x${res}/apps
			newins icons/realplay_${res}x${res}.png \
					realplay.png
		done

		# mozilla plugin
		if use nsplugin ; then
			cd ${D}/opt/${MY_PN}/mozilla
			exeinto /opt/netscape/plugins
			doexe nphelix.so
			inst_plugin /opt/netscape/plugins/nphelix.so

			insinto /opt/netscape/plugins
			doins nphelix.xpt
			inst_plugin /opt/netscape/plugins/nphelix.xpt
		fi

		# Language resources
		cd ${D}/opt/RealPlayer/share/locale
		for LC in *; do
			mkdir -p ${D}/usr/share/locale/${LC}/LC_MESSAGES
			dosym /opt/RealPlayer/share/locale/${LC}/player.mo /usr/share/locale/${LC}/LC_MESSAGES/realplay.mo
			dosym /opt/RealPlayer/share/locale/${LC}/widget.mo /usr/share/locale/${LC}/LC_MESSAGES/libgtkhx.mo
		done
	fi
}
