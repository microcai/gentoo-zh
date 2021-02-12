# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A service menu tor upload images on Imageshack."
HOMEPAGE="http://kde-apps.org/content/show.php?content=51247"
SRC_URI="http://kde-apps.org/CONTENT/content-files/51247-${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="kde"

DEPEND=""
RDEPEND="net-misc/curl
	kde? ( kde-base/konqueror kde-base/kdialog )"

S=$WORKDIR/imageshack_upload

src_install()
{
	cd "${S}"
	exeinto /usr/bin
	doexe imageshack_upload
	dodoc README
	if use kde
	then
		insinto /usr/share/apps/konqueror/servicemenus
		doins imageshack.desktop
		insinto /usr/share/icons/hicolor/128x128/apps
		doins imageshack.png
	fi
}
