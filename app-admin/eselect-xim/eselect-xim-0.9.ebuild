# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Manages Input Method of X"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="scim gcin oxim ibus hime"

RDEPEND=">=app-admin/eselect-1.0.6
	scim? ( app-i18n/scim )
	scim? ( app-i18n/scim-bridge )
	gcin? ( app-i18n/gcin )
	oxim? ( app-i18n/oxim )
	ibus? ( app-i18n/ibus )
	hime? ( app-i18n/hime )"

src_install() {
	dodir /etc/eselect-xim/
	insinto /usr/share/eselect-xim/xim.d
	use scim && doins "${FILESDIR}/xim.d/scim"
	use gcin && doins "${FILESDIR}/xim.d/gcin"
	use oxim && doins "${FILESDIR}/xim.d/oxim"
	use ibus && doins "${FILESDIR}/xim.d/ibus"
	use hime && doins "${FILESDIR}/xim.d/hime"

#	insinto /etc/profile.d
#	doins "${FILESDIR}/xim-select.sh" || die
	exeinto /etc/X11/xinit/xinitrc.d
	newexe "${FILESDIR}/xim-select.sh" 99-xim-select
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}/xim.eselect" || die
}
