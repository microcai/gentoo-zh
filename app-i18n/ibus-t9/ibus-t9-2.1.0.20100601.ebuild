# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

TAR_SUFFIX="tar.gz"

inherit eutils autotools googlecode

if [ "${PV##*.}" = "9999" ]; then
	inherit git-r3
fi

DESCRIPTION="T9 input engine using ibus"
EGIT_REPO_URI="https://github.com/microcai/${PN}.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"


RDEPEND="
	>=app-i18n/ibus-1.2
	 virtual/libintl 
	"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	 >=sys-devel/gettext-0.16.1 "
