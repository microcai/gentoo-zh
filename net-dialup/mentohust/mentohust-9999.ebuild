# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools subversion

DESCRIPTION="A Ruijie and Cernet supplicant on Linux and MacOS"
HOMEPAGE="http://code.google.com/p/mentohust/"
ESVN_REPO_URI="http://mentohust.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug libnotify +nls +arp +encryptpwd"

RDEPEND="
	net-libs/libpcap
	libnotify? ( x11-libs/libnotify )
	"
DEPEND="${RDEPEND}"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	sh autogen.sh
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable libnotify notify) \
		$(use_enable debug) \
		$(use_enable arp) \
		$(use_enable encryptpwd encodepass)

	emake || die "emake failed"
}
