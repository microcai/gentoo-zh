# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit desktop git-r3 optfeature python-single-r1 xdg

DESCRIPTION="Multitrack non-linear video editor"
HOMEPAGE="https://github.com/jliljebl/flowblade https://jliljebl.github.io/flowblade/"
EGIT_REPO_URI="https://github.com/jliljebl/${PN}.git"
PROPERTIES="live"

S="${WORKDIR}/${P}/flowblade-trunk"

LICENSE="GPL-3+"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	')
	gnome-base/librsvg
	media-libs/mlt[ffmpeg,frei0r,gtk,python,sdl,xml,${PYTHON_SINGLE_USEDEP}]
	media-video/ffmpeg
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]
"

DOCS=(
	AUTHORS
	README
	docs/DEPENDENCIES.md
	docs/INSTALLING.md
	docs/KNOWN_ISSUES.md
	docs/RELEASE_NOTES.md
	docs/SYSTEM_REQUIREMENTS.md
)

src_prepare() {
	# USB jog/shuttle support is optional. Remove this compatibility patch after
	# https://github.com/jliljebl/flowblade/pull/1233 lands in a release.
	local usbhid
	for usbhid in Flowblade/usbhid.py Flowblade/src/usb/usbhid.py; do
		[[ -f ${usbhid} ]] || continue
		grep -q '^import usb1$' "${usbhid}" || continue
		case ${usbhid} in
			Flowblade/usbhid.py)
				eapply "${FILESDIR}/${PN}-optional-usb1-legacy-path.patch"
				;;
			Flowblade/src/usb/usbhid.py)
				eapply "${FILESDIR}/${PN}-optional-usb1-src-path.patch"
				;;
		esac
	done

	default

	local shebang_paths=( flowblade )
	[[ -d Flowblade/launch ]] && shebang_paths+=( Flowblade/launch )
	[[ -d Flowblade/src/launch ]] && shebang_paths+=( Flowblade/src/launch )
	python_fix_shebang "${shebang_paths[@]}"
}

src_install() {
	dobin flowblade

	insinto /usr/share/${PN}
	doins -r Flowblade

	domenu installdata/io.github.jliljebl.Flowblade.desktop
	doicon -s 128 installdata/io.github.jliljebl.Flowblade.png
	doman installdata/flowblade.1

	insinto /usr/share/metainfo
	doins installdata/io.github.jliljebl.Flowblade.appdata.xml

	insinto /usr/share/mime/packages
	doins installdata/io.github.jliljebl.Flowblade.xml

	python_optimize "${ED}/usr/share/${PN}/Flowblade"
	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "USB jog/shuttle support" dev-python/libusb1
	optfeature "extra LADSPA audio filters" media-plugins/swh-plugins
	optfeature "additional MLT OpenGL effects" "media-libs/mlt[opengl]"
	optfeature "Blender integration for generated media workflows" media-gfx/blender
}

pkg_postrm() {
	xdg_pkg_postrm
}
