# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit meson

DESCRIPTION="Archlinux's binary package manager"
HOMEPAGE="https://archlinux.org/pacman/ https://wiki.archlinux.org/title/Pacman"

if [[ "${PV}" == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.archlinux.org/pacman.git"
else
	SRC_URI="https://sources.archlinux.org/other/pacman/${P}.tar.xz"
	# Do *not* re-add ~x86!
	# https://www.archlinux.org/news/phasing-out-i686-support/
	KEYWORDS="-* ~amd64"
fi

LICENSE="GPL-2"
SLOT="0/10"

IUSE="curl doc +gpg test"
DEPEND="
	app-crypt/archlinux-keyring
	app-arch/libarchive:=[lzma]
	gpg? ( >=app-crypt/gpgme-1.13.0:= )
	curl? ( net-misc/curl )
	dev-libs/openssl:0=
	virtual/libiconv
	virtual/libintl
"
RDEPEND="
	${DEPEND}
	sys-apps/pacman-mirrorlist
"
BDEPEND="
	app-text/asciidoc
	doc? ( app-doc/doxygen )
	test? (
		sys-apps/fakeroot
		sys-apps/fakechroot
	)
"

# Plenty tests fail because we're actually not on a archlinux system.
RESTRICT="test"

src_configure() {
	local emesonargs=(
		-Dbuildstatic=false
		# Help protect Gentoo users from shooting into their feet.
		-Droot-dir="${EPREFIX}/var/chroot/archlinux"
		# full doc with doxygen
		$(meson_feature doc doxygen)
		$(meson_feature gpg gpgme)
		$(meson_use curl libcurl)
	)
	if [[ "${PV}" == *9999 ]]; then
		emesonargs+=( -Duse-git-version=true )
	fi
	meson_src_configure
}

pkg_postinst() {

	/usr/bin/pacman-key --init || die
	/usr/bin/pacman-key --populate archlinux || die

	einfo
	einfo "The default root dir was set to ${EPREFIX}/var/chroot/archlinux"
	einfo "to avoid breaking Gentoo systems due to oscitancy."
	einfo "If you prefer another directory, take a look at"
	einfo "pacman's parameter -r|--root."
	einfo
	einfo "You will need to setup at least one mirror in"
	einfo "   /etc/pacman.d/mirrorlist."
	einfo "This list is installed by sys-apps/pacman-mirrorlist but can be"
	einfo "updated manually by fetching from"
	einfo "https://wiki.archlinux.org/index.php/Mirror"
	einfo
	einfo "With pacman 5.1 contrib packages were moved into a seprate package."
	einfo
}
