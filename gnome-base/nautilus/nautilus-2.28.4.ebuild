# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2 virtualx autotools bzr

EBZR_CACHE_DIR="nautilus-elementary"
EBZR_REPO_URI="lp:nautilus-elementary"

DESCRIPTION="A file manager for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"
SRC_URI="!elementary? ( ${SRC_URI} )"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~sh ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="beagle doc gnome tracker xmp elementary"

# not adding gnome-base/gail because it is in >=gtk+-2.13
RDEPEND=">=dev-libs/glib-2.21.3
	>=gnome-base/gnome-desktop-2.25.5
	>=x11-libs/pango-1.1.2
	>=x11-libs/gtk+-2.16.0
	>=dev-libs/libxml2-2.4.7
	>=media-libs/libexif-0.5.12
	>=gnome-base/gconf-2.0
	>=gnome-base/gvfs-0.1.2
	dev-libs/libunique
	dev-libs/dbus-glib
	x11-libs/libXft
	x11-libs/libXrender
	beagle? ( || (
		dev-libs/libbeagle
		=app-misc/beagle-0.2* ) )
	tracker? ( >=app-misc/tracker-0.7 )
	xmp? ( >=media-libs/exempi-2 )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40.1
	doc? ( >=dev-util/gtk-doc-1.4 )
	elementary? ( >=dev-util/gtk-doc-1.4 )"
# For eautoreconf
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am"

PDEPEND="gnome? ( >=x11-themes/gnome-icon-theme-1.1.91 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		--disable-packagekit
		$(use_enable beagle)
		$(use_enable tracker)
		$(use_enable xmp)"
}

src_unpack() {
	if use elementary; then
		bzr_src_unpack
	else
		gnome2_src_unpack
	fi
}

src_prepare() {
	if use elementary; then
		gtkdocize || die "gtkdocize failed"
		eautoreconf
		intltoolize || die "intltoolize failed"
	fi
	gnome2_src_prepare

	# FIXME: tarball generated with broken gtk-doc, revisit me.
	if use doc; then
		sed "/^TARGET_DIR/i \GTKDOC_REBASE=/usr/bin/gtkdoc-rebase" \
			-i gtk-doc.make || die "sed 1 failed"
	else
		sed "/^TARGET_DIR/i \GTKDOC_REBASE=/bin/true" \
			-i gtk-doc.make || die "sed 2 failed"
	fi

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed 3 failed"

	# Remove crazy CFLAGS
	sed 's:-DG.*DISABLE_DEPRECATED::g' -i configure.in configure \
		|| die "sed 4 failed"

	# Fix nautilus flipping-out with --no-desktop -- bug 266398
	epatch "${FILESDIR}/${PN}-2.27.4-change-reg-desktop-file-with-no-desktop.patch"
}

src_test() {
	addwrite "/root/.gnome2_private"
	unset SESSION_MANAGER
	unset ORBIT_SOCKETDIR
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "Test phase failed"
}

src_install() {
	gnome2_src_install
	find "${D}" -name "*.la" -delete || die "remove of la files failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "nautilus can use gstreamer to preview audio files. Just make sure"
	elog "to have the necessary plugins available to play the media type you"
	elog "want to preview"
}
