# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="An input method frontend for fcitx."
HOMEPAGE="https://github.com/lenky0401/fcitx-qimpanel"
SRC_URI="https://github.com/lenky0401/fcitx-qimpanel/archive/fcitx-qimpanel-0.1.5.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~amd64 ~86"
IUSE=""

DEPEND=">=app-i18n/fcitx-4.2.8
dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/fcitx-qimpanel-fcitx-qimpanel-${PV}"