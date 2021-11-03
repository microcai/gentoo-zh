# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info systemd

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/cifsd-team/ksmbd-tools.git"
else
	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc64 ~riscv ~s390 ~x86"
	SRC_URI="https://github.com/cifsd-team/ksmbd-tools/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="cifsd/ksmbd kernel server userspace utilities"
HOMEPAGE="https://github.com/cifsd-team/ksmbd-tools"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
IUSE="kerberos"

DEPEND=">=dev-libs/glib-2.40
	>=dev-libs/libnl-3.0
	kerberos? ( virtual/krb5 )"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( AUTHORS README Documentation/configuration.txt )

pkg_setup() {
	if kernel_is -lt 5 15 0; then
		eerror
		eerror "${PN} currently only supports kernel >= 5.15.0"
		eerror
		die "Upgrade to kernel >= 5.15.0 before installing ksmbd-tools"
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure(){
	econf $(use_enable kerberos krb5)
}

src_install() {
	emake DESTDIR="${D}" install
	einstalldocs

	insinto /etc/ksmbd
	doins "${S}"/smb.conf.example

	systemd_dounit "${FILESDIR}"/ksmbd.service
}
