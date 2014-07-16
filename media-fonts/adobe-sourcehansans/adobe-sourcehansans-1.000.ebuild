# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSansOTF"
DESCRIPTION="Source Han Sans is an OpenType/CFF Pan-CJK font family."
HOMEPAGE="http://sourceforge.net/projects/source-han-sans.adobe/"
#SRC_URI="http://sourceforge.net/projects/source-han-sans.adobe/files/SourceHanSansOTF-${PV}.zip"
SRC_URI="mirror://sourceforge/source-han-sans.adobe/${MY_PN}-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 amd64 x86"
IUSE=""

RESTRICT="mirror"

S="${WORKDIR}/${MY_PN}-${PV}"
FONT_S="${S}"

FONT_SUFFIX="otf"
