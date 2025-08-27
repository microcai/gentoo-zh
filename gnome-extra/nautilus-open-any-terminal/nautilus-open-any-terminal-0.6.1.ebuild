# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2

DESCRIPTION="context-menu entry for opening other terminal in nautilus"
HOMEPAGE="https://github.com/Stunkymonkey/nautilus-open-any-terminal"
SRC_URI="https://github.com/Stunkymonkey/nautilus-open-any-terminal/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/nautilus-python
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/make
	sys-devel/gettext
"

src_configure() {
	default
}

src_compile() {
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" PREFIX="/usr" install-nautilus
	einstalldocs
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_prerm() {
	make DESTDIR="${D}" PREFIX="/usr" uninstall
}

pkg_postrm() {
	gnome2_schemas_update
}
