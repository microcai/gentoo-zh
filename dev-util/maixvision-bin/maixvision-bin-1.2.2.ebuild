# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="MaixVision - AIoT development platform"
HOMEPAGE="https://www.sipeed.com/maixvision"
SRC_URI="https://cdn.sipeed.com/maixvision/${PV}/maixvision_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}"
RESTRICT="mirror strip"

RDEPEND="
    x11-libs/gtk+:3
    media-libs/libpng
    sys-apps/dbus
"

src_unpack() {
    dpkg-deb -x "${DISTDIR}/${A}" "${S}"
}

src_install() {
    dodir /opt
    cp -r "${S}/opt/MaixVision" "${ED}/opt/" || die "Failed to copy MaixVision"

    fperms 755 /opt/MaixVision/maixvision

    domenu - <<EOF
[Desktop Entry]
Name=MaixVision
Comment=AIoT Development Platform
Exec=/opt/MaixVision/maixvision
Icon=maixvision
Terminal=false
Type=Application
Categories=Development;
EOF

    dosym ../opt/MaixVision/maixvision /usr/bin/maixvision

    local icon_source=""
    if [[ -f "${S}/opt/MaixVision/icon.png" ]]; then
        icon_source="${S}/opt/MaixVision/icon.png"
    elif find "${S}/opt/MaixVision" -name "*.png" | head -n 1; then
        icon_source=$(find "${S}/opt/MaixVision" -name "*.png" | head -n 1)
    fi

    if [[ -n "${icon_source}" ]]; then
        insinto /usr/share/icons/hicolor/64x64/apps
        newins "${icon_source}" maixvision.png
    fi
}
