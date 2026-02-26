# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MUPDF_PV="1.27.2"

DESCRIPTION="High-performance PDF reader that prioritizes screen space and control"
HOMEPAGE="https://github.com/dheerajshenoy/lektra"
SRC_URI="
	https://github.com/dheerajshenoy/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	!system-mupdf? ( https://mupdf.com/downloads/archive/mupdf-${MUPDF_PV}-source.tar.gz )
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl synctex system-mupdf"

DEPEND="
	dev-qt/qtbase:6[concurrent,gui,widgets]
	curl? ( net-misc/curl )
	synctex? ( app-text/texlive-core )
	system-mupdf? ( app-text/mupdf )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
"

pkg_setup() {
	if use system-mupdf; then
		eerror "The system-mupdf USE flag is currently not supported."
		eerror "There is no suitable mupdf version available in the Gentoo portage tree."
		eerror "Please disable the system-mupdf USE flag to use the bundled mupdf version."
		die "No suitable mupdf version available in portage tree"
	fi
}

src_prepare() {
	if use system-mupdf; then
		PATCHES+=(
			"${FILESDIR}/${PN}-0.6.4-system-mupdf.patch"
		)
	else
		# Setup bundled mupdf
		mkdir -p "${S}/external" || die
		mv "${WORKDIR}/mupdf-${MUPDF_PV}-source" "${S}/external/mupdf" || die

		# CMake 4 dropped compatibility with cmake_minimum_required() < 3.5.
		# Upstream mupdf bundles thirdparty projects with very old minimum
		# requirements which will hard-fail with CMake 4. See #951350 & #964405.
		local cmake_min_required_fixes=(
			external/mupdf/thirdparty/freeglut/CMakeLists.txt
			external/mupdf/thirdparty/freeglut/progs/test-shapes-gles1/CMakeLists.txt
			external/mupdf/thirdparty/curl/CMakeLists.txt
			external/mupdf/thirdparty/leptonica/CMakeLists.txt
			external/mupdf/thirdparty/freetype/CMakeLists.txt
		)
		local f
		for f in "${cmake_min_required_fixes[@]}"; do
			if [[ -f ${S}/${f} ]]; then
				sed -i -E \
					-e 's/^(\s*cmake_minimum_required\s*\(\s*VERSION\s+)[0-9.]+/\13.15/I' \
					-e 's/^(\s*CMAKE_MINIMUM_REQUIRED\s*\(\s*VERSION\s+)[0-9.]+/\13.15/' \
					"${S}/${f}" || die "sed failed for ${f}"
			fi
		done
	fi

	cmake_src_prepare
}

src_compile() {
	if ! use system-mupdf; then
		# Build mupdf first
		einfo "Building bundled mupdf ${MUPDF_PV}..."
		emake -C "${S}/external/mupdf" -j$(nproc) \
			build=release \
			HAVE_X11=no \
			HAVE_GLUT=no \
			XCFLAGS="-fPIC"
	fi

	# Build lektra
	cmake_src_compile
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_LLM_SUPPORT=$(usex curl ON OFF)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Fix doc path: upstream installs to /usr/share/doc/lektra,
	# but Gentoo requires /usr/share/doc/${PF}
	if [[ -d "${ED}/usr/share/doc/${PN}" && "${PN}" != "${PF}" ]]; then
		mv "${ED}/usr/share/doc/${PN}"/* "${ED}/usr/share/doc/${PF}/" || die
		rmdir "${ED}/usr/share/doc/${PN}" || die
	fi
}
