# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

QQ_INSTALLER="PCQQ2021"
DP_QQ_VER="9.3.2deepin20"
DEB_PN="com.qq.im.deepin"

DESCRIPTION="Tencent QQ on Deepin Wine(${DEB_PN}) For Gentoo"
HOMEPAGE="https://aur.archlinux.org/packages/deepin-wine-qq"

_MIRROR="https://com-store-packages.uniontech.com"
_MIRROR_LIB="https://community-packages.deepin.com/deepin/pool/main"
SRC_URI="
	${_MIRROR}/appstore/pool/appstore/c/${DEB_PN}/${DEB_PN}_${DP_QQ_VER}_i386.deb
	${_MIRROR_LIB}/o/openldap/libldap-2.4-2_2.4.47+dfsg.4-1+eagle_i386.deb
	${_MIRROR_LIB}/c/cyrus-sasl2/libsasl2-2_2.1.27.1-1+dde_i386.deb
	https://github.com/vufa/deepin-wine-qq-arch/releases/download/v${PV}-1/${P}-1-x86_64.pkg.tar.zst
"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
QA_PREBUILT="*"

RDEPEND="
	app-emulation/deepin-wine-helper
	app-emulation/deepin-wine5
	media-fonts/noto-cjk
	media-fonts/wqy-microhei
	media-libs/alsa-lib[abi_x86_32]
	media-libs/libpulse[abi_x86_32]
	media-libs/openal[abi_x86_32]
	media-plugins/alsa-plugins[abi_x86_32]
	media-sound/mpg123[abi_x86_32]
	>=net-nds/openldap-2.4.0[abi_x86_32]
	x11-apps/xwininfo
"

DEPEND="${RDEPEND}"

BDEPEND="
	app-arch/p7zip
	sys-apps/coreutils
	virtual/awk
"

S=${WORKDIR}

src_prepare() {
	default

	local app_file="${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop"
	sed -i "s/\(Categories.*$\)/\1Network;/" ${app_file} || die
	sed -i "s/run.sh\".*/run.sh\"/" ${app_file} || die

	7z x -aoa "${S}/opt/apps/${DEB_PN}/files/files.7z" -o"${S}/deepinqqdir" || die
	rm -rf "${S}/deepinqqdir/drive_c/Program Files/Tencent/QQ" || die

	ln -sf "/usr/share/fonts/wqy-microhei/wqy-microhei.ttc" "${S}/deepinqqdir/drive_c/windows/Fonts/wqy-microhei.ttc" || die
	if [ -f "${DISTDIR}/${P}-${QQ_INSTALLER}.exe" ]; then
		# User provided ${P}-${QQ_INSTALLER}.exe" installer
		install -m644 "${DISTDIR}/${P}-${QQ_INSTALLER}.exe" "${S}/deepinqqdir/drive_c/Program Files/Tencent/${QQ_INSTALLER}-${PV}.exe" || die
	fi
	7z a -t7z -r "${S}/files.7z" "${S}/deepinqqdir/*" || die
	# Fix to avoid downgrading openldap
	mkdir -p "${S}/opt/apps/${DEB_PN}/files/lib32" || die
	cp -rf "${S}"/usr/lib/i386-linux-gnu/* "${S}/opt/apps/${DEB_PN}/files/lib32" || die
	# Generate run.sh
	cp -rf "${FILESDIR}"/${P}-run.sh "${S}"/run.sh || die
	sed -i "s/APPVER=.*/APPVER=\"${DP_QQ_VER}\"/g" "${S}"/run.sh
	sed -i "s/QQ_VER=.*/QQ_VER=\"${PV}\"/g" "${S}"/run.sh
	# Generate files.md5sum to fit DeployApp in run.sh
	# https://github.com/vufa/deepin-wine-wechat-arch/issues/217
	md5sum "${S}/files.7z" | awk '{ print $1 }' >  "${S}/opt/apps/${DEB_PN}/files/files.md5sum" || die
}

src_install() {
	local OPN="opt/apps/${DEB_PN}"

	insinto "${OPN}"/files
	exeinto "${OPN}"/files

	doins -r "${S}"/"${OPN}"/files/lib32 "${S}"/"${OPN}"/files/files.md5sum "${S}"/files.7z
	doexe "${S}"/run.sh

	insinto /usr/share/icons
	doins -r  "${S}"/"${OPN}"/entries/icons/hicolor
	#local size
	#for size in 16 24 32 48 64 128 256 ; do
	#	newicon -s ${size}  "${S}"/"${OPN}"/entries/icons/hicolor/${size}x${size}/${DEB_PN}.svg
	#done

	domenu "${S}"/"${OPN}"/entries/applications/"${DEB_PN}".desktop
}

pkg_postinst() {
	ewarn "Because deepin changed DeployApp, QQ will be reinstalled after"
	ewarn "upgrading from the old version."
	xdg_icon_cache_update
}
