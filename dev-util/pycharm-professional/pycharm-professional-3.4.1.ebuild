# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="The intelligent Python IDE with unique code assistance and analysis, for productive Python development on all levels."
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/python/${P}.tar.gz"
RESTRICT="strip mirror"

LICENSE="|| ( PyCharm_license PyCharm_Preview_License PyCharm_Academic_license PyCharm_Classroom_license PyCharm_OpenSource_license )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/jre-1.6"
RDEPEND="${DEPEND}"

MY_PN=${PN/-professional/}
S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	local dest="/opt/${PN}"

	insinto ${dest}
	doins -r *

	fperms 755 ${dest}/bin/{pycharm.sh,fsnotifier{,64},inspect.sh}

	newicon bin/${MY_PN}.png ${PN}.png
	make_wrapper ${PN} ${dest}/bin/${MY_PN}.sh
	make_desktop_entry ${PN} "PyCharm Professional" ${PN}
}
