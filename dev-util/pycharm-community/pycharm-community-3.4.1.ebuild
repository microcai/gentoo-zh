# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="The intelligent Python IDE with unique code assistance and analysis, for productive Python development on all levels"
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/python/${PN}-${PV}.tar.gz"
RESTRICT="strip mirror"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/jre-1.6"
RDEPEND="${DEPEND}"
S=${WORKDIR}

src_install() {
	dodir /opt/${PN}-${PV}

	insinto /opt/${PN}-${PV}
	cd ${PN}-${PV}
	doins -r *
	fperms a+x /opt/${PN}-${PV}/bin/pycharm.sh || die "fperms failed"
	fperms a+x /opt/${PN}-${PV}/bin/fsnotifier || die "fperms failed"
	fperms a+x /opt/${PN}-${PV}/bin/fsnotifier64 || die "fperms failed"
	fperms a+x /opt/${PN}-${PV}/bin/inspect.sh || die "fperms failed"
	dosym /opt/${PN}-${PV}/bin/pycharm.sh /usr/bin/pycharm

	doicon "bin/pycharm.png"
	make_desktop_entry ${PN}-${PV} "${PN}-${PV}" "${PN}-${PV}"
}

pkg_postinst() {
    elog "Run /usr/bin/pycharm"
}
