# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

MY_P=${P/-/_}
DESCRIPTION="UCIMF input method support for FbTerm"
HOMEPAGE="http://ucimf.sourceforge.net/"
SRC_URI="http://ucimf.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-i18n/libucimf"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_enable debug )
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
