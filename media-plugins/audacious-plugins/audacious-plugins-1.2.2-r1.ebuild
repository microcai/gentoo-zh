# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-plugins/audacious-plugins-1.2.2.ebuild,v 1.1 2006/10/24 09:48:15 chainsaw Exp $

inherit flag-o-matic

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://audacious-media-player.org/release/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac alsa arts chardet esd flac jack lirc modplug mp3 musepack nls oss sid sndfile timidity vorbis wma pulseaudio"

RDEPEND="app-arch/unzip
	dev-libs/libxml2
	net-misc/curl
	media-libs/musicbrainz
	>=media-sound/audacious-1.2.0
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	>=dev-cpp/libbinio-1.4
	media-libs/taglib
	alsa? ( >=media-libs/alsa-lib-1.0.9_rc2 )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.30 )
	flac? ( >=media-libs/libvorbis-1.0
		|| ( ~media-libs/flac-1.1.2
		     ~media-libs/flac-1.1.3 )
	      )
	jack? ( >=media-libs/bio2jack-0.4
		media-libs/libsamplerate
		media-sound/jack-audio-connection-kit )
	lirc? ( app-misc/lirc )
	modplug? ( media-libs/libmodplug )
	musepack? ( media-libs/libmpcdec )
	sid? ( media-libs/libsidplay )
	sndfile? ( media-libs/libsndfile )
	timidity? ( media-sound/timidity++ )
	vorbis? ( >=media-libs/libvorbis-1.0
		  >=media-libs/libogg-1.0 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.3 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0"

mp3_warning() {
	if ! useq mp3 ; then
		echo
		ewarn "MP3 support is now optional, you may want to enable the mp3 USE-flag"
		echo
	fi
}

src_compile() {
	mp3_warning

	# Bug #42893
	replace-flags "-Os" "-O2"
	# Bug #86689
	is-flag "-O*" || append-flags -O

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		$(use_enable chardet) \
		$(use_enable vorbis) \
		$(use_enable esd) \
		$(use_enable mp3) \
		$(use_enable nls) \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable flac) \
		$(use_enable aac) \
		$(use_enable modplug) \
		$(use_enable lirc) \
		$(use_enable sndfile) \
		$(use_enable wma) \
		$(use_enable sid) \
		$(use_enable musepack) \
		$(use_enable jack) \
		$(use_enable timidity) \
		$(use_enable pulseaudio pulse) \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS
}

pkg_postinst() {
	mp3_warning
}
