# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PV="${PV/_p/_}"
_QQDownloadURLPrefix="https://dldir1v6.qq.com/qqfile/qq/QQNT/Linux"
_LiteLoader_PV="1.3.0"

DESCRIPTION="The new version of the official linux-qq"
HOMEPAGE="https://im.qq.com/linuxqq/index.shtml"

SRC_URI="
	amd64? ( ${_QQDownloadURLPrefix}/QQ_${MY_PV}_amd64_01.deb )
	arm64? ( ${_QQDownloadURLPrefix}/QQ_${MY_PV}_arm64_01.deb )
	loong? ( ${_QQDownloadURLPrefix}/QQ_${MY_PV}_loongarch64_01.deb )
	liteloader? (
		https://github.com/LiteLoaderQQNT/LiteLoaderQQNT/releases/download/${_LiteLoader_PV}/LiteLoaderQQNT.zip \
		-> LiteLoaderQQNT-${_LiteLoader_PV}.zip
	)
"
S="${WORKDIR}"
LICENSE="Tencent"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

IUSE="bwrap system-vips gnome liteloader"

RESTRICT="strip mirror"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	virtual/krb5
	sys-apps/keyutils
	system-vips? (
		dev-libs/glib
		>=media-libs/vips-8.15.2[-pdf]
	)
	bwrap? (
		sys-apps/bubblewrap
		x11-misc/snapd-xdg-open
		x11-misc/flatpak-xdg-utils
	)
	gnome? ( dev-libs/gjs )
	media-libs/openslide
	loong? (
			virtual/loong-ow-compat
	)
"
BDEPEND="liteloader? ( app-arch/unzip )"

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${D}" || die
	if [ "${ARCH}" = "loong" ]; then
		unpacker "${DISTDIR}/QQ_${MY_PV}_loongarch64_01.deb"
	else
		unpacker "${DISTDIR}/QQ_${MY_PV}_${ARCH}_01.deb"
	fi

	# Fix KDK Wayland QQ icons
	mv "${D}/usr/share/applications/qq.desktop" "${D}/usr/share/applications/QQ.desktop" || die

	if use system-vips; then
		rm -r "${D}/opt/QQ/resources/app/sharp-lib" || die
	fi

	if use bwrap; then
		exeinto /opt/QQ
		patch "${FILESDIR}/start.sh" -o "${WORKDIR}/start_sh_patched" < "${FILESDIR}/start_sh.patch" || die
		newexe "${WORKDIR}/start_sh_patched" start.sh
		sed -i 's!/opt/QQ/qq!/opt/QQ/start.sh!' "${D}/usr/share/applications/QQ.desktop" || die
		insinto /opt/QQ/workarounds
		doins "${FILESDIR}"/{config.json,xdg-open.sh,vercmp.sh}
		fperms +x /opt/QQ/workarounds/{xdg-open.sh,vercmp.sh}

		local _base_pkgver=${PV/_p/-} || die
		local _update_pkgver=${_base_pkgver} || die
		local cur_ver=${_update_pkgver:-${base_ver}} || die
		local build_ver=${cur_ver#*-} || die

		sed -i "s|__BASE_VER__|${base_ver}|g;s|__CURRENT_VER__|${cur_ver}|g;s|__BUILD_VER__|${build_ver}|g" \
			"${D}/opt/QQ/workarounds/config.json" \
			"${D}/opt/QQ/start.sh" || die

	else
		sed -i 's!/opt/QQ/qq!/usr/bin/qq!' "${D}/usr/share/applications/QQ.desktop" || die
	fi

	if use bwrap; then
		dosym -r /opt/QQ/start.sh /usr/bin/qq
	else
		newbin "${FILESDIR}/qq.sh" qq
	fi

	sed -i 's!/usr/share/icons/hicolor/512x512/apps/qq.png!qq!' "${D}/usr/share/applications/QQ.desktop" || die
	gzip -d "${D}/usr/share/doc/linuxqq/changelog.gz" || die
	dodoc "${D}/usr/share/doc/linuxqq/changelog"
	rm -rf "${D}/usr/share/doc/linuxqq" || die

	if use liteloader; then
		unzip -qo "${DISTDIR}/LiteLoaderQQNT-${_LiteLoader_PV}.zip" -d "${D}/opt/QQ/liteloader" || die
		echo 'require("/opt/QQ/liteloader")' > "${D}/opt/QQ/resources/app/app_launcher/liteloader.js" || die
		sed -i "s:./application.asar/app_launcher/index.js:./app_launcher/liteloader.js:" \
			"${D}/opt/QQ/resources/app/package.json" || die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	if use bwrap || use liteloader; then
		elog "-EN-----------------------------------------------------------------"
		if use bwrap; then
			elog "Enabled Bubblewrap support."
			elog "If you want to download files to system download folder in QQ,"
			elog "please set the download folder to the system download folder in the QQ settings."
		fi
		if use liteloader; then
			elog "Enabled LiteLoaderQQNT support."
			elog "Relevant plugins can be download from \"https://liteloaderqqnt.github.io/\"."
			elog "Unzip downloaded plugin then put them to \"~/.config/QQ/LiteLoaderQQNT/plugins\","
			elog "changes will take effect after QQ restart."
		fi
		elog "--------------------------------------------------------------------"
		elog "-ZH-----------------------------------------------------------------"
		if use bwrap; then
			elog "启用 Bubblewrap 支持后如果要在 QQ 中下载文件至系统下载文件夹，"
			elog "请先在「设置」->「存储管理」中把下载文件夹更改为系统的下载文件夹。"
		fi
		if use liteloader; then
			elog "启用 LiteLoaderQQNT 支持后可以从“https://liteloaderqqnt.github.io/”下载相关插件，"
			elog "解压下载的插件至“~/.config/QQ/LiteLoaderQQNT/plugins”目录下，重启 QQ 后生效。"
		fi
		elog "--------------------------------------------------------------------"
	fi
}
