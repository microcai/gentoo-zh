# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-hazkey"

inherit xdg

DESCRIPTION="Japanese input method for Fcitx5, powered by azooKey engine"
HOMEPAGE="https://hazkey.hiira.dev/ https://github.com/7ka-Hiira/hazkey"
SRC_URI="amd64? ( https://github.com/7ka-Hiira/hazkey/releases/download/${PV}/${MY_PN}-${PV}-x86_64.tar.gz -> ${P}-x86_64.tar.gz )"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="5"
KEYWORDS="-* ~amd64"

RDEPEND="
	>=app-i18n/fcitx-5.0.4:5
	dev-qt/qtbase:6[gui,network,widgets]
	media-libs/vulkan-loader
"

QA_PREBUILT="
	usr/lib*/fcitx5/fcitx5-hazkey.so
	usr/lib*/hazkey/hazkey-server
	usr/lib*/hazkey/hazkey-settings
	usr/lib*/hazkey/libllama/*.so
	usr/lib*/hazkey/libllama/backends/*.so
"

src_install() {
	cp -a usr "${ED}" || die

	local deb_libdir="${ED}/usr/lib/x86_64-linux-gnu"
	local gentoo_libdir="${ED}/usr/$(get_libdir)"
	dodir "/usr/$(get_libdir)"
	mv "${deb_libdir}"/* "${gentoo_libdir}" || die
	rmdir "${deb_libdir}" || die
	rmdir "${ED}/usr/lib" || die

	sed -i \
		-e "s:/usr/lib/x86_64-linux-gnu:/usr/$(get_libdir):" \
		-e 's|ENV_FILE="$XDG_CONFIG_HOME/hazkey/env"|ENV_FILE="${XDG_CONFIG_HOME:-${HOME}/.config}/hazkey/env"|' \
		-e 's:source "$ENV_FILE":. "$ENV_FILE":' \
		"${ED}/usr/bin/hazkey-server" || die

	rm "${ED}/usr/bin/hazkey-settings" || die
	dosym "../$(get_libdir)/hazkey/hazkey-settings" /usr/bin/hazkey-settings
}
