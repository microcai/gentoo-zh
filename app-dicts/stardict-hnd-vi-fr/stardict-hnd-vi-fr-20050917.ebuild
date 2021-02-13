# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

FROM_LANG="Vietnamese"
TO_LANG="French"

inherit stardict

HOMEPAGE="https://sourceforge.net/projects/ovdp/"
SRC_URI="mirror://gentoo/VietPhap38K.zip"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

S=${WORKDIR}/VietPhap
