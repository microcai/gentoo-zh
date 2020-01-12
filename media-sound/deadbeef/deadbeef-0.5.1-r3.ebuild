# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit fdo-mime gnome2 eutils

DESCRIPTION="foobar2000-like music player."
HOMEPAGE="http://deadbeef.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="strip mirror"
LICENSE="GPL-2 ZLIB"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="aac adplug alsa cdda cover curl dts encode ffmpeg flac gme +gtk
	hotkeys imlib lastfm libnotify libsamplerate m3u mac midi mms mp3
	musepack nls null oss pulseaudio shellexec sid sndfile supereq threads
	tta vorbis vtx wavpack zip linguas_zh_CN"

REQUIRED_USE="encode? ( gtk )
	cover? ( curl )
	lastfm? ( curl )"

RDEPEND="
	aac? ( media-libs/faad2 )
	alsa? ( media-libs/alsa-lib )
	cdda? ( dev-libs/libcdio media-libs/libcddb )
	cover? (
		imlib? ( media-libs/imlib2 )
		!imlib? ( virtual/jpeg media-libs/libpng )
	)
	curl? ( net-misc/curl )
	ffmpeg? ( virtual/ffmpeg )
	flac? ( media-libs/flac )
	gtk? ( x11-libs/gtk+:2 )
	hotkeys? ( x11-libs/libX11 )
	libnotify? ( sys-apps/dbus )
	libsamplerate? ( media-libs/libsamplerate )
	midi? ( media-sound/timidity-freepats )
	mp3? ( media-libs/libmad )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	zip? ( sys-libs/zlib )
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( virtual/libintl dev-util/intltool )
	"

src_prepare() {
	if use midi; then
		# set default gentoo path
		sed -e 's;/etc/timidity++/timidity-freepats.cfg;/usr/share/timidity/freepats/timidity.cfg;g' \
			-i "${S}/plugins/wildmidi/wildmidiplug.c"
	fi

	if use ffmpeg; then
		epatch "${FILESDIR}/${P}-alt-libav-using.patch"
	fi

	if use linguas_zh_CN; then
		epatch "${FILESDIR}/gbk.patch"
	fi

}

src_configure() {
	my_config="$(use_enable nls)
		$(use_enable threads)
		$(use_enable null nullout)
		$(use_enable alsa)
		$(use_enable oss)
		$(use_enable gtk gtkui)
		$(use_enable aac)
		$(use_enable adplug)
		$(use_enable cdda)
		$(use_enable cover artwork)
		$(use_enable curl vfs-curl)
		$(use_enable dts dca)
		$(use_enable encode converter)
		$(use_enable ffmpeg)
		$(use_enable flac)
		$(use_enable gme)
		$(use_enable hotkeys)
		$(use_enable imlib artwork-imlib2)
		$(use_enable lastfm lfm)
		$(use_enable libnotify notify)
		$(use_enable libsamplerate src)
		$(use_enable m3u)
		$(use_enable mac ffap)
		$(use_enable midi wildmidi)
		$(use_enable mms)
		$(use_enable mp3 mad)
		$(use_enable musepack)
		$(use_enable pulseaudio pulse)
		$(use_enable shellexec)
		$(use_enable sid)
		$(use_enable sndfile)
		$(use_enable supereq)
		$(use_enable tta)
		$(use_enable vorbis)
		$(use_enable vtx)
		$(use_enable wavpack)
		$(use_enable zip vfs-zip)
		--docdir=/usr/share/doc/${PF}"

	econf ${my_config}
}

src_install() {
	# Do not compress docs as we need it for deadbeef's help function.
	PORTAGE_DOCOMPRESS_SKIP+=( "/usr/share/doc/${PF}" )

	emake DESTDIR="${D}" install
}
