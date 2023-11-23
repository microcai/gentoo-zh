# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="A library make use of libime to implement jyutping (粵拼) input method"
HOMEPAGE="https://github.com/fcitx/libime-jyutping"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/libime-jyutping.git"
else
	SRC_URI="https://github.com/fcitx/libime-jyutping/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SRC_URI+="
	https://download.fcitx-im.org/data/jyutping-model-20180103.tar.xz
	https://download.fcitx-im.org/data/jyutping-dict-20180104.tar.xz
"

# libime-jyutping => LGPL-2.1+
# data file derived from libpinyin and rime-jyutping => GPL-3+
LICENSE="LGPL-2.1+ GPL-3+"
SLOT="0"
IUSE="+engine test"
RESTRICT="!test? ( test )"

DEPEND="
	app-arch/zstd
	>=app-i18n/libime-1.0.6:5
	engine? (
		app-i18n/fcitx:5
		app-i18n/fcitx-chinese-addons:5
		sys-devel/gettext
	)
	>=dev-libs/boost-1.61
	dev-libs/libfmt
"
RDEPEND="${DEPEND}"

# https://github.com/fcitx/libime-jyutping/commit/cdfa5ba2404a8afe387d5a1ee741bab22d8065b7
# https://github.com/fcitx/libime-jyutping/commit/3cbd2fc2d43bee266f85c44a739b06f1e3010493
# only for this version (1.0.8)
PATCHES=(
	"${FILESDIR}/${P}-Set-install-component-for-cmake-config.patch"
	"${FILESDIR}/${P}-find-gettext-and-fcitx5Module-only-when-engine-enabled.patch"
)

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
	else
		# avoid unpacking jyutping-*.tar.xz
		unpack "${P}.tar.gz"
	fi
}

src_prepare() {
	ln -sv "${DISTDIR}/jyutping-model-20180103.tar.xz" "${S}/data" || die
	ln -sv "${DISTDIR}/jyutping-dict-20180104.tar.xz" "${S}/data" || die
	cmake_src_prepare
}

src_configure() {
	# no .codedocs, no doc
	local mycmakeargs=(
		-DENABLE_ENGINE=$(usex engine)
		-DENABLE_TEST=$(usex test)
		-DENABLE_DOC=no
	)
	cmake_src_configure
}
