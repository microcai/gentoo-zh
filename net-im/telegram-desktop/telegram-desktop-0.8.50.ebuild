# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

_qtver=5.5.0
_qtver_short=5.5

REPO_URI="https://github.com/telegramdesktop/tdesktop.git"
COMMIT="d32e476d96d8ef2ec2496f8929833334d4ed884a"

inherit eutils gnome2-utils fdo-mime

DESCRIPTION="Desktop client of Telegram, the messaging app."
HOMEPAGE="https://telegram.org"
SRC_URI="(
	http://download.qt-project.org/official_releases/qt/${_qtver_short}/$_qtver/single/qt-everywhere-opensource-src-${_qtver}.tar.xz
)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtkstyle"

RDEPEND="
	dev-libs/icu
	virtual/ffmpeg
	media-libs/jasper
	media-libs/libexif
	media-libs/libmng
	media-libs/libwebp
	x11-libs/libxkbcommon
	x11-libs/gtk+:2
	sys-libs/mtdev
	media-libs/openal
	media-libs/opus
	dev-libs/glib:2
	dev-libs/libappindicator
"
DEPEND="
	${RDEPEND}
	dev-vcs/git
	dev-libs/libunity
	x11-base/xorg-server[xvfb]
"
QSTATIC=${WORKDIR}/Libraries/QtStatic

src_unpack(){
	default
	mkdir -p ${WORKDIR}/Libraries
	mv qt-everywhere-opensource-src-${_qtver} ${QSTATIC}
	git clone ${REPO_URI} ${S}
	cd ${S}
	git checkout ${COMMIT}
}

src_prepare(){
	cd ${QSTATIC}
	# Telegram does 'slightly' patches Qt
	epatch ${S}/Telegram/_qt_${_qtver//./_}_patch.diff

	cd ${S}

	# Patches from AOSC
	epatch ${FILESDIR}/disable-custom-scheme-linux.patch
	epatch ${FILESDIR}/disable-updater.patch

	# Switch to libappindicator3 (dev-libs/libappindicator::gentoo-zh)
	sed -i 's/libappindicator/libappindicator3/g' Telegram/Telegram.pro

	# Upstream likes broken things
	echo 'DEFINES += "TDESKTOP_DISABLE_AUTOUPDATE"' >> Telegram/Telegram.pro
	echo 'INCLUDEPATH += "/usr/lib/glib-2.0/include"' >> Telegram/Telegram.pro
	echo 'INCLUDEPATH += "/usr/lib/gtk-2.0/include"' >> Telegram/Telegram.pro
	echo 'INCLUDEPATH += "/usr/include/opus"' >> Telegram/Telegram.pro

	# Telegram, hey, tell me what the hell is this?
	sed -i 's/\/usr\/local\/lib\/libxkbcommon.a/-lxkbcommon/g' Telegram/Telegram.pro

	# We don't have a custom id
	sed -i 's/CUSTOM_API_ID//g' Telegram/Telegram.pro
}

src_configure(){
	cd ${QSTATIC}
	optional=''

	if use gtkstyle; then
		optional='-gtkstyle'
	fi

	./configure -prefix "${WORKDIR}/qt" \
			-release \
			-opensource \
			-confirm-license \
			-qt-xcb \
			-no-opengl \
			-static \
			-nomake examples \
			-nomake tests \
			-skip qtquick1 \
			-skip qtdeclarative \
			${optional}
	
}

src_compile(){
	cd ${QSTATIC}
	emake module-qtbase module-qtimageformats
	emake module-qtbase-install_subtargets module-qtimageformats-install_subtargets
	export PATH="${FILESDIR}:${WORKDIR}/qt/bin:$PATH"
	mkdir -p ${S}/Linux/{Debug,Release}Intermediate{Style,Emoji,Lang,Updater,}
	
	# Begin the hacky build
	# Adapted from AUR package
	# It needs a fake Xorg server, in ${FILESDIR}
	for _type in debug release; do
		for x in Style Lang; do
			cd ${S}/Linux/${_type^}Intermediate${x}
			qmake CONFIG+="${_type}" ../../Telegram/Meta${x}.pro
			make || die 'Make failed'
		done

		cd ${S}/Linux/${_type^}Intermediate

		if ! [ -d ${S}/Telegram/GeneratedFiles ]; then
			qmake CONFIG+="${_type}" ../../Telegram/Telegram.pro
			awk '$1 == "PRE_TARGETDEPS" { $1=$2="" ; print }' ${S}/Telegram/Telegram.pro | xargs xvfb-run -a make || die 'Make failed'
		fi

		qmake CONFIG+=${_type} ../../Telegram/Telegram.pro
		xvfb-run -a make || die 'Make failed'
	done
}

src_install(){
	newbin ${S}/Linux/Release/Telegram telegram-desktop

	# From AOSC
	insopts -m644
	for icon_size in 16 32 48 64 128 256 512; do
		newicon -s ${icon_size} ${S}/Telegram/SourceFiles/art/icon${icon_size}.png telegram-desktop.png
	done

	insinto /usr/share/applications
	doins ${FILESDIR}/telegramdesktop.desktop
}

pkg_postinst(){
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
