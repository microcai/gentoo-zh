# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

SHERPA_ONNX_VER="1.13.2"

DESCRIPTION="Voice input addon for Fcitx5 with local and cloud ASR"
HOMEPAGE="https://github.com/xifan2333/fcitx5-vinput"
SHERPA_ONNX_URL="https://github.com/k2-fsa/sherpa-onnx/releases/download/v${SHERPA_ONNX_VER}"
SRC_URI="
	https://github.com/xifan2333/fcitx5-vinput/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	amd64? (
		${SHERPA_ONNX_URL}/sherpa-onnx-v${SHERPA_ONNX_VER}-linux-x64-shared-no-tts.tar.bz2
			-> sherpa-onnx-v${SHERPA_ONNX_VER}-linux-x64.tar.bz2
	)
	arm64? (
		${SHERPA_ONNX_URL}/sherpa-onnx-v${SHERPA_ONNX_VER}-linux-aarch64-shared-cpu.tar.bz2
			-> sherpa-onnx-v${SHERPA_ONNX_VER}-linux-aarch64.tar.bz2
	)
"

S="${WORKDIR}/${P}"

sherpa_onnx_dir() {
	if use amd64; then
		echo "${WORKDIR}/sherpa-onnx-v${SHERPA_ONNX_VER}-linux-x64-shared-no-tts"
	elif use arm64; then
		echo "${WORKDIR}/sherpa-onnx-v${SHERPA_ONNX_VER}-linux-aarch64-shared-cpu"
	fi
}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="strip"

RDEPEND="
	app-arch/libarchive
	app-i18n/fcitx:5
	dev-cpp/cli11
	dev-cpp/nlohmann_json
	dev-libs/openssl
	dev-qt/qtbase:6[gui,network,widgets]
	media-video/pipewire
	net-misc/curl
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qttools:6
	sys-devel/gettext
	virtual/pkgconfig
"

QA_PREBUILT="
	usr/lib/fcitx5-vinput/libonnxruntime.so*
	usr/lib/fcitx5-vinput/libsherpa-onnx-c-api.so*
	usr/lib/fcitx5-vinput/libsherpa-onnx-cxx-api.so*
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_PREFIX_PATH="$(sherpa_onnx_dir)"
		-DCMAKE_INSTALL_PREFIX=/usr
		-DVINPUT_FETCH_CLI11=OFF
		-DVINPUT_RUNTIME_MODE=bundled
	)

	cmake_src_configure
}
