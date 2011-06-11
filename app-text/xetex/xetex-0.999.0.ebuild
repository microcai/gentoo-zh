# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils

DESCRIPTION="Unicode version of tex with other enhancements."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex"
SRC_URI="http://scripts.sil.org/svn-view/xetex/TAGS/${P}.tar.gz"

LICENSE="XeTeX"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RESTRICT="mirror"

RDEPEND="app-text/xdvipdfmx
	virtual/tex-base
	sys-libs/zlib
	>=media-libs/libpng-1.2.1
	=media-libs/freetype-2*
	media-libs/fontconfig
	!dev-texlive/texlive-xetex"
DEPEND="${RDEPEND}
	sys-apps/ed
	sys-devel/flex
	app-arch/unzip"

pkg_setup() {
	einfo
	einfo "If the app-text/texlive-core do not have \"xetex\" USE flag,"
	einfo "You can get the ebuild from Gentoo China Overylay."
	einfo
	epause
	if  built_with_use "app-text/texlive-core" xetex ;then
		eerror "You should not build app-text/texlive-core with \"xetex\" USE flag."
		die "app-text/texlive-core build with \"xetex\" USE"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-9999-build.patch"
	epatch "${FILESDIR}/${PN}-9999-install.patch"
	epatch "${FILESDIR}/${PN}-9999-runconfigure.patch"
}

src_compile() {
	sed -i -e 's/^ \{1,8\}/\t/' Makefile.in
	sh build-xetex || die
}

src_install() {
	sh -x install-xetex || die
	# Need to softlink xelatex to xetex.
	dodir /usr/share/texmf/tex/generic/hyphen
	insinto /usr/share/texmf/tex/generic/hyphen
	doins "${S}/obsolete/hyphen/"*
}

pkg_preinst()
{
	cd "${S}"
	texhash "${D}usr/share/texmf"

	# And tidy up fmtutil's location.
	fmtutil=`kpsewhich --format="web2c files" fmtutil.cnf`
	if [ -L $fmtutil ] ; then
		fmtutil_real=`readlink "${fmtutil}"`
		FMT=${D}`dirname "${fmtutil_real}"`
		mkdir -p "${FMT}"
		mv "${D}${fmtutil}" "${D}${fmtutil_real}"
	fi

	### Add xetex to the search path for xelatex, if not already done.
	mkdir -p "${D}etc/texmf/web2c"
	egrep -q 'TEXINPUTS.xelatex = .;\$TEXMF/tex/{xelatex,latex,generic,}//' /etc/texmf/web2c/texmf.cnf || \
		sed -e 's/TEXINPUTS.xelatex = .;$TEXMF\/tex\/{latex,generic,}\/\//TEXINPUTS.xelatex = .;$TEXMF\/tex\/{xelatex,latex,generic,}\/\//' /etc/texmf/web2c/texmf.cnf > "${D}etc/texmf/web2c/texmf.cnf"
}

pkg_postinst()
{
	if [ "$ROOT" = "/" ] ; then
		/usr/sbin/texmf-update
	fi
}

pkg_postrm()
{
	if [ "$ROOT" = "/" ] ; then
		/usr/sbin/texmf-update
	fi
}
