# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools flag-o-matic multilib

DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)."
HOMEPAGE="http://support-sg.canon-asia.com/contents/SG/EN/0100469302.html"
SRC_URI="http://gdlp01.c-wss.com/gds/3/0100004693/01/${PN}-source-${PV}-1.tar.gz"

LICENSE="GPL-2 cnijfilter"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+net +servicetools"

RDEPEND="
	>=media-libs/libpng-1.5
	>=media-libs/tiff-3.4
	>=net-print/cups-1.4
	servicetools? (
		>=dev-libs/libxml2-2.7.3-r2
		>=x11-libs/gtk+-2.6:2
	)
"
DEPEND="${DEPEND}
	sys-devel/gettext
"

S="${WORKDIR}/${PN}-source-${PV}-1"

_dir_build() {
	local dirs=$1
	local command=$2
	local d

	[[ $# -ne 2 ]] && die "Call as: _dir_build DIRS COMMAND"

	for d in ${dirs}; do
		local suffix=""
		echo ">>> Working in: ${d}"
		pushd ${d} >/dev/null
		# progpath must be set otherwise we go for /usr/local/bin
		if [[ ${command} == econf* ]]; then
			${command} --enable-progpath="${EPREFIX}/usr/bin"
		else
			${command}
		fi
		popd > /dev/null
	done
}

pkg_setup() {
	[[ -z ${LINGUAS} ]] && LINGUAS="en"

	DIRS="libs pstocanonij backend"
	use net && DIRS+=" backendnet"
	#use servicetools && DIRS+=" cngpij cngpijmon/cnijnpr"
	use servicetools && DIRS+=" cngpij"
}

src_prepare() {
	local d i

	epatch \
		"${FILESDIR}/${PN}"-3.70-png.patch \
		"${FILESDIR}/${PN}"-3.70-ppd.patch \
		"${FILESDIR}/${PN}"-3.70-ppd2.patch \
		"${FILESDIR}/${PN}"-3.70-libexec-cups.patch \
		"${FILESDIR}/${PN}"-3.70-libexec-backend.patch \
		"${FILESDIR}/${P}"-cups1.6.patch

	_dir_build "${DIRS}" "eautoreconf"
}

src_configure() {
	local d i

	_dir_build "${DIRS}" "econf"
}

src_compile() {
	_dir_build "${DIRS}" "emake"
}

src_install() {
	local _libdir="${EPREFIX}/usr/$(get_libdir)"
	local _libdir_pkg=libs_bin$(use amd64 && echo 64 || echo 32)

	_dir_build "${DIRS}" "emake DESTDIR=${D} install"

	if use net; then
		pushd com/${_libdir_pkg} > /dev/null
		dodir ${_libdir}
		# no doexe to preserve symlinks
		cp -a libcnnet.so* "${D}/${_libdir}" || die
		popd > /dev/null
	fi
}

pkg_postinst() {
	einfo ""
	einfo "For installing a printer:"
	einfo " * Restart CUPS: /etc/init.d/cupsd restart"
	einfo " * Go to http://127.0.0.1:631/"
	einfo "   -> Printers -> Add Printer"
	einfo ""
	einfo "If you experience any problems, please visit:"
	einfo " http://forums.gentoo.org/viewtopic-p-3217721.html"
	einfo ""
}
