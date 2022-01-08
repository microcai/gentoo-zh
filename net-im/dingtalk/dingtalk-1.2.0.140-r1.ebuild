# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib unpacker xdg

DESCRIPTION="dingtalk"
HOMEPAGE="https://gov.dingtalk.com"
SRC_URI="https://dtapp-pub.dingtalk.com/dingtalk-desktop/xc_dingtalk_update/linux_deb/Release/com.alibabainc.${PN}_${PV}_amd64.deb"

LICENSE="all-rights-reserved"
KEYWORDS="-* ~amd64"
SLOT="0"

RESTRICT="strip mirror bindist"

RDEPEND="
	dev-libs/libthai
	dev-qt/qtgui
	net-nds/openldap
	media-sound/pulseaudio
	media-video/rtmpdump
	sys-libs/glibc
	sys-libs/zlib
	sys-process/procps
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
"

BDEPEND="dev-util/patchelf"

DEPEND="${RDEPEND}"

QA_PREBUILT="*"

S=${WORKDIR}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker
	# Remove the libraries that break compatibility in modern systems
	# Dingtalk will use the system libs instead
	version=$(cat opt/apps/com.alibabainc.dingtalk/files/version)
	# Use system stdc++
	rm opt/apps/com.alibabainc.dingtalk/files/${version}/libstdc++* || die
	# Use system glibc
	rm opt/apps/com.alibabainc.dingtalk/files/${version}/libm.so* || die
	# Use system zlib
	rm opt/apps/com.alibabainc.dingtalk/files/${version}/libz* || die

	# Set RPATH for preserve-libs handling
	pushd "opt/apps/com.alibabainc.dingtalk/files/${version}/" || die
	local x
	for x in $(find) ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		local rpath_root="/opt/apps/com.alibabainc.dingtalk/files/${version}"
		patchelf --set-rpath "${rpath_root}/:${rpath_root}/swiftshader/:${rpath_root}/platforminputcontexts/:${rpath_root}/imageformats/" "${x}" || \
			die "patchelf failed on ${x}"
	done
	popd || die
	# Fix fcitx5
	sed -i "s/export XMODIFIERS/#export XMODIFIERS/g" opt/apps/com.alibabainc.dingtalk/files/Elevator.sh || die
	sed -i "s/export QT_IM_MODULE/#export QT_IM_MODULE/g" opt/apps/com.alibabainc.dingtalk/files/Elevator.sh || die

	cat >> opt/apps/com.alibabainc.dingtalk/files/Elevator.sh.head <<- EOF || die
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

	cat opt/apps/com.alibabainc.dingtalk/files/Elevator.sh.head opt/apps/com.alibabainc.dingtalk/files/Elevator.sh > opt/apps/com.alibabainc.dingtalk/files/Elevator.sh.new || die
	cat opt/apps/com.alibabainc.dingtalk/files/Elevator.sh.new > opt/apps/com.alibabainc.dingtalk/files/Elevator.sh || die
	rm opt/apps/com.alibabainc.dingtalk/files/Elevator.sh.head opt/apps/com.alibabainc.dingtalk/files/Elevator.sh.new || die

	mkdir -p usr/share/applications || die
	cp opt/apps/com.alibabainc.dingtalk/entries/applications/com.alibabainc.dingtalk.desktop usr/share/applications/ || die
}
