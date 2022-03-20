# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PGK_NAME="com.alibabainc.dingtalk"
inherit unpacker xdg

DESCRIPTION="Communication platform that supports video and audio conferencing"
HOMEPAGE="https://gov.dingtalk.com"
SRC_URI="https://dtapp-pub.dingtalk.com/dingtalk-desktop/xc_dingtalk_update/linux_deb/Release/com.alibabainc.${PN}_${PV}_amd64.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="strip mirror bindist"

RDEPEND="
	dev-libs/libthai
	dev-qt/qtgui
	net-nds/openldap
	media-sound/pulseaudio
	media-video/rtmpdump
	net-misc/curl
	sys-libs/glibc
	sys-libs/zlib
	sys-process/procps
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
"

DEPEND="${RDEPEND}"

BDEPEND="dev-util/patchelf"

S=${WORKDIR}

QA_PREBUILT="*"

src_install() {
	# Move ${MY_PGK_NAME} out from /opt/apps
	mkdir -p "${S}"/usr/share/icons/hicolor/scalable/apps || die
	mv "${S}"/opt/apps/"${MY_PGK_NAME}" "${S}"/opt/"${MY_PGK_NAME}" || die
	cp "${FILESDIR}"/dingtalk.svg "${S}"/usr/share/icons/hicolor/scalable/apps || die
	# Remove the libraries that break compatibility in modern systems
	# Dingtalk will use the system libs instead
	MY_VERSION=$(cat "${S}"/opt/"${MY_PGK_NAME}"/files/version)
	# Use system stdc++
	rm "${S}"/opt/"${MY_PGK_NAME}"/files/"${MY_VERSION}"/libstdc++* || die
	# Use system glibc
	rm "${S}"/opt/"${MY_PGK_NAME}"/files/"${MY_VERSION}"/libm.so* || die
	# Use system zlib
	rm "${S}"/opt/"${MY_PGK_NAME}"/files/"${MY_VERSION}"/libz* || die
	# Use system gtk+, or it can't be switch input method on popup window
	rm "${S}"/opt/"${MY_PGK_NAME}"/files/"${MY_VERSION}"/libgtk-x11* || die
	# Use system libcurl, fix preserved depend problem
	rm "${S}"/opt/"${MY_PGK_NAME}"/files/"${MY_VERSION}"/libcurl.so* || die

	# Set RPATH for preserve-libs handling
	pushd "${S}"/opt/"${MY_PGK_NAME}"/files/"${MY_VERSION}" || die
	local x
	for x in $(find) ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		local RPATH_ROOT="/opt/${MY_PGK_NAME}/files/${MY_VERSION}"
		patchelf --set-rpath "${RPATH_ROOT}/:${RPATH_ROOT}/swiftshader/:${RPATH_ROOT}/platforminputcontexts/:${RPATH_ROOT}/imageformats/" "${x}" || \
			die "patchelf failed on ${x}"
	done
	popd || die
	# Fix fcitx5
	sed -i "s/export XMODIFIERS/#export XMODIFIERS/g" "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh || die
	sed -i "s/export QT_IM_MODULE/#export QT_IM_MODULE/g" "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh || die

	cat >> "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh.head <<- EOF || die
#!/bin/sh
if [ -z "\${QT_IM_MODULE}" ]
then
	if [ -n "\$(pidof fcitx5)" ]
	then
		export XMODIFIERS="@im=fcitx5"
		export QT_IM_MODULE=fcitx5
	elif [ -n "\$(pidof ibus-daemon)" ]
	then
		export XMODIFIERS="@im=ibus"
		export QT_IM_MODULE=ibus
	else
		export XMODIFIERS="@im=fcitx"
		export QT_IM_MODULE=fcitx
	fi
fi
	EOF

	cat "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh.head "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh > "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh.new || die
	cat "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh.new > "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh || die
	rm "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh.head "${S}"/opt/"${MY_PGK_NAME}"/files/Elevator.sh.new || die

	# Add dingtalk command
	mkdir -p "${S}"/usr/bin/ || die
	ln -s  /opt/"${MY_PGK_NAME}"/files/Elevator.sh "${S}"/usr/bin/dingtalk || die

	# Fix file path and desktop files
	sed -E -i 's|/opt/apps|/opt|g' "${S}"/opt/"${MY_PGK_NAME}"/entries/applications/*.desktop || die
	sed -E -i 's|/opt/apps|/opt|g' "${S}"/opt/"${MY_PGK_NAME}"//files/Elevator.sh || die
	sed -E -i 's/^Icon=.*$/Icon=dingtalk/g' "${S}"/opt/"${MY_PGK_NAME}"/entries/applications/*.desktop || die

	mkdir -p usr/share/applications || die
	mv "${S}"/opt/"${MY_PGK_NAME}"/entries/applications/"${MY_PGK_NAME}".desktop usr/share/applications/ || die

	# Install package and fix permissions
	insinto /opt
	doins -r opt/${MY_PGK_NAME}
	insinto /usr
	doins -r usr/*

	pushd "${S}" || die
	for x in $(find "opt/${MY_PGK_NAME}") ; do
		# Fix shell script permissions
		[[ "${x: -3}" == ".sh" ]] && fperms 0755 "/${x}"
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] && fperms 0755 "/${x}"
	done
	popd || die
}
