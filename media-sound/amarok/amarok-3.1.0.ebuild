# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm gear.kde.org

DESCRIPTION="KDE calculator"
HOMEPAGE="https://apps.kde.org/amarok/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE="ipod lastfm mtp +mariadb wikipedia qt5 qt6 podcast"

RESTRICT="mirror"

REQUIRED_USE="^^ ( qt5 qt6 )"

SRC_URI="https://invent.kde.org/multimedia/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"

DEPEND="

	virtual/mysql
	media-libs/taglib-extras
	media-libs/taglib
	media-libs/phonon[qt5?,qt6?]

	qt6? (
		dev-qt/qttools:6
		dev-qt/qt5compat:6
		>=dev-qt/qtbase-${QTMIN}:6[gui,widgets,xml]
		dev-qt/qtdeclarative:6
		>=kde-frameworks/karchive-${KFMIN}:6
		>=kde-frameworks/kcodecs-${KFMIN}:6
		>=kde-frameworks/kconfig-${KFMIN}:6
		>=kde-frameworks/kconfigwidgets-${KFMIN}:6
		>=kde-frameworks/kcoreaddons-${KFMIN}:6
		>=kde-frameworks/kcrash-${KFMIN}:6
		>=kde-frameworks/kdbusaddons-${KFMIN}:6
		>=kde-frameworks/kdeclarative-${KFMIN}:6
		>=kde-frameworks/kdnssd-${KFMIN}:6
		>=kde-frameworks/kdoctools-${KFMIN}:6
		>=kde-frameworks/kglobalaccel-${KFMIN}:6
		>=kde-frameworks/kguiaddons-${KFMIN}:6
		>=kde-frameworks/ki18n-${KFMIN}:6
		>=kde-frameworks/kiconthemes-${KFMIN}:6
		>=kde-frameworks/kcmutils-${KFMIN}:6
		>=kde-frameworks/kio-${KFMIN}:6
		>=kde-frameworks/knotifications-${KFMIN}:6
		>=kde-frameworks/kpackage-${KFMIN}:6
		>=kde-frameworks/solid-${KFMIN}:6
		>=kde-frameworks/ktexteditor-${KFMIN}:6
		>=kde-frameworks/threadweaver-${KFMIN}:6
		>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
		>=kde-frameworks/kwindowsystem-${KFMIN}:6

		kde-frameworks/kcolorscheme:6
		kde-frameworks/kirigami:6
		kde-frameworks/kstatusnotifieritem:6
	)

	qt5? (

		dev-qt/linguist-tools
		dev-qt/qtcore:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
		dev-qt/qtsql:5

		kde-frameworks/karchive:5
		kde-frameworks/kcodecs:5
		kde-frameworks/kconfig:5
		kde-frameworks/kconfigwidgets:5
		kde-frameworks/kcoreaddons:5
		kde-frameworks/kcrash:5
		kde-frameworks/kdbusaddons:5
		kde-frameworks/kdeclarative:5
		kde-frameworks/kdnssd:5
		kde-frameworks/kdoctools:5
		kde-frameworks/kglobalaccel:5
		kde-frameworks/kguiaddons:5
		kde-frameworks/ki18n:5
		kde-frameworks/kiconthemes:5
		kde-frameworks/kcmutils:5
		kde-frameworks/kio:5
		kde-frameworks/knotifications:5
		kde-frameworks/kpackage:5
		kde-frameworks/solid:5
		kde-frameworks/ktexteditor:5
		kde-frameworks/threadweaver:5
		kde-frameworks/kwidgetsaddons:5
		kde-frameworks/kwindowsystem:5

		kde-frameworks/kirigami:5

		ipod? ( media-libs/libmygpo-qt )
	)

"
RDEPEND="${DEPEND}"

RDEPEND="${DEPEND}
	media-video/ffmpeg
"

S="${WORKDIR}/${PN}-v${PV}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_QT6=$(usex qt6)
		-DWITH_MP3Tunes=OFF
		-DWITH_PLAYER=ON
		-DWITH_UTILITIES=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Googlemock=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_LibOFA=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_MySQLe=ON
		-DWITH_IPOD=$(usex ipod)
		-DWITH_GPODDER=OFF
		$(cmake_use_find_package lastfm LibLastFm)
#		$(cmake_use_find_package !mariadb MySQL)
		$(cmake_use_find_package mtp Mtp)
		$(cmake_use_find_package wikipedia Qt6WebEngineWidgets)
	)
	use ipod && mycmakeargs+=( DWITH_GDKPixBuf=ON )
	use qt5 && use podcast && mycmakeargs+=( $(cmake_use_find_package podcast Mygpo-qt5) )

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst

	pkg_is_installed() {
		echo "${1} ($(has_version ${1} || echo "not ")installed)"
	}

	db_name() {
		use mariadb && echo "MariaDB" || echo "MySQL"
	}

	optfeature "Audio CD support" "kde-apps/audiocd-kio:6"

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "You must configure ${PN} to use an external database server."
		elog " 1. Make sure either MySQL or MariaDB is installed and configured"
		elog "    Checking local system:"
		elog "      $(pkg_is_installed dev-db/mariadb)"
		elog "      $(pkg_is_installed dev-db/mysql)"
		elog "    For preliminary configuration of $(db_name) Server refer to"
		elog "    https://wiki.gentoo.org/wiki/$(db_name)#Configuration"
		elog " 2. Ensure 'mysql' service is started and run:"
		elog "    # emerge --config amarok"
		elog " 3. Run ${PN} and go to 'Configure Amarok - Database' menu page"
		elog "    Check 'Use external MySQL database' and press OK"
		elog
		elog "For more information please read:"
		elog "  https://community.kde.org/Amarok/Community/MySQL"
	fi
}

pkg_config() {
	# Create external mysql database with amarok default user/password
	local AMAROK_DB_NAME="amarokdb"
	local AMAROK_DB_USER_NAME="amarokuser"
	local AMAROK_DB_USER_PWD="password"

	einfo "Initializing ${PN} MySQL database 'amarokdb':"
	einfo "If prompted for a password, please enter your MySQL root password."
	einfo

	if [[ -e "${EROOT}"/usr/bin/mysql ]]; then
		"${EROOT}"/usr/bin/mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS ${AMAROK_DB_NAME}; GRANT ALL PRIVILEGES ON ${AMAROK_DB_NAME}.* TO '${AMAROK_DB_USER_NAME}' IDENTIFIED BY '${AMAROK_DB_USER_PWD}'; FLUSH PRIVILEGES;"
	fi
	einfo "${PN} MySQL database 'amarokdb' successfully initialized!"
}