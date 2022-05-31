# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PGK_NAME="com.zwsoft.zw3dprofessional"
inherit unpacker xdg

DESCRIPTION="CAD/CAM software for 3D design and processing"
HOMEPAGE="https://www.zwsoft.cn/product/zw3d/linux"
SRC_URI="https://download.zwcad.com/zw3d/3d_linux/2022/ZW3D-2022-Professional-V1.0_amd64.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip mirror bindist"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libpcre
	dev-libs/libxml2
	dev-qt/qtsvg:5
	dev-qt/qtwayland:5
	media-gfx/imagemagick
	media-libs/libglvnd
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libxkbcommon
	x11-libs/libXmu
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/pango
"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/patchelf"

S=${WORKDIR}

QA_PREBUILT="*"

src_install() {
	# Install scalable icons
	mkdir -p "${S}"/usr/share/icons/hicolor/scalable/apps || die
	mv "${S}"/opt/apps/${MY_PGK_NAME}/entries/icons/hicolor/scalable/apps/*.svg "${S}"/usr/share/icons/hicolor/scalable/apps || die

	# Set RPATH for preserve-libs handling
	pushd "${S}"/opt/apps/${MY_PGK_NAME}/files || die
	local x
	for x in $(find) ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		local RPATH_ROOT="/opt/apps/${MY_PGK_NAME}/files"
		local RPATH_S="${RPATH_ROOT}/:${RPATH_ROOT}/lib/:${RPATH_ROOT}/lib/xlator/:${RPATH_ROOT}/lib/xlator/InterOp/:${RPATH_ROOT}/libqt/:${RPATH_ROOT}/libqt/plugins/designer/:${RPATH_ROOT}/lib3rd/"
		patchelf --set-rpath "${RPATH_S}" "${x}" || \
			die "patchelf failed on ${x}"
		patchelf --replace-needed libMagickCore-6.Q16.so.7 libMagickCore-7.Q16.so "${x}" || \
			die "patchelf failed on ${x}"
	done
	popd || die

	# Fix desktop files
	sed -E -i 's/^Exec=.*$/Exec=zw3d %F/g' "${S}/usr/share/applications/${MY_PGK_NAME}.desktop" || die
	sed -E -i 's/^Icon=.*$/Icon=ZW3Dprofessional/g' "${S}/usr/share/applications/${MY_PGK_NAME}.desktop" || die
	sed -E -i 's/Application;//g' "${S}/usr/share/applications/${MY_PGK_NAME}.desktop" || die

	# Add zw3d command
	mkdir -p "${S}"/usr/bin/ || die

	cat >> "${S}"/opt/apps/${MY_PGK_NAME}/zw3d <<- EOF || die
#!/bin/sh
sh /opt/apps/${MY_PGK_NAME}/files/zw3drun.sh \$*
	EOF

	ln -s /opt/apps/${MY_PGK_NAME}/zw3d "${S}"/usr/bin/zw3d || die

	# Use system libraries
	rm -rf "${S}"/opt/apps/${MY_PGK_NAME}/files/lib3rd/libMagickCore* || die
	rm -rf "${S}"/opt/apps/${MY_PGK_NAME}/files/lib3rd/libjpeg* || die

	# Install package and fix permissions
	insinto /opt/apps
	doins -r opt/apps/${MY_PGK_NAME}
	insinto /usr
	doins -r usr/*

	fperms 0755 /opt/apps/${MY_PGK_NAME}/zw3d

	pushd "${S}" || die
	for x in $(find "opt/apps/${MY_PGK_NAME}") ; do
		# Fix shell script permissions
		[[ "${x: -3}" == ".sh" ]] && fperms 0755 "/${x}"
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] && fperms 0755 "/${x}"
	done
	popd || die
}
