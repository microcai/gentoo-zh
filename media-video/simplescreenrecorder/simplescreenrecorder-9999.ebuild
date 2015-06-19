# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools flag-o-matic multilib-minimal

if [[ ${PV} = 9999 ]]; then
	inherit git-2
fi

DESCRIPTION="A Simple Screen Recorder"
HOMEPAGE="http://www.maartenbaert.be/simplescreenrecorder"
LICENSE="GPL-3"
PKGNAME="ssr"
S=${WORKDIR}/${PKGNAME}-${PV}
if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="git://github.com/MaartenBaert/${PKGNAME}.git
		https://github.com/MaartenBaert/${PKGNAME}.git"
	EGIT_BOOTSTRAP=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/MaartenBaert/${PKGNAME}/archive/${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE="+asm debug jack mp3 pulseaudio theora vorbis vpx x264 +qt4 qt5"
REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="
	qt4? (
		>=dev-qt/qtcore-4.8.0:4
		>=dev-qt/qtgui-4.8.0:4
	)
	qt5? (
		>=dev-qt/qtcore-5.1.0:5
		>=dev-qt/qtgui-5.1.0:5
		>=dev-qt/qtwidgets-5.1.0:5
		>=dev-qt/qtx11extras-5.1.0:5
	)
	virtual/glu[${MULTILIB_USEDEP}]
	media-libs/alsa-lib
	media-libs/mesa[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXext
	x11-libs/libXfixes[${MULTILIB_USEDEP}]
	jack? ( media-sound/jack-audio-connection-kit )
	pulseaudio? ( media-sound/pulseaudio )
	|| (
		media-video/ffmpeg[vorbis?,vpx?,x264?,mp3?,theora?]
		media-video/libav[vorbis?,vpx?,x264?,mp3?,theora?]
	)
	"
DEPEND="${RDEPEND}"

pkg_setup() {
	if [[ ${PV} == "9999" ]]; then
		elog
		elog "This ebuild merges the latest revision available from upstream's"
		elog "git repository, and might fail to compile or work properly once"
		elog "merged."
		elog
	fi

	if [[ ${ABI} == amd64 ]]; then
		elog "You may want to add USE flag 'abi_x86_32' when running a 64bit system"
		elog "When added 32bit GLInject libraries are also included. This is"
		elog "required if you want to use OpenGL recording on 32bit applications."
		elog
	fi

	if ( has_version media-video/ffmpeg[x264] || has_version media-video/libav[x264] ) && has_version media-libs/x264[10bit]; then
		ewarn
		ewarn "media-libs/x264 is currently built with 10bit useflag."
		ewarn "This is known to prevent simplescreenrecorder from recording x264 videos"
		ewarn "correctly. Please build media-libs/x264 without 10bit if you want to "
		ewarn "record videos with x264."
		ewarn
	fi

	# QT requires -fPIC. Compile fails otherwise.
	# Recently removed from the default compile options upstream
	# https://github.com/MaartenBaert/ssr/commit/25fe1743058f0d1f95f6fbb39014b6ac146b5180
	append-flags -fPIC
}

multilib_src_configure() {

	local myconf=(
		--enable-dependency-tracking
		$(multilib_native_use_enable debug assert)
		$(multilib_native_use_with pulseaudio)
		$(multilib_native_use_with jack)
		$(multilib_native_use_with qt5)
		$(use_enable asm x86-asm)
	)

	# libav doesn't have AVFrame::channels
	# https://github.com/MaartenBaert/ssr/issues/195#issuecomment-45646159
	if has_version media-video/libav; then
		myconf+=( --disable-ffmpeg-versions )
	fi

	multilib_is_native_abi || myconf+=( --disable-ssrprogram )

	ECONF_SOURCE="${S}" \
	econf \
		${myconf[@]}

}
