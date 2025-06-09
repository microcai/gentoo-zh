# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

_PN="${PN%-bin}"

DESCRIPTION="A free-to-win rhythm game. Rhythm is just a click away!"
HOMEPAGE="https://osu.ppy.sh/ https://github.com/ppy/osu"
SRC_URI="
	https://github.com/ppy/osu/releases/download/${PV}/osu.AppImage -> ${_PN}-${PV}.AppImage
	https://github.com/ppy/osu/raw/refs/heads/master/LICENCE -> ${_PN}-LICENCE
	https://github.com/ppy/osu-resources/raw/refs/heads/master/LICENCE.md -> ${_PN}-resources-LICENCE.md
"

S="${WORKDIR}"

LICENSE="MIT CC-BY-NC-4.0"
SLOT="0/tachyon"
KEYWORDS="-* ~amd64"

IUSE="complete-icon pipewire sdl2 +system-sdl"

RESTRICT="mirror"

DEPEND="
	!games-arcade/osu-lazer
	x11-themes/hicolor-icon-theme
"
RDEPEND="
	${DEPEND}
	dev-util/lttng-ust:0/2.12
	system-sdl? (
		sdl2? ( <media-libs/libsdl2-2.32.50 )
		!sdl2? ( media-libs/libsdl3 )
	)
	pipewire? (
		media-video/pipewire[pipewire-alsa]
	)
"
BDEPEND="complete-icon? ( media-gfx/imagemagick )"

src_unpack() {
	cp "${DISTDIR}/${_PN}-${PV}.AppImage" "${WORKDIR}/appimage"
	chmod +x "${WORKDIR}/appimage"
	"${WORKDIR}/appimage" --appimage-extract
}

src_prepare() {
	default

	pushd squashfs-root/usr/bin || die
	# Remove pdb files
	rm -fv *.pdb

	# Remove UpdateNix from Velopack, updates are managed by protage
	rm -fv UpdateNix

	if use system-sdl; then
		rm -fv libSDL{2,3}.so
	fi
	popd

	mkdir -v icons
	pushd icons
	if use complete-icon; then
		magick -verbose "${S}/squashfs-root/usr/bin/lazer.ico" osu.png
		magick -verbose "${S}/squashfs-root/usr/bin/beatmap.ico" beatmap.png

		eval $(magick identify -format "mv -v %f osu-%G;" osu*.png)
		eval $(magick identify -format "mv -v %f beatmap-%G;" beatmap*.png)
	fi

	for icon in "${S}"/squashfs-root/usr/share/icons/hicolor/*/apps/osu.png; do
		cp -v "${icon}" "osu-$(echo "${icon}" | sed 's/^.*\/\([0-9]\{2,4\}x[0-9]\{2,4\}\)\/.*$/\1/g')"
	done
	popd

	sed "s/%SDL3_DEFAULT%/$(usex sdl2 false true)/" "${FILESDIR}/${_PN}.bash" >"${_PN}"
}

src_install() {
	# Install game files
	insinto "/usr/lib/${_PN}"
	doins -r squashfs-root/usr/bin/*
	fperms +x "/usr/lib/${_PN}/osu!"

	# Install wrapper script
	dobin "${_PN}"

	# Install desktop file
	domenu "${FILESDIR}/${_PN}.desktop"

	# Install mime file
	insinto /usr/share/mime/packages
	doins "${FILESDIR}/${_PN}.xml"

	# Install icons
	pushd icons
	for icon in *; do
		type="${icon%-*}"
		size="${icon##*-}"

		case "${type}" in
		"osu")
			newicon --context "apps" --size "${size}" "${icon}" "${_PN}.png"
			;;
		"beatmap")
			newicon --context "mimetypes" --size "${size}" "${icon}" "${_PN%-lazer}-beatmap.png"
			;;
		esac
	done
	popd

	# Install license
	insinto "/usr/share/licenses/${_PN}"
	newins "${DISTDIR}/${_PN}-LICENCE" "${_PN}-LICENCE"
	newins "${DISTDIR}/${_PN}-resources-LICENCE.md" "${_PN}-resources-LICENCE.md"
}
