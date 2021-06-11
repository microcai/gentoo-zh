# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/robert7/${PN}2.git"
else
	SRC_URI="https://github.com/robert7/${PN}2/archive/v${PV}.tar.gz -> ${PN}2-${PV}.tar.gz"
	S="${WORKDIR}/${PN}2-${PV}"
fi

SLOT="2"
DESCRIPTION="Nixnote - A clone of Evernote for Linux"
HOMEPAGE="http://sourceforge.net/projects/nevernote/"

LICENSE="GPL-3"

[[ "${PV}" == *9999* ]] || KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/boost
	net-misc/curl
	app-text/hunspell
	app-text/poppler[qt5]
	dev-qt/qtwebkit:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5
	dev-qt/qtxml:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/linguist-tools:5"
RDEPEND="${DEPEND}
	app-text/tidy-html5"

src_prepare() {
	eapply "${FILESDIR}"/tidy-source-dir-location.patch
	eapply "${FILESDIR}"/fix-build-script.patch
	eapply_user
}

src_configure() {
	./development/build-with-qmake.sh
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc -r "changelog.txt" "LICENSE" "shortcuts.txt" "themes.ini"
	rm -r "${D}"/usr/share/nixnote2/translations/*.ts
	doman "${S}/docs/nixnote2.1"
}
