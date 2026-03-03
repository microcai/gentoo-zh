# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 multiprocessing systemd xdg-utils

DESCRIPTION="Linux offline voice input method based on FunASR Paraformer"
HOMEPAGE="https://github.com/LeonardNJU/VocoType-linux"

# Model version (independent of software version)
VOCOTYPE_MODEL_REV="v2.0.5"
VOCOTYPE_ASR_MODEL="speech_paraformer-large_asr_nat-zh-cn-16k-common-vocab8404-onnx"
VOCOTYPE_VAD_MODEL="speech_fsmn_vad_zh-cn-16k-common-onnx"
VOCOTYPE_PUNC_MODEL="punc_ct-transformer_zh-cn-common-vocab272727-onnx"

SRC_URI="
	https://github.com/LeonardNJU/VocoType-linux/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://modelscope.cn/models/iic/${VOCOTYPE_ASR_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/model_quant.onnx
		-> vocotype-${VOCOTYPE_MODEL_REV}-asr-model_quant.onnx
	https://modelscope.cn/models/iic/${VOCOTYPE_ASR_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/config.yaml
		-> vocotype-${VOCOTYPE_MODEL_REV}-asr-config.yaml
	https://modelscope.cn/models/iic/${VOCOTYPE_ASR_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/am.mvn
		-> vocotype-${VOCOTYPE_MODEL_REV}-asr-am.mvn
	https://modelscope.cn/models/iic/${VOCOTYPE_ASR_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/tokens.json
		-> vocotype-${VOCOTYPE_MODEL_REV}-asr-tokens.json
	https://modelscope.cn/models/iic/${VOCOTYPE_ASR_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/configuration.json
		-> vocotype-${VOCOTYPE_MODEL_REV}-asr-configuration.json
	https://modelscope.cn/models/iic/${VOCOTYPE_VAD_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/model_quant.onnx
		-> vocotype-${VOCOTYPE_MODEL_REV}-vad-model_quant.onnx
	https://modelscope.cn/models/iic/${VOCOTYPE_VAD_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/config.yaml
		-> vocotype-${VOCOTYPE_MODEL_REV}-vad-config.yaml
	https://modelscope.cn/models/iic/${VOCOTYPE_VAD_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/am.mvn
		-> vocotype-${VOCOTYPE_MODEL_REV}-vad-am.mvn
	https://modelscope.cn/models/iic/${VOCOTYPE_VAD_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/configuration.json
		-> vocotype-${VOCOTYPE_MODEL_REV}-vad-configuration.json
	https://modelscope.cn/models/iic/${VOCOTYPE_PUNC_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/model_quant.onnx
		-> vocotype-${VOCOTYPE_MODEL_REV}-punc-model_quant.onnx
	https://modelscope.cn/models/iic/${VOCOTYPE_PUNC_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/config.yaml
		-> vocotype-${VOCOTYPE_MODEL_REV}-punc-config.yaml
	https://modelscope.cn/models/iic/${VOCOTYPE_PUNC_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/tokens.json
		-> vocotype-${VOCOTYPE_MODEL_REV}-punc-tokens.json
	https://modelscope.cn/models/iic/${VOCOTYPE_PUNC_MODEL}/resolve/${VOCOTYPE_MODEL_REV}/configuration.json
		-> vocotype-${VOCOTYPE_MODEL_REV}-punc-configuration.json
"

S="${WORKDIR}/VocoType-linux-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+fcitx ibus +rime systemd"
REQUIRED_USE="
	|| ( ibus fcitx )
	${PYTHON_REQUIRED_USE}
"

RDEPEND="
	dev-python/sounddevice[${PYTHON_USEDEP}]
	dev-python/librosa[${PYTHON_USEDEP}]
	dev-python/soundfile[${PYTHON_USEDEP}]
	dev-python/funasr-onnx[${PYTHON_USEDEP}]
	dev-python/jieba[${PYTHON_USEDEP}]
	ibus? (
		app-i18n/ibus[python,${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	)
	fcitx? (
		app-i18n/fcitx:5
	)
	rime? (
		dev-python/pyrime[${PYTHON_USEDEP}]
		app-i18n/librime
	)
"
DEPEND="
	fcitx? (
		app-i18n/fcitx:5
		dev-cpp/nlohmann_json
	)
"
BDEPEND="
	fcitx? (
		dev-build/cmake
	)
"

# Tests are post-install validation scripts requiring a deployed user
# environment ($HOME/.local/, running Rime), not suitable for ebuild sandbox
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${P}-download-models.patch"
	"${FILESDIR}/${P}-fcitx5-system-install.patch"
)

src_prepare() {
	default

	# Fix deprecated project.license table format (PEP 639)
	sed -i 's/^license = { file = "LICENSE" }/license = "GPL-3.0-or-later"/' pyproject.toml || die

	# Fix IBus component XML paths for system-wide installation
	if use ibus; then
		sed -i \
			-e "s|VOCOTYPE_EXEC_PATH|/usr/libexec/ibus-engine-vocotype|g" \
			-e "s|VOCOTYPE_VERSION|${PV}|g" \
			data/ibus/vocotype.xml.in || die
	fi

	# Copy rime_handler into app/ so it gets installed via distutils
	if use fcitx; then
		cp fcitx5/backend/rime_handler.py app/rime_handler.py || die
	fi
}

src_configure() {
	distutils-r1_src_configure

	if use fcitx; then
		local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
			-DCMAKE_INSTALL_LIBDIR="$(get_libdir)"
		)
		cmake -S "${S}/fcitx5/addon" -B "${S}/fcitx5/addon/build" \
			"${mycmakeargs[@]}" || die "cmake configure failed"
	fi
}

src_compile() {
	distutils-r1_src_compile

	if use fcitx; then
		cmake --build "${S}/fcitx5/addon/build" -j$(makeopts_jobs) || die "cmake build failed"
	fi
}

python_install() {
	distutils-r1_python_install

	# Per-implementation script installs
	if use ibus; then
		python_scriptinto /usr/libexec
		python_newscript ibus/main.py ibus-engine-vocotype
	fi

	if use fcitx; then
		python_scriptinto /usr/bin
		python_newscript fcitx5/backend/fcitx5_server.py vocotype-fcitx5-backend
	fi
}

src_install() {
	distutils-r1_src_install

	# IBus component
	if use ibus; then
		insinto /usr/share/ibus/component
		newins data/ibus/vocotype.xml.in vocotype.xml
	fi

	# Fcitx5 addon
	if use fcitx; then
		# Install C++ addon shared library
		exeinto "/usr/$(get_libdir)/fcitx5"
		doexe "${S}/fcitx5/addon/build/vocotype.so"

		# Install addon config
		insinto /usr/share/fcitx5/addon
		doins fcitx5/data/vocotype.conf

		# Install input method config
		insinto /usr/share/fcitx5/inputmethod
		newins fcitx5/data/vocotype.conf.in vocotype.conf

		# Install audio recorder script for C++ addon to invoke
		insinto /usr/share/vocotype
		doins fcitx5/backend/audio_recorder.py

		# systemd user service
		if use systemd; then
			systemd_douserunit "${FILESDIR}/vocotype-fcitx5-backend.service"
		fi

		# XDG autostart for non-systemd setups
		insinto /etc/xdg/autostart
		doins "${FILESDIR}/vocotype-fcitx5-backend.desktop"
	fi

	# Install pre-packaged models
	local asr_files=( model_quant.onnx config.yaml am.mvn tokens.json configuration.json )
	local vad_files=( model_quant.onnx config.yaml am.mvn configuration.json )
	local punc_files=( model_quant.onnx config.yaml tokens.json configuration.json )

	local f
	insinto "/usr/share/vocotype/models/${VOCOTYPE_ASR_MODEL}"
	for f in "${asr_files[@]}"; do
		newins "${DISTDIR}/vocotype-${VOCOTYPE_MODEL_REV}-asr-${f}" "${f}"
	done

	insinto "/usr/share/vocotype/models/${VOCOTYPE_VAD_MODEL}"
	for f in "${vad_files[@]}"; do
		newins "${DISTDIR}/vocotype-${VOCOTYPE_MODEL_REV}-vad-${f}" "${f}"
	done

	insinto "/usr/share/vocotype/models/${VOCOTYPE_PUNC_MODEL}"
	for f in "${punc_files[@]}"; do
		newins "${DISTDIR}/vocotype-${VOCOTYPE_MODEL_REV}-punc-${f}" "${f}"
	done
}

pkg_postinst() {
	xdg_icon_cache_update

	elog "VoCoType has been installed."
	elog ""
	if use ibus; then
		elog "For IBus: restart ibus-daemon and add VoCoType in IBus settings."
		elog "  ibus restart"
		elog ""
	fi
	if use fcitx; then
		elog "For Fcitx5: start the backend service and restart Fcitx5."
		if use systemd; then
			elog "  systemctl --user enable --now vocotype-fcitx5-backend.service"
		fi
		elog "  fcitx5 -r"
		elog ""
	fi
	elog "Usage: Press and hold F9 to speak, release to recognize."
}

pkg_postrm() {
	xdg_icon_cache_update
}
