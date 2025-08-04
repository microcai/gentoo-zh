# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Script for gThumb to upload images to Wikimedia Commons, can be used by itself"
HOMEPAGE="https://gitlab.com/vitaly-zdanevich/upload_to_commons_with_categories_from_iptc"
SRC_URI="https://gitlab.com/vitaly-zdanevich/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/iptcinfo3
	dev-python/exifread
	dev-python/pywikibot
"

src_install() {
	dobin ${PN}.py
}

pkg_postinst() {
	einfo "You need manually to add to gThumb in Personalize:"
	einfo "$PN %F"
}
