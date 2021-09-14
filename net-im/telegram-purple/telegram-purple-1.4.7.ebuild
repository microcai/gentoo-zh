# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/majn/telegram-purple/releases/download/v${PV}/${PN}_${PV}.orig.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Libpurple (Pidgin) plugin for using a Telegram account"
HOMEPAGE="https://github.com/majn/telegram-purple"

LICENSE="LGPL-3"
SLOT="0"
IUSE="+webp"

DEPEND="
	net-im/pidgin
	dev-libs/openssl
	sys-libs/glibc
	webp? ( media-libs/libwebp )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_configure(){
	local myconf=(
		"$(use_enable webp libwebp)"
	)
	econf "${myconf[@]}" || die "econf failed"
}

pkg_postinst() {
	if [[ "${PV}" == 9999 ]]; then
		elog "Note: this package is in an early (pre-alpha) stage, so if you"
		elog "want to view changes, install this package often."
		elog "More information is available in ${HOMEPAGE}"
	fi
}
