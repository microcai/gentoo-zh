# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="${PN/-drivers/}"

inherit eutils autotools flag-o-matic multilib

DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)."
HOMEPAGE="http://support-sg.canon-asia.com/contents/SG/EN/0100392802.html"
SRC_URI="http://gdlp01.c-wss.com/gds/8/0100003928/01/${MY_PN}-source-${PV}-1.tar.gz"

LICENSE="GPL-2 cnijfilter"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"
PRINTER_USE=( mg2100 mg3100 mg4100 mg5300 mg6200 mg8200 ip4900 e500 )
PRINTER_ID=( 386 387 388 389 390 391 392 393 )
IUSE="${PRINTER_USE[@]} +servicetools"

RDEPEND="
	net-print/cnijfilter[servicetools?]
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

REQUIRED_USE="|| ( ${PRINTER_USE[@]} )"

S="${WORKDIR}/${MY_PN}-source-${PV}-1"

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

_printer_dir_build() {
	local command=$1
	local d

	[[ $# -ne 1 ]] && die "Call as: _printer_dir_build COMMAND"

	for (( i=0; i<${#PRINTER_USE[@]}; i++ )); do
		local name="${PRINTER_USE[$i]}"
		if use ${name}; then
			for d in ${DIRS_PRINTER}; do
				echo ">>> Working in: ${name}/${d}"
				pushd ${name}/${d} > /dev/null
				if [[ ${command} == econf* ]]; then
					${command} \
						--enable-progpath="${EPREFIX}/usr/bin" \
						--program-suffix=${name}
				else
					${command}
				fi
				popd > /dev/null
			done
		fi
	done
}

pkg_setup() {
	[[ -z ${LINGUAS} ]] && LINGUAS="en"

	DIRS_PRINTER="cnijfilter"
	# lgmon must be first as it is required by cngpijmon
	use servicetools && DIRS_PRINTER+=" lgmon cngpijmon printui"
}

src_prepare() {
	local d i

	# missing macros directory make aclocal fail
	mkdir printui/m4 || die

	epatch \
		"${FILESDIR}/${MY_PN}"-3.70-png.patch \
		"${FILESDIR}/${MY_PN}"-3.70-ppd.patch \
		"${FILESDIR}/${MY_PN}"-3.70-ppd2.patch \
		"${FILESDIR}/${MY_PN}"-3.70-libexec-cups.patch \
		"${FILESDIR}/${MY_PN}"-3.70-libexec-backend.patch

	_dir_build "${DIRS_PRINTER}" "eautoreconf"

	for (( i=0; i<${#PRINTER_USE[@]}; i++ )); do
		local name="${PRINTER_USE[$i]}"
		local pid="${PRINTER_ID[$i]}"
		if use ${name}; then
			mkdir -p ${name} || die
			ln -s "${S}"/${pid} ${name}/ || die
			for d in ${DIRS_PRINTER}; do
				cp -a ${d} ${name} || die
			done
		fi
	done
}

src_configure() {
	local d i

	_printer_dir_build "econf"
}

src_compile() {
	_printer_dir_build "emake"
}

src_install() {
	local _libdir="${EPREFIX}/usr/$(get_libdir)"
	local _libdir_pkg=libs_bin$(use amd64 && echo 64 || echo 32)
	local _ppddir="${EPREFIX}/usr/share/cups/model"

	_printer_dir_build "emake DESTDIR=${D} install"

	for (( i=0; i<${#PRINTER_USE[@]}; i++ )); do
		local name="${PRINTER_USE[$i]}"
		local pid="${PRINTER_ID[$i]}"
		if use ${name}; then
			dodir ${_libdir}
			# no doexe due to symlinks
			cp -a "${pid}/${_libdir_pkg}"/* "${D}/${_libdir}" || die
			exeinto ${_libdir}/cnijlib
			doexe ${pid}/database/*
			# create symlink for the cnijlib to bjlib as some formats need it
			dosym ${_libdir}/cnijlib ${_libdir}/bjlib
			insinto ${_ppddir}
			doins ppd/canon${name}.ppd
		fi
	done
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
