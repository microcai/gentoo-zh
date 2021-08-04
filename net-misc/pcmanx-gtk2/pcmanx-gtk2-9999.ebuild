# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="PCMan is a gtk+ based free BBS client"
HOMEPAGE="https://github.com/pcman-bbs/pcmanx"
EGIT_REPO_URI="${HOMEPAGE}.git"

KEYWORDS=""
SLOT="0"
LICENSE="GPL-2"
IUSE="+libnotify +proxy iplookup +wget"

COMMON_DEPEND="
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXft
	>=x11-libs/gtk+-2.4:*
"

RDEPEND="
	${COMMON_DEPEND}
	wget? ( net-misc/wget )
"

DEPEND="
	${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
"

src_prepare() {
	[[ ! -e ChangeLog && -e ./build/changelog.sh ]] && \
		./build/changelog.sh > ChangeLog
	intltoolize --copy --force --automake || die "intltoolize failed"
	eautoreconf

	# this flag crashes CTermData::memset16()
	filter-flags -ftree-vectorize
	eapply_user
}

src_configure() {
	econf $(use_enable proxy) \
		$(use_enable libnotify) \
		$(use_enable wget)\
		$(use_enable iplookup)
}
