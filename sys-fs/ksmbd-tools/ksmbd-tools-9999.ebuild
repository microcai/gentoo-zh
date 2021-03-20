# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Tools for in-kernel CIFS server"
HOMEPAGE="https://github.com/cifsd-team/ksmbd-tools"
SRC_URI=""

EGIT_REPO_URI="https://github.com/cifsd-team/ksmbd-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2.40
>=dev-libs/libnl-3.0"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure(){
	econf --disable-krb5
}
