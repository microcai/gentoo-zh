# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/cinnamon/cinnamon-1.4.ebuild,v 1.4 2012/05/22 03:22:44 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml"

inherit autotools eutils gnome2 multilib pax-utils python vcs-snapshot

DESCRIPTION="A fork of GNOME Shell with layout similar to GNOME 2"
HOMEPAGE="http://cinnamon.linuxmint.com/"

SRC_URI="https://github.com/linuxmint/Cinnamon/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="+bluetooth +networkmanager"
KEYWORDS="~amd64 ~x86"

# gnome-desktop-2.91.2 is needed due to header changes, db82a33 in gnome-desktop
# latest gsettings-desktop-schemas is needed due to commit 602fa1c6
# latest g-c-c is needed due to https://bugs.gentoo.org/show_bug.cgi?id=360057
# libXfixes-5.0 needed for pointer barriers
# gnome-menus-3.2.0.1-r1 needed for new 10-xdg-menu-gnome
COMMON_DEPEND=">=dev-libs/glib-2.30:2
	>=dev-libs/gjs-1.29.18
	>=dev-libs/gobject-introspection-0.10.1
	x11-libs/gdk-pixbuf:2[introspection]
	>=x11-libs/gtk+-3.4[introspection]
	>=media-libs/clutter-1.7.5:1.0[introspection]
	app-misc/ca-certificates
	>=dev-libs/folks-0.5.2
	>=dev-libs/json-glib-0.13.2
	>=gnome-base/gnome-desktop-3.4:3[introspection]
	>=gnome-base/gsettings-desktop-schemas-3.4
	>=gnome-extra/evolution-data-server-3.4
	>=media-libs/gstreamer-0.10.16:0.10
	>=media-libs/gst-plugins-base-0.10.16:0.10
	>=net-im/telepathy-logger-0.2.4[introspection]
	net-libs/libsoup:2.4[introspection]
	>=net-libs/telepathy-glib-0.15.5[introspection]
	>=sys-auth/polkit-0.100[introspection]
	>=x11-wm/muffin-1.1.0

	dev-libs/dbus-glib
	dev-libs/libxml2:2
	x11-libs/pango[introspection]
	>=dev-libs/libcroco-0.6.2:0.6

	gnome-base/gconf:2[introspection]
	>=gnome-base/gnome-menus-3.4:3[introspection]
	gnome-base/librsvg
	media-libs/libcanberra
	media-sound/pulseaudio

	>=x11-libs/startup-notification-0.11
	x11-libs/libX11
	>=x11-libs/libXfixes-5.0
	x11-apps/mesa-progs

	bluetooth? ( >=net-wireless/gnome-bluetooth-3.1.0[introspection] )
	networkmanager? (
		gnome-base/libgnome-keyring
		>=net-misc/networkmanager-0.8.999[introspection] )"
# Runtime-only deps are probably incomplete and approximate.
# Each block:
# 2. Introspection stuff + dconf needed via imports.gi.*
# 3. gnome-session is needed for gnome-session-quit
# 4. Control shell settings
# 5. accountsservice is needed for GdmUserManager (0.6.14 needed for fast
#    user switching with gdm-3.1.x)
# 6. caribou needed for on-screen keyboard
# 7. xdg-utils needed for xdg-open, used by extension tool
# 8. gconf-python needed for cinnamon-settings
# 9. gnome-icon-theme-symbolic needed for various icons
# 10. pygtk and gnome-menus:0 needed for menu editor
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/dconf-0.4.1
	>=gnome-base/libgnomekbd-2.91.4[introspection]
	sys-power/upower[introspection]

	>=gnome-base/gnome-session-3.2.1-r1

	>=gnome-base/gnome-settings-daemon-2.91
	>=gnome-base/gnome-control-center-2.91.92-r1

	>=sys-apps/accountsservice-0.6.14[introspection]

	>=app-accessibility/caribou-0.3

	x11-misc/xdg-utils

	dev-python/dbus-python
	dev-python/gconf-python:2

	x11-themes/gnome-icon-theme-symbolic

	dev-python/pygtk
	gnome-base/gnome-menus:3[introspection]

	net-misc/mobile-broadband-provider-info
	sys-libs/timezone-data "

DEPEND="${COMMON_DEPEND}
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	gnome-base/gnome-common
	!!=dev-lang/spidermonkey-1.8.2*"
# libmozjs.so is picked up from /usr/lib while compiling, so block at build-time
# https://bugs.gentoo.org/show_bug.cgi?id=360413


pkg_setup() {
	DOCS="AUTHORS NEWS README"
	# Don't error out on warnings
	G2CONF="${G2CONF}
		--enable-compile-warnings=maximum
		--disable-schemas-compile
		--disable-jhbuild-wrapper-script
		$(use_with bluetooth)
		$(use_enable networkmanager)
		--with-ca-certificates=${EPREFIX}/etc/ssl/certs/ca-certificates.crt
		BROWSER_PLUGIN_DIR=${EPREFIX}/usr/$(get_libdir)/nsbrowser/plugins"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Fix automagic gnome-bluetooth dep, bug #398145
	epatch "${FILESDIR}/${PN}-1.1.3-automagic-gnome-bluetooth.patch"

	# Gentoo uses /usr/libexec
	sed -e "s:/usr/lib/gnome-session/gnome-session-check-accelerated:${EPREFIX}/usr/libexec/gnome-session-check-accelerated:" \
		-i "files/usr/share/gnome-session/sessions/cinnamon.session" || die "sed 1 failed"

	# Gentoo uses /usr/$(get_libdir), not /usr/lib even for python
	sed -e "s:/usr/lib/:/usr/$(get_libdir)/:" \
		-e 's:"/usr/lib":"/usr/'"$(get_libdir)"'":' \
		-i files/usr/bin/cinnamon-menu-editor \
		-i files/usr/bin/cinnamon-settings \
		-i files/usr/lib/cinnamon-menu-editor/Alacarte/config.py \
		-i files/usr/lib/cinnamon-settings/cinnamon-settings.py \
		-i files/generate_desktop_files || die "sed 2 failed"
	if [[ "$(get_libdir)" != lib ]]; then
		mv files/usr/lib "files/usr/$(get_libdir)" || die "mv failed"
	fi

	if ! use bluetooth; then
		rm -rv files/usr/share/cinnamon/applets/bluetooth@cinnamon.org || die
	fi

	if ! use networkmanager; then
		rm -rv files/usr/share/cinnamon/applets/network@cinnamon.org || die
	fi

	eautoreconf
	gnome2_src_prepare

	# Drop G_DISABLE_DEPRECATED for sanity on glib upgrades; bug #384765
	# Note: sed Makefile.in because it is generated from several Makefile.ams
	sed -e 's/-DG_DISABLE_DEPRECATED//g' \
		-i src/Makefile.in browser-plugin/Makefile.in || die "sed 3 failed"
}

src_install() {
	gnome2_src_install
	python_convert_shebangs 2 "${ED}usr/bin/cinnamon-extension-tool" \
		"${ED}usr/bin/cinnamon-menu-editor" \
		"${ED}usr/bin/cinnamon-settings" \
		"${ED}usr/$(get_libdir)/cinnamon-settings/cinnamon-settings.py"

	# Required for gnome-shell on hardened/PaX, bug #398941
	pax-mark mr "${ED}usr/bin/cinnamon"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize "/usr/$(get_libdir)/"cinnamon-{menu-editor,settings}

	if ! has_version '>=media-libs/gst-plugins-good-0.10.23' || \
	   ! has_version 'media-plugins/gst-plugins-vp8'; then
		ewarn "To make use of Cinnamon's built-in screen recording utility,"
		ewarn "you need to either install >=media-libs/gst-plugins-good-0.10.23"
		ewarn "and media-plugins/gst-plugins-vp8, or use dconf-editor to change"
		ewarn "apps.gnome-shell.recorder/pipeline to what you want to use."
	fi

	if ! has_version ">=x11-base/xorg-server-1.11"; then
		ewarn "If you use multiple screens, it is highly recommended that you"
		ewarn "upgrade to >=x11-base/xorg-server-1.11 to be able to make use of"
		ewarn "pointer barriers which will make it easier to use hot corners."
	fi

	if has_version "<x11-drivers/ati-drivers-12"; then
		ewarn "Cinnamon has been reported to show graphical corruption under"
		ewarn "x11-drivers/ati-drivers-11.*; you may want to use GNOME in"
		ewarn "fallback mode, or switch to open-source drivers."
	fi

	if has_version "media-libs/mesa[video_cards_radeon]"; then
		elog "Cinnamon is unstable under classic-mode r300/r600 mesa drivers."
		elog "Make sure that gallium architecture for r300 and r600 drivers is"
		elog "selected using 'eselect mesa'."
		if ! has_version "media-libs/mesa[gallium]"; then
			ewarn "You will need to emerge media-libs/mesa with USE=gallium."
		fi
	fi

	if has_version "media-libs/mesa[video_cards_intel]"; then
		elog "Cinnamon is unstable under gallium-mode i915/i965 mesa drivers."
		elog "Make sure that classic architecture for i915 and i965 drivers is"
		elog "selected using 'eselect mesa'."
		if ! has_version "media-libs/mesa[classic]"; then
			ewarn "You will need to emerge media-libs/mesa with USE=classic."
		fi
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "/usr/$(get_libdir)/"cinnamon-{menu-editor,settings}
}
