# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils toolchain-funcs

DESCRIPTION="Chinese Lunar Calendar conversion utility"
HOMEPAGE="https://packages.debian.org/unstable/utils/lunar"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/l/${PN}/${PN}_${PVR/r5/9}.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

PATCHES=(
	"${WORKDIR}/debian/patches/01_strip_trailing_whitespace.diff"
	"${WORKDIR}/debian/patches/02_fix_compiler_warnings.diff"
	"${WORKDIR}/debian/patches/03_add_full_path_to_lunar_bitmap.diff"
	"${WORKDIR}/debian/patches/04_add_big5_and_utf8_output.diff"
	"${WORKDIR}/debian/patches/05_fix_output_on_year_2033.diff"
	"${WORKDIR}/debian/patches/06_use_locale_and_current_date.diff"
	"${WORKDIR}/debian/patches/07_fix_segfault_aggressive-loop-optimizations.diff"
	"${WORKDIR}/debian/patches/10_complete_the_makefile.diff"
	"${WORKDIR}/debian/patches/20_update_man_page.diff"
	"${WORKDIR}/debian/patches/22_datetime-go-back_Zhi.hour_jiealert.patch"
)

src_install() {
	dobin lunar || die "dobin failed"
	doman lunar.1 || die "doman failed"
	insinto /usr/share/lunar
	doins lunar.bitmap || die "doins failed"
}
