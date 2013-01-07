# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit git-2 fdo-mime eutils versionator

EGIT_REPO_URI="git://github.com/lovesnow/deepin-screenshot.git"

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/lovesnow/deepin-screenshot"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


RDEPEND="dev-lang/python:2.7
		dev-python/pygtk:2
		dev-python/python-xlib"
DEPEND="${RDEPEND}"

src_prepare() {
	sh updateTranslate.sh || die "failed to update Translate"
	rm -rf po || die
	rm -rf debian || die
}

src_install() {
	dodoc AUTHORS ChangeLog README

	insinto "/usr/share/deepin-screenshot"
	doins -r ${S}/locale ${S}/src ${S}/theme
	fperms 0755 -R /usr/share/deepin-screenshot/src/

	dosym /usr/share/${PN}/src/${PN} /usr/bin/${PN}


	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}