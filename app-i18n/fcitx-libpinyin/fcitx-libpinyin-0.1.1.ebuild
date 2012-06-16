# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="Libpinyin Wrapper for Fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx-libpinyin"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz
	https://github.com/downloads/fcitx/fcitx-libpinyin/model.text.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.0
	>=app-i18n/libpinyin-0.5.0"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_prepare() {
	cp "${DISTDIR}/model.text.tar.gz" "${S}/data" || die "model.text.tar.gz is not found"
}