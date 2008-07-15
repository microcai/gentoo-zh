# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xelatex-package

DESCRIPTION="xeCJK is a package for using with XeLaTeX"
HOMEPAGE="http://miktex.math.nankai.edu.cn"
SRC_URI="http://miktex.math.nankai.edu.cn/xecjk/xecjk-${PV}.zip "

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-text/xetex-0.997"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"
src_unpack() {
	unpack ${A}
	cp  "${FILESDIR}/mkfontlist.py" "${S}/utils/xeCJK/make-tbl-file/"
}

src_compile() {
	cp -r "${S}/utils" "${S}/utils-work"
	cd "${S}/utils-work/xeCJK/make-tbl-file"
	python mkfontlist.py
	xelatex --shell-escape main
	for f in chs*.tbl; do
		if [ -f $f ]; then
			mv $f "${S}/tex/xelatex/xeCJK/chs/tbl/"
		fi
	done
	for f in cht*.tbl; do
		if [ -f $f ]; then
			mv $f "${S}/tex/xelatex/xeCJK/cht/tbl/"
		fi
	done
	for f in ja*.tbl; do
		if [ -f $f ]; then
			mv $f "${S}/tex/xelatex/xeCJK/ja/tbl/"
		fi
	done
	for f in ko*.tbl; do
		if [ -f $f ]; then
			mv $f "${S}/tex/xelatex/xeCJK/ko/tbl/"
		fi
	done
}

src_install() {
	insinto "/usr/share/doc/${P}"
	doins -r "${S}/doc/xelatex/xeCJK/"*
	insinto "${TEXMF}"
	doins -r tex
	insinto "${TEXMF}/scripts/xelatex"
	doins -r utils/xeCJK
}
