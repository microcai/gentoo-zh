# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="pkg.deepin.io/dde/daemon"
EGO_VENDOR=( 
"github.com/msteinert/pam f29b9f28d6f9a1f6c4e6fd5db731999eb946574b" 
"github.com/axgle/mahonia 3358181d7394e26beccfae0ffde05193ef3be33a"
"gopkg.in/alecthomas/kingpin.v2 947dcec5ba9c011838740e680966fd7087a71d0d github.com/alecthomas/kingpin"
"golang.org/x/image f315e440302883054d0c2bd85486878cb4f8572c github.com/golang/image"
"golang.org/x/net aaf60122140d3fcf75376d319f0554393160eb50 github.com/golang/net"
"golang.org/x/text f21a4dfb5e38f5895301dc265a8def02365cc3d0 github.com/golang/text"
"github.com/alecthomas/units 2efee857e7cfd4f3d0138cc3cbb1b4966962b93a"
"github.com/alecthomas/template a0175ee3bccc567396460bf5acd36800cb10c49c"
"github.com/cryptix/wav 8bdace674401f0bd3b63c65479b6a6ff1f9d5e44"
"github.com/nfnt/resize 83c6a9932646f83e3267f353373d47347b6036b2"
"github.com/gosexy/gettext 74466a0a0c4a62fea38f44aa161d4bbfbe79dd6b"
)

inherit golang-vcs-snapshot pam

DESCRIPTION="Daemon handling the DDE session settings"
HOMEPAGE="https://github.com/linuxdeepin/dde-daemon"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="grub bluetooth systemd elogind"
REQUIRED_USE="^^ ( systemd elogind )"

RDEPEND="virtual/dde-wm
		x11-libs/libxkbfile
		app-text/iso-codes
		sys-apps/accountsservice
		sys-power/acpid
		sys-fs/udisks:2
		gnome-extra/polkit-gnome
		>=dde-base/deepin-desktop-schemas-3.3.0
		net-misc/networkmanager
		gnome-base/gvfs[udisks]
		sys-libs/pam
		>sys-power/upower-0.99
		dev-libs/libnl:3
		bluetooth? ( net-wireless/bluez )
		grub? ( dde-extra/deepin-grub2-themes )
		systemd? ( sys-apps/systemd )
		elogind? ( sys-auth/elogind )
	"
DEPEND="${RDEPEND}
		dev-go/go-dbus-generator
		>=dev-go/go-gir-generator-2.0.0
		>=dev-go/go-x11-client-0.0.4
		>=dev-go/deepin-go-lib-1.2.14
		>=dev-go/dbus-factory-3.1.17
		>=dev-go/go-dbus-factory-0.0.5
		>=dde-base/dde-api-3.1.27
		>=dde-base/deepin-gettext-tools-1.0.8
		dev-libs/libinput
		dev-db/sqlite:3
		=dev-lang/python-3*
		"

src_prepare() {

	cd ${S}/src/${EGO_PN}
	eapply ${FILESDIR}/3.8.0-disable-tap-gesture.patch

	if use elogind; then
		sed -i "s|libsystemd|libelogind|g" Makefile
		sed -i "s|systemd/sd-bus.h|elogind/systemd/sd-bus.h|g" misc/pam-module/deepin_auth.c
	fi

	mkdir -p "${T}/golibdir/"
	cp -r  "${S}/src/${EGO_PN}/vendor"  "${T}/golibdir/src"
	export GOPATH="${S}:$(get_golibdir_gopath):${T}/golibdir/"

	LIBDIR=$(get_libdir)
	sed -i "s|lib/deepin-daemon|${LIBDIR}/deepin-daemon|g" Makefile
	default_src_prepare
}

src_compile() {
	cd ${S}/src/${EGO_PN}
	export PAM_MODULE_DIR=$(getpam_mod_dir)
	default_src_compile
}

src_install() {
	cd ${S}/src/${EGO_PN}
	default_src_install
}
