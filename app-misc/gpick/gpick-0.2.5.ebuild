# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="https://github.com/thezbyg/gpick"
SRC_URI="https://github.com/thezbyg/gpick/archive/gpick-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug unique dbus"

RDEPEND=">=x11-libs/gtk+-2.12.0
	>=dev-lang/lua-5.2
	dev-libs/boost
	dbus? ( >=dev-libs/dbus-glib-0.76 )
	unique? ( >=dev-libs/libunique-1.0.8 )
	dev-util/lemon"

DEPEND="${RDEPEND}
	>=dev-util/scons-1.0.0"

S="${WORKDIR}/gpick-gpick-${PV}"

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
