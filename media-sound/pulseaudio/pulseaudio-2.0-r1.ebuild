# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pulseaudio/pulseaudio-2.0-r1.ebuild,v 1.1 2012/06/13 11:54:50 ford_prefect Exp $

EAPI=4

inherit eutils flag-o-matic user versionator

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="http://www.pulseaudio.org/"

SRC_URI="http://freedesktop.org/software/pulseaudio/releases/${P}.tar.xz"

# libpulse-simple and libpulse link to libpulse-core; this is daemon's
# library and can link to gdbm and other GPL-only libraries. In this
# cases, we have a fully GPL-2 package. Leaving the rest of the
# GPL-forcing USE flags for those who use them.
LICENSE="!gdbm? ( LGPL-2.1 ) gdbm? ( GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="+alsa avahi +caps equalizer jack lirc oss tcpd +X dbus libsamplerate gnome bluetooth +asyncns +glib gtk test doc +udev ipv6 system-wide realtime +orc ssl +gdbm +webrtc-aec xen"

RDEPEND=">=media-libs/libsndfile-1.0.20
	X? (
		>=x11-libs/libX11-1.4.0
		>=x11-libs/libxcb-1.6
		>=x11-libs/xcb-util-0.3.1
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXtst
	)
	caps? ( sys-libs/libcap )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.1-r1 )
	alsa? ( >=media-libs/alsa-lib-1.0.19 )
	glib? ( >=dev-libs/glib-2.4.0 )
	avahi? ( >=net-dns/avahi-0.6.12[dbus] )
	jack? ( >=media-sound/jack-audio-connection-kit-0.117 )
	tcpd? ( sys-apps/tcp-wrappers )
	lirc? ( app-misc/lirc )
	dbus? ( >=sys-apps/dbus-1.0.0 )
	gtk? ( x11-libs/gtk+:2 )
	gnome? ( >=gnome-base/gconf-2.4.0 )
	bluetooth? (
		>=net-wireless/bluez-4
		>=sys-apps/dbus-1.0.0
	)
	asyncns? ( net-libs/libasyncns )
	udev? ( || ( >=sys-fs/udev-171[hwdb] >=sys-fs/udev-143[extras] ) )
	realtime? ( sys-auth/rtkit )
	equalizer? (
		sci-libs/fftw:3.0
		dev-python/PyQt4[dbus]
	)
	orc? ( >=dev-lang/orc-0.4.9 )
	ssl? ( dev-libs/openssl )
	>=media-libs/speex-1.2_rc1
	gdbm? ( sys-libs/gdbm )
	webrtc-aec? ( media-libs/webrtc-audio-processing )
	xen? ( app-emulation/xen )
	dev-libs/json-c
	>=sys-devel/libtool-2.2.4" # it's a valid RDEPEND, libltdl.so is used

DEPEND="${RDEPEND}
	sys-devel/m4
	doc? ( app-doc/doxygen )
	X? (
		x11-proto/xproto
		>=x11-libs/libXtst-1.0.99.2
	)
	dev-libs/libatomic_ops
	virtual/pkgconfig
	system-wide? ( || ( dev-util/unifdef sys-freebsd/freebsd-ubin ) )
	dev-util/intltool"
# This is a PDEPEND to avoid a circular dep
PDEPEND="alsa? ( media-plugins/alsa-plugins[pulseaudio] )"

# alsa-utils dep is for the alsasound init.d script (see bug #155707)
# bluez dep is for the bluetooth init.d script
RDEPEND="${RDEPEND}
	X? ( gnome-extra/gnome-audio )
	system-wide? (
		sys-apps/openrc
		alsa? ( media-sound/alsa-utils )
		bluetooth? ( >=net-wireless/bluez-4 )
	)"

# See "*** BLUEZ support not found (requires D-Bus)" in configure.ac
REQUIRED_USE="bluetooth? ( dbus )"

pkg_setup() {
	enewgroup audio 18 # Just make sure it exists
	enewgroup pulse-access
	enewgroup pulse
	enewuser pulse -1 -1 /var/run/pulse pulse,audio
}

src_prepare(){
	epatch "$FILESDIR/${PN}-${PV}-udev-fix.patch"
}

src_configure() {
	# It's a binutils bug, once I can find time to fix that I'll add a
	# proper dependency and fix this up. — flameeyes
	append-ldflags $(no-as-needed)

	if use gdbm; then
		myconf+=" --with-database=gdbm"
	#elif use tdb; then
	#	myconf+=" --with-database=tdb"
	else
		myconf+=" --with-database=simple"
	fi

	econf \
		--enable-largefile \
		$(use_enable glib glib2) \
		--disable-solaris \
		$(use_enable asyncns) \
		$(use_enable oss oss-output) \
		$(use_enable alsa) \
		$(use_enable lirc) \
		$(use_enable tcpd tcpwrap) \
		$(use_enable jack) \
		$(use_enable lirc) \
		$(use_enable avahi) \
		--disable-hal \
		$(use_enable dbus) \
		$(use_enable gnome gconf) \
		$(use_enable gtk gtk2) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable bluetooth bluez) \
		$(use_enable X x11) \
		$(use_enable test default-build-tests) \
		$(use_enable udev) \
		$(use_enable ipv6) \
		$(use_enable ssl openssl) \
		$(use_enable webrtc-aec) \
		$(use_enable xen) \
		$(use_with caps) \
		$(use_with equalizer fftw) \
		--disable-adrian-aec \
		--disable-esound \
		--localstatedir="${EPREFIX}"/var \
		--with-udev-rules-dir="${EPREFIX}/lib/udev/rules.d" \
		${myconf}

	if use doc; then
		pushd doxygen
		doxygen doxygen.conf
		popd
	fi
}

src_test() {
	# We avoid running the toplevel check target because that will run
	# po/'s tests too, and they are broken. Officially, it should work
	# with intltool 0.41, but that doesn't look like a stable release.
	emake -C src check
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	# Drop the script entirely if X is disabled
	use X || rm "${ED}"/usr/bin/start-pulseaudio-x11

	if use system-wide; then
		newconfd "${FILESDIR}/pulseaudio.conf.d" pulseaudio

		use_define() {
			local define=${2:-$(echo $1 | tr '[:lower:]' '[:upper:]')}

			use "$1" && echo "-D$define" || echo "-U$define"
		}

		unifdef $(use_define avahi) \
			$(use_define alsa) \
			$(use_define bluetooth) \
			$(use_define udev) \
			"${FILESDIR}/pulseaudio.init.d-5" \
			> "${T}/pulseaudio"

		doinitd "${T}/pulseaudio"
	fi

	use avahi && sed -i -e '/module-zeroconf-publish/s:^#::' "${ED}/etc/pulse/default.pa"

	dodoc README todo

	if use doc; then
		pushd doxygen/html
		dohtml *
		popd
	fi

	# Create the state directory
	use prefix || diropts -o pulse -g pulse -m0755
	keepdir /var/run/pulse

	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	if use system-wide; then
		elog "PulseAudio in Gentoo can use a system-wide pulseaudio daemon."
		elog "This support is enabled by starting the pulseaudio init.d ."
		elog "To be able to access that you need to be in the group pulse-access."
		elog "If you choose to use this feature, please make sure that you"
		elog "really want to run PulseAudio this way:"
		elog "   http://pulseaudio.org/wiki/WhatIsWrongWithSystemMode"
		elog "For more information about system-wide support, please refer to:"
		elog "	 http://pulseaudio.org/wiki/SystemWideInstance"
		if use gnome ; then
			elog
			elog "By enabling gnome USE flag, you enabled gconf support. Please note"
			elog "that you might need to remove the gnome USE flag or disable the"
			elog "gconf module on /etc/pulse/system.pa to be able to use PulseAudio"
			elog "with a system-wide instance."
		fi
	fi
	if use bluetooth; then
		elog
		elog "The Bluetooth proximity module is not enabled in the default"
		elog "configuration file. If you do enable it, you'll have to have"
		elog "your Bluetooth controller enabled and inserted at bootup or"
		elog "PulseAudio will refuse to start."
	fi

	eselect esd update --if-unset
}
