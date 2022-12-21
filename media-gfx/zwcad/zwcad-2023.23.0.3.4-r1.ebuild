# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV_YEAR="$(ver_cut 1)"
MY_PV="$(ver_cut 2).$(ver_cut 3).$(ver_cut 4).$(ver_cut 5)"
MY_PGK_NAME="com.zwsoft.${PN}${MY_PV_YEAR}"
inherit desktop unpacker xdg

DESCRIPTION="CAD software for 2D drawing, reviewing and printing work"
HOMEPAGE="https://www.zwsoft.cn/product/zwcad/linux"

SRC_URI="
	https://home-store-packages.uniontech.com/appstore/pool/appstore/c/${MY_PGK_NAME}/${MY_PGK_NAME}_${MY_PV}_amd64.deb -> ${P}.deb
	https://anaconda.org/anaconda/python/3.7.13/download/linux-64/python-3.7.13-h12debd9_0.tar.bz2 -> ${PN}-python-3.7.13.tar.bz2
"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip mirror bindist"

RDEPEND="
	media-libs/fontconfig
	media-libs/libglvnd
	|| ( media-libs/tiff:0/0 media-libs/tiff-compat:4 )
	sys-apps/util-linux
	sys-libs/zlib
	virtual/libcrypt:=
"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/patchelf"

S=${WORKDIR}

QA_PREBUILT="*"

src_unpack() {
	unpack_deb "${DISTDIR}/${P}.deb"
	tar -xf "${DISTDIR}/${PN}-python-3.7.13.tar.bz2" -C "${S}/opt/apps/"${MY_PGK_NAME}"/files/ZwPyRuntime/python3.7/" || die
}

src_install() {
	# Install scalable icons
	doicon -s scalable "${S}"/opt/apps/${MY_PGK_NAME}/files/Icons/ZWCAD.svg

	# Fix python and QA problems about python
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/ZwPyRuntime/python3.6/" || die
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/libZwPythonLoad6.so" || die
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/ZwPyRuntime/python3.5/" || die
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/libZwPythonLoad5.so" || die
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/ZwPyRuntime/python3.4/" || die
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/libZwPythonLoad4.so" || die
	rm -rf "${S}/opt/apps/"${MY_PGK_NAME}"/files/ZwPyRuntime/python3.7/compiler_compat" || die

	# Set RPATH for preserve-libs handling
	pushd "${S}"/opt/apps/${MY_PGK_NAME}/files || die
	local x
	for x in $(find) ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f "${x}" && "${x: -2}" != ".o" && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		local RPATH_ROOT="/opt/apps/${MY_PGK_NAME}/files"
		local RPATH_S="${RPATH_ROOT}/:${RPATH_ROOT}/lib/:${RPATH_ROOT}/lib/mono/lib/:${RPATH_ROOT}/plugins/:${RPATH_ROOT}/zh-CN/:${RPATH_ROOT}/ZwPyRuntime/python3.7/lib"
		patchelf --set-rpath "${RPATH_S}" "${x}" || \
			die "patchelf failed on ${x}"
	done
	popd || die

	# Fix desktop files
	sed -E -i 's/^Exec=.*$/Exec=zwcad %F/g' "${S}/opt/apps/${MY_PGK_NAME}/entries/applications/${MY_PGK_NAME}.desktop" || die
	sed -E -i 's/^Icon=.*$/Icon=ZWCAD/g' "${S}/opt/apps/${MY_PGK_NAME}/entries/applications/${MY_PGK_NAME}.desktop" || die
	sed -E -i 's/Application;//g' "${S}/opt/apps/${MY_PGK_NAME}/entries/applications/${MY_PGK_NAME}.desktop" || die
	# The Version entry in a .desktop file doesn't refer to the version of the
	# target program. It's the version of the desktop file specification that
	# this desktop file conforms to.
	sed -E -i 's/^Version=.*$/Version=1.0/g' "${S}/opt/apps/${MY_PGK_NAME}/entries/applications/${MY_PGK_NAME}.desktop" || die
	sed -E -i 's/^Categories=.*$/Categories=Graphics;VectorGraphics;Engineering;Construction;2DGraphics;/g' "${S}/opt/apps/${MY_PGK_NAME}/entries/applications/${MY_PGK_NAME}.desktop" || die
	domenu "${S}/opt/apps/${MY_PGK_NAME}/entries/applications/${MY_PGK_NAME}.desktop"

	sed -i "1i\\export MONO_PATH=/opt/apps/${MY_PGK_NAME}/files/lib/mono/lib/mono/4.5\n" "${S}/opt/apps/${MY_PGK_NAME}/files/ZWCADRUN.sh" || die
	sed -E -i 's/export QT_IM_MODULE=fcitx//g' "${S}/opt/apps/${MY_PGK_NAME}/files/ZWCADRUN.sh" || die

	# Add zw3d command
	mkdir -p "${S}"/usr/bin/ || die

	cat >> "${S}"/opt/apps/${MY_PGK_NAME}/zwcad <<- EOF || die
#!/bin/sh
if [ -z "\${QT_IM_MODULE}" ]
then
	if [ -n "\$(pidof fcitx5)" ]
	then
		export XMODIFIERS="@im=fcitx"
		export QT_IM_MODULE=fcitx
	elif [ -n "\$(pidof ibus-daemon)" ]
	then
		export XMODIFIERS="@im=ibus"
		export QT_IM_MODULE=ibus
	elif [ -n "\$(pidof fcitx)" ]
	then
		export XMODIFIERS="@im=fcitx"
		export QT_IM_MODULE=fcitx
	fi
fi
export MONO_PATH=/opt/apps/${MY_PGK_NAME}/files/lib/mono/lib/mono/4.5
sh /opt/apps/${MY_PGK_NAME}/files/ZWCADRUN.sh \$*
	EOF

	ln -s /opt/apps/${MY_PGK_NAME}/zwcad "${S}"/usr/bin/zwcad || die

	# Install package and fix permissions
	insinto /opt/apps/
	doins -r opt/apps/${MY_PGK_NAME}
	insinto /usr
	doins -r usr/*

	fperms 0755 /opt/apps/${MY_PGK_NAME}/zwcad

	pushd "${S}" || die
	for x in $(find "opt/apps/${MY_PGK_NAME}") ; do
		# Fix shell script permissions
		[[ "${x: -3}" == ".sh" ]] && fperms 0755 "/${x}"
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] && fperms 0755 "/${x}"
	done
	popd || die
}
