# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit gnome2-utils mono eutils bzr

EBZR_REPO_URI="https://code.launchpad.net/~docky-core/docky/trunk"

DESCRIPTION="Docky is a full fledged dock application that makes opening \
common applications and managing windows easier and quicker."
HOMEPAGE="https://launchpad.net/docky"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

# keep the same dependence as gnome-do
RDEPEND=">=dev-lang/mono-2.0
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/gtk-sharp-2.12.6
	>=dev-dotnet/glade-sharp-2.12.6
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-glib-sharp
	>=dev-dotnet/gio-sharp-3.0
	>=dev-dotnet/gnome-desktop-sharp-2.24.0
	>=dev-dotnet/gnome-keyring-sharp-1.0.0
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/wnck-sharp-2.24.0
	>=dev-dotnet/art-sharp-2.24.0
	>=dev-dotnet/rsvg-sharp-2.24.0
	dev-dotnet/mono-addins
	dev-dotnet/notify-sharp
	!<gnome-extra/gnome-do-plugins-0.8"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

src_prepare() {
	(./autogen.sh) || die "autogen.sh failed"  #--prefix=/usr
}

src_install() {
	emake install DESTDIR="${D}"  || die "Install failed"
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
