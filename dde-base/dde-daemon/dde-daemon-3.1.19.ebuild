# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6


DESCRIPTION="Daemon handling the DDE session settings"
HOMEPAGE="https://github.com/linuxdeepin/dde-daemon"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth miracast"

RDEPEND="x11-wm/deepin-metacity
		x11-libs/libxkbfile
		app-text/iso-codes
		sys-apps/accountsservice
		sys-power/acpid
		sys-fs/udisks:2
		gnome-extra/polkit-gnome
		dde-base/deepin-desktop-schemas
		net-misc/networkmanager
		gnome-base/gvfs[udisks]
		sys-libs/pam
		>sys-power/upower-0.99
		miracast? ( net-wireless/iw )
		bluetooth? ( net-wireless/bluez )
	"
DEPEND="${RDEPEND}
	      dev-go/go-dbus-generator
		  >=dev-go/go-x11-client-0.0.2
	      >=dev-go/deepin-go-lib-1.1.0
		  >=dev-go/dde-go-essential-20170807
	      >=dev-go/dbus-factory-3.0.8
	      >=dde-base/dde-api-3.1.3
		  dev-libs/libinput
	      dev-db/sqlite:3
	      "

src_prepare() {

	export GOPATH="${S}:/usr/share/gocode"	
	go get -d -f -u -v github.com/msteinert/pam || die
	LIBDIR=$(get_libdir)
	sed -i "s|lib/deepin-daemon|${LIBDIR}/deepin-daemon|g" Makefile
	default_src_prepare
}

#src_compile() {
#	emake USE_GCCGO=1
#}
