# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISABLE_AUTOFORMATTING=true
inherit font unpacker git-r3

DESCRIPTION="Symbol fonts required by wps-office"
HOMEPAGE="https://github.com/iamdh4/ttf-wps-fonts"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86 ~x86-fbsd"
IUSE=""

EGIT_REPO_URI="https://github.com/iamdh4/ttf-wps-fonts.git"

FONT_SUFFIX="ttf"

# Only installs fonts
RESTRICT="binchecks strip test"

pkg_postinst() {
	unset FONT_CONF # override default message
	font_pkg_postinst
}

src_install(){
	install -d "${D}/usr/share/fonts/wps-fonts"
	install -m644 *.{ttf,TTF} "${D}/usr/share/fonts/wps-fonts/"
}
