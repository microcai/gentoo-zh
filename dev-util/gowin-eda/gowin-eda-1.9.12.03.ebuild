# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PV="1.9.12.03"
MY_PN="Gowin_V${MY_PV}_linux"

SRC_URI="http://cdn.gowinsemi.com.cn/${MY_PN}.tar.gz"

DESCRIPTION="Gowin EDA - FPGA design suite (IDE + Programmer)"
S="${WORKDIR}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ide +programmer"

RDEPEND="
	virtual/libcrypt:=
"


pkg_pretend() {
	use ide || use programmer && elog \
		"Gowin EDA is proprietary software.\n" \
		"Please ensure you have the right to use it.\n" \
		"License: ${HOMEPAGE}"
}

src_unpack() {
	unpack ${A}
	[[ -d IDE ]] && mv IDE "${S}/ide" || die "IDE directory not found"
	[[ -d Programmer ]] && mv Programmer "${S}/programmer" || die "Programmer directory not found"
}

src_install() {
	local f

	if use ide; then
		einfo "Installing IDE..."
		local dest="/opt/${PN}-ide"
		dodir "${dest}"
		cp -a ide/* "${D}${dest}/" || die

		rm -f "${D}${dest}/lib/libfreetype.so.6" || die

		find "${D}${dest}" -type f -name "*.so" -exec chmod 755 {} \;
		find "${D}${dest}/bin" -type f -executable -exec chmod 755 {} \;
		find "${D}${dest}/bin" -type f ! -executable -exec chmod 644 {} \;
		chmod 666 "${D}${dest}/bin/gwlicense.ini" 2>/dev/null

		for f in bin/gao_{sh,analyzer} bin/gvio_{sh,analyzer} bin/gw_goeye \
		         plugins/ide/lib{StartPage,FpgaPrj}.so; do
			[[ -f "${D}${dest}/${f}" ]] && \
				sed -i 's|../../Programmer|..////Programmer|g' "${D}${dest}/${f}"
		done

		dosym "/opt/${PN}-programmer" "${dest}/Programmer"

		exeinto /usr/bin
		for script in gw_ide gw_sh; do
			cat > "${T}/${script}" <<-EOF
				#!/bin/sh
				export LD_LIBRARY_PATH=${dest}/lib
				exec ${dest}/bin/${script} "\$@"
			EOF
			doexe "${T}/${script}"
		done

		newicon -s 256 "${FILESDIR}/${PN}.png" "${PN}.png"
		make_desktop_entry "gw_ide %U" "Gowin EDA IDE" "${PN}" \
			"Development" "MimeType=application/x-gowin-eda-ide-project;"
		insinto /usr/share/mime/packages
		doins "${FILESDIR}/${PN}-ide-project.xml"
	fi

	if use programmer; then
		einfo "Installing Programmer..."
		local dest="/opt/${PN}-programmer"
		dodir "${dest}"
		cp -a programmer/* "${D}${dest}/" || die

		find "${D}${dest}/bin" -type f -executable -exec chmod 755 {} \;
		keepdir "${dest}/bin/data/"{output,lang}

		exeinto /usr/bin
		for script in programmer programmer_cli; do
			cat > "${T}/${script}" <<-EOF
				#!/bin/sh
				exec ${dest}/bin/${script} "\$@"
			EOF
			doexe "${T}/${script}"
		done

		newicon -s 256 "${FILESDIR}/${PN}.png" "${PN}.png"
		make_desktop_entry "programmer" "Gowin EDA Programmer" "${PN}" "Development"
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "IDE installed in /opt/${PN}-ide"
	elog "Run 'gw_ide' to start the IDE"
	elog "Programmer installed in /opt/${PN}-programmer"
	elog "Run 'programmer' (GUI) or 'programmer_cli' (CLI)"
	use ide && use programmer && elog \
		"IDE links to Programmer via /opt/${PN}-ide/Programmer"
}
