# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="Golang IDE by JetBrains"
HOMEPAGE="https://www.jetbrains.com/go/"
SRC_URI="
	amd64? ( https://download.jetbrains.com/go/${P}.tar.gz )
	arm64? ( https://download.jetbrains.com/go/${P}-aarch64.tar.gz )
"
S="${WORKDIR}/GoLand-${PV}"
LICENSE="|| ( JetBrains-business JetBrains-classroom JetBrains-educational JetBrains-individual )
	Apache-2.0
	BSD
	CC0-1.0
	CDDL
	CDDL-1.1
	EPL-1.0
	GPL-2
	GPL-2-with-classpath-exception
	ISC
	LGPL-2.1
	LGPL-3
	MIT
	MPL-1.1
	OFL-1.1
	ZLIB
"
SLOT="0/2024"
KEYWORDS="~amd64 ~arm64"
IUSE="wayland"

RESTRICT="bindist mirror"
QA_PREBUILT="opt/${P}/*"

BDEPEND="
	dev-util/debugedit
	dev-util/patchelf
"
RDEPEND="
	>=virtual/jre-17:*
	dev-lang/go
	dev-libs/wayland
	sys-libs/pam
	sys-process/audit
"

src_prepare() {
	default

	local remove_me=(
		lib/async-profiler/aarch64
		plugins/go-plugin/lib/dlv/linuxarm/dlv
	)

	rm -rv "${remove_me[@]}" || die

	# removing debug symbols and relocating debug files as per #876295
	# we're escaping all the files that contain $() in their name
	# as they should not be executed
	find . -type f ! -name '*$(*)*' -exec sh -c '
		if file "{}" | grep -qE "ELF (32|64)-bit"; then
			objcopy --remove-section .note.gnu.build-id "{}"
			debugedit -b "${EPREFIX}/opt/${PN}" -d "/usr/lib/debug" -i "{}"
		fi
	' \;

	patchelf --set-rpath '$ORIGIN' "jbr/lib/libjcef.so" || die
	patchelf --set-rpath '$ORIGIN' "jbr/lib/jcef_helper" || die

	# As per https://blog.jetbrains.com/platform/2024/07/wayland-support-preview-in-2024-2/ for full wayland support
	if use wayland; then
		echo "-Dawt.toolkit.name=WLToolkit" >> bin/webstorm64.vmoptions || die
	fi
}

src_install() {
	local dir="/opt/${P}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{format.sh,goland.sh,inspect.sh,ltedit.sh,remote-dev-server.sh,restarter,fsnotifier}
	fperms 755 "${dir}"/jbr/bin/{java,javac,javadoc,jcmd,jdb,jfr,jhsdb,jinfo,jmap,jps,jrunscript,jstack,jstat,keytool,rmiregistry,serialver}
	fperms 755 "${dir}"/jbr/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}
	fperms 755 "${dir}"/plugins/go-plugin/lib/dlv/linux/dlv

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	newicon "bin/${PN}.png" "${PN}.png"
	make_desktop_entry "${PN}" "Goland ${PV}" "${PN}" "Development;IDE;"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	insinto /usr/lib/sysctl.d
	newins - 30-"${PN}"-inotify-watches.conf <<<"fs.inotify.max_user_watches = 524288"
}
