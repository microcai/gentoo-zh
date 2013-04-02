# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs flag-o-matic multilib base git-2

DESCRIPTION="Video player based on MPlayer/mplayer2"
HOMEPAGE="https://github.com/mpv-player/mpv/"
EGIT_REPO_URI="git://github.com/mpv-player/mpv.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"

IUSE="+alsa aqua bluray bs2b cddb +cdio debug +dts dvb dvd +enca encode fbcon ftp
+iconv ipv6 jack joystick jpeg kernel_linux ladspa lcms +libass libcaca lirc mng mp3
network openal opengl oss portaudio +postproc pulseaudio pvr quvi radio samba +shm
v4l vcd vdpau +X xinerama xscreensaver xv"

REQUIRED_USE="
	cddb? ( cdio network )
	lcms? ( opengl )
	libass? ( iconv )
	opengl? ( || ( aqua X ) )
	radio? ( || ( dvb v4l ) )
	vdpau? ( X )
	xinerama? ( X )
	xscreensaver? ( X )
	xv? ( X )
"

RDEPEND+="
	sys-libs/ncurses
	sys-libs/zlib
	X? (
		x11-libs/libXext
		x11-libs/libXxf86vm
		opengl? ( virtual/opengl )
		lcms? ( media-libs/lcms:2 )
		vdpau? ( x11-libs/libvdpau )
		xinerama? ( x11-libs/libXinerama )
		xscreensaver? ( x11-libs/libXScrnSaver )
		xv? (
			x11-libs/libXv
		)
	)
	alsa? ( media-libs/alsa-lib )
	bluray? ( media-libs/libbluray )
	bs2b? ( media-libs/libbs2b )
	cdio? ( dev-libs/libcdio )
	dvb? ( virtual/linuxtv-dvb-headers )
	dvd? (
		>=media-libs/libdvdread-4.1.3
	)
	enca? ( app-i18n/enca )
	iconv? ( virtual/libiconv )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
	ladspa? ( media-libs/ladspa-sdk )
	libass? ( >=media-libs/libass-0.9.10[enca?,fontconfig] virtual/ttf-fonts )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	mng? ( media-libs/libmng )
	mp3? ( media-sound/mpg123 )
	openal? ( >=media-libs/openal-1.13 )
	portaudio? ( >=media-libs/portaudio-19_pre20111121 )
	postproc? ( || ( media-libs/libpostproc <media-video/libav-0.8.2-r1 media-video/ffmpeg ) )
	pulseaudio? ( media-sound/pulseaudio )
	quvi? ( >=media-libs/libquvi-0.4.1 )
	samba? ( net-fs/samba )
	>=virtual/ffmpeg-0.10.2[encode?]
"
ASM_DEP="dev-lang/yasm"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-lang/perl-5.8
	dev-python/docutils
	X? (
		x11-proto/videoproto
		x11-proto/xf86vidmodeproto
		xinerama? ( x11-proto/xineramaproto )
		xscreensaver? ( x11-proto/scrnsaverproto )
	)
	amd64? ( ${ASM_DEP} )
	x86? ( ${ASM_DEP} )
	x86-fbsd? ( ${ASM_DEP} )
"
DOCS=( AUTHORS Copyright README.rst etc/example.conf etc/input.conf )

pkg_setup() {
	elog
	elog "This is a live ebuild which installs the latest from upstream's"
	elog "${VCS_ECLASS} repository, and is unsupported by Gentoo."
	elog "Everything but bugs in the ebuild itself will be ignored."
	elog

	if use !libass; then
		ewarn
		ewarn "You've disabled the libass flag. No OSD or subtitles will be displayed."
	fi

	if use openal; then
		ewarn
		ewarn "You've enabled the openal flag. OpenAL is disabled by default,"
		ewarn "because it supposedly inteferes with some other configure tests"
		ewarn "and makes them fail silently."
	fi

	einfo "For various format support you need to enable the support on your ffmpeg package:"
	einfo "    media-video/libav or media-video/ffmpeg"
}

src_prepare() {
	# fix path to bash executable in configure scripts
	local bash_scripts="configure version.sh"
	sed -i -e "1c\#!${EPREFIX}/bin/bash" \
		${bash_scripts} || die

	base_src_prepare
}

src_configure() {
	local myconf=""
	local uses i

	# ebuild uses "use foo || --disable-foo" to forcibly disable
	# compilation in almost every situation. The reason for this is
	# because if --enable is used, it will force the build of that option,
	# regardless of whether the dependency is available or not.

	###################
	#Optional features#
	###################
	# SDL output is fallback for platforms where nothing better is available
	myconf+=" --disable-sdl --disable-sdl2"
	use encode || myconf+=" --disable-encoding"
	use network || myconf+=" --disable-networking"
	myconf+=" $(use_enable joystick)"
	uses="bluray enca ftp libass vcd"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use ipv6 || myconf+=" --disable-inet6"
	use quvi || myconf+=" --disable-libquvi"
	use samba || myconf+=" --disable-smb"
	if ! use lirc; then
		myconf+="
			--disable-lirc
			--disable-lircc
		"
	fi

	########
	# CDDA #
	########
	use cddb || myconf+=" --disable-cddb"
	use cdio || myconf+=" --disable-libcdio"

	################################
	# DVD read                     #
	################################
	#
	# dvdread - accessing a DVD
	#
	use dvd || myconf+=" --disable-dvdread"

	#############
	# Subtitles #
	#############
	#
	use iconv || myconf+=" --disable-iconv"

	#####################################
	# DVB / Video4Linux / Radio support #
	#####################################
	if { use dvb || use v4l || use pvr || use radio; }; then
		use dvb || myconf+=" --disable-dvb"
		use pvr || myconf+=" --disable-pvr"
		use v4l || myconf+=" --disable-tv-v4l2"
		if use radio && { use dvb || use v4l; }; then
			myconf+="
				--enable-radio
				--disable-radio-capture
			"
		else
			myconf+="
				--disable-radio-v4l2
			"
		fi
	else
		myconf+="
			--disable-tv
			--disable-tv-v4l2
			--disable-radio
			--disable-radio-v4l2
			--disable-dvb
			--disable-pvr"
	fi

	##########
	# Codecs #
	##########
	use mp3 || myconf+=" --disable-mpg123"
	uses="bs2b"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-lib${i}"
	done
	uses="jpeg mng"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done

	################
	# Video Output #
	################
	use libcaca || myconf+=" --disable-caca"
	use postproc || myconf+=" --disable-libpostproc"

	################
	# Audio Output #
	################
	myconf+=" --disable-rsound" # media-sound/rsound is in pro-audio overlay only
	uses="alsa jack ladspa portaudio"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use openal && myconf+=" --enable-openal"
	use pulseaudio || myconf+=" --disable-pulse"
	if ! use radio; then
		use oss || myconf+=" --disable-ossaudio"
	fi

	####################
	# Advanced Options #
	####################
	# Platform specific flags, hardcoded on amd64 (see below)
	use shm || myconf+=" --disable-shm"
	use debug && myconf+=" --enable-debug=3"

	if use x86 && gcc-specs-pie; then
		filter-flags -fPIC -fPIE
		append-ldflags -nopie
	fi

	###########################
	# X enabled configuration #
	###########################
	use X || myconf+=" --disable-x11"
	uses="vdpau xinerama xv"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use opengl || myconf+=" --disable-gl"
	use lcms || myconf+=" --disable-lcms2"
	use xscreensaver || myconf+=" --disable-xss"

	############################
	# OSX (aqua) configuration #
	############################
	if use aqua; then
		myconf+="
			--enable-macosx-finder
			--enable-macosx-bundle
		"
	fi

	./configure \
		--cc="$(tc-getCC)" \
		--pkg-config="$(tc-getPKG_CONFIG)" \
		--prefix="${EPREFIX}"/usr \
		--bindir="${EPREFIX}"/usr/bin \
		--confdir="${EPREFIX}"/etc/${PN} \
		--mandir="${EPREFIX}"/usr/share/man \
		--localedir="${EPREFIX}"/usr/share/locale \
		${myconf} || die

	MAKEOPTS+=" V=1"
}
