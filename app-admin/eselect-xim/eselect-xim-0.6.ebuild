# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Manages Input Method of X"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="scim gcin oxim"

RDEPEND=">=app-admin/eselect-1.0.6
	scim? ( app-i18n/scim )
	scim? ( app-i18n/scim-bridge )
	gcin? ( app-i18n/gcin )
	oxim? ( app-i18n/oxim )"

src_install() {
	insinto /etc/eselect-xim/xim.d
	use scim && doins "${FILESDIR}/xim.d/scim"
	use gcin && doins "${FILESDIR}/xim.d/gcin"
	use oxim && doins "${FILESDIR}/xim.d/oxim"
	insinto /etc/profile.d
	doins "${FILESDIR}/xim-select.sh" || die
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}/xim.eselect" || die
}
