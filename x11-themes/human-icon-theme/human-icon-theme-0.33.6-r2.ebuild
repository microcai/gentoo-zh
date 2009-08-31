# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#inherit autotools

MY_PV="${PVR/-r/ubuntu}"
DESCRIPTION="Icon themes from Ubuntu"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="mirror://ubuntu/pool/main/h/${PN}/${PN}_${MY_PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	>=x11-misc/icon-naming-utils-0.8.90
	media-gfx/imagemagick
	>=gnome-base/librsvg-2.26.0
	>=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	mv "${PN}-${MY_PV}" "${P}"
	cd "${P}"
	sed -i "s|\/usr\/lib\/icon-naming-utils\/icon-name-mapping|\/usr\/libexec\/icon-name-mapping|g" Makefile
#	intltoolize -c --force || die "intltoolize failed"
#	eautoreconf
}

src_compile() {
#	econf
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	local basecomponents="base calc draw impress writer"
	for comp in ${basecomponents}; do
		dosym  /usr/share/icons/Human/22x22/apps/ooo-${comp}.png /usr/share/icons/Human/22x22/apps/ooo_${comp}.png
		dosym  /usr/share/icons/Human/24x24/apps/ooo-${comp}.png /usr/share/icons/Human/24x24/apps/ooo_${comp}.png
		dosym  /usr/share/icons/Human/48x48/apps/ooo-${comp}.png /usr/share/icons/Human/48x48/apps/ooo_${comp}.png
		dosym  /usr/share/icons/Human/scalable/apps/ooo-${comp}.svg /usr/share/icons/Human/scalable/apps/ooo_${comp}.svg
	done
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
