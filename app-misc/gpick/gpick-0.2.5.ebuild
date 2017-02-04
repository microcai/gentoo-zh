# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_P="${PN}_${PV}"

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="https://github.com/thezbyg/gpick"
SRC_URI="https://github.com/thezbyg/gpick/archive/gpick-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug unique dbus"

RDEPEND=">=x11-libs/gtk+-2.12.0
	>=dev-lang/lua-5.1
	dev-libs/boost
	dbus? ( >=dev-libs/dbus-glib-0.76 )
	unique? ( >=dev-libs/libunique-1.0.8 )
	dev-util/lemon"

DEPEND="${RDEPEND}
	>=dev-util/scons-1.0.0"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/fix_revision_information.diff
}
src_compile() {
	use unique && WITH_UNIQUE=yes
	use dbus && WITH_DBUSGLIB=yes
	use debug && DEBUG=yes

	scons ${MAKEOPTS} build \
		|| die "scons build failed"
}

src_install() {
	scons DESTDIR="${D}/usr" install || die "scons install failed"

	dosym /usr/share/icons/hicolor/48x48/apps/gpick.png /usr/share/pixmaps/gpick.png
}
