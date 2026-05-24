# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

MY_PV="${PV//./_}"
APP_HOME="/opt/${PN}"

DESCRIPTION="Room acoustics, loudspeaker and audio device measurement software"
HOMEPAGE="https://www.roomeqwizard.com/"
# Use the no-JRE installer so the ebuild depends on Gentoo's Java 8 runtime
# instead of installing upstream's bundled private JVM.
SRC_URI="https://www.roomeqwizard.com/installers/REW_linux_no_jre_${MY_PV}.sh -> ${P}.sh"
S="${WORKDIR}/${P}"

LICENSE="REW-EULA"
SLOT="0"
KEYWORDS="~amd64"
# The EULA forbids distribution of copies, so mirrors and binary packages are
# disabled. Upstream also ships prebuilt native audio libraries.
RESTRICT="bindist mirror strip"

BDEPEND="
	app-arch/libarchive
	virtual/jre:1.8
"
RDEPEND="
	${DEPEND}
	media-libs/alsa-lib
	virtual/jre:1.8
	x11-misc/xdg-utils
"

QA_PREBUILT="${APP_HOME#/}/libcsjsound_*.so"

src_unpack() {
	local java_home jar unpack200

	mkdir "${S}" || die

	# The install4j .sh file is not a plain archive:
	# - first comes the shell launcher,
	# - then a zip payload with the application jars and native libraries,
	# - finally a gzip tarball with install4j runtime jars.
	# Extract the payloads directly instead of running the GUI installer.
	tail -c +19182 "${DISTDIR}/${A}" > "${T}/payload.zip" || die
	bsdtar -xf "${T}/payload.zip" -C "${S}" || die

	tail -c 3170552 "${DISTDIR}/${A}" > "${T}/sfx_archive.tar.gz" || die
	bsdtar -xzf "${T}/sfx_archive.tar.gz" -C "${S}/.install4j" \
		i4jruntime.jar launcherd9d2fef3.jar || die

	for vm in $(java-config-2 -n --list-available-vms 2>/dev/null | sed -n 's/.*\[\([^]]*-8\)\].*/\1/p'); do
		java_home=$(java-config-2 -n --select-vm="${vm}" --jre-home 2>/dev/null) || continue
		[[ -x ${java_home}/bin/unpack200 ]] && break
		java_home=
	done

	[[ -n ${java_home} ]] || die "Java 8 unpack200 was not found"
	unpack200="${java_home}/bin/unpack200"

	# install4j stores many dependency jars in Pack200 format while keeping
	# their .jar names. They must be expanded before Java can load classes
	# from them; the upstream GUI installer normally performs this step.
	for jar in "${S}"/*.jar "${S}"/.i4j_external_1608/*.jar; do
		[[ -f ${jar} ]] || continue
		if "${unpack200}" "${jar}" "${jar}.unpacked" >/dev/null 2>&1; then
			mv "${jar}.unpacked" "${jar}" || die
		else
			rm -f "${jar}.unpacked" || die
		fi
	done
}

src_install() {
	insinto "${APP_HOME}"
	doins ./*.jar EULA.html
	doins .i4j_external_1608/csjsound-provider-1.0.jar

	insinto "${APP_HOME}/.install4j"
	# RoomEQ_Wizard_obf.jar imports install4j runtime classes at startup.
	doins .install4j/i4jruntime.jar .install4j/launcherd9d2fef3.jar
	doins .install4j/roomeqwizard.png

	insinto "${APP_HOME}"
	# Only amd64 is keyworded and tested.
	java-pkg_sointo "${APP_HOME}"
	java-pkg_doso .i4j_external_1608/libcsjsound_amd64.so

	newins .i4j_external_896/roomeqwizard.vmoptions roomeqwizard.vmoptions

	# Register the upstream jars with java-config. java-pkg_doso recorded the
	# JNI library path above, so the launcher gets all runtime paths from Gentoo.
	java-pkg_regjar "${ED}${APP_HOME}"/.install4j/*.jar "${ED}${APP_HOME}"/*.jar

	# The generated launcher uses java-config-2. The prelude keeps REW's own
	# update checks disabled and loads upstream's install4j JVM options file.
	java-pkg_dolauncher roomeqwizard \
		--main roomeqwizard.RoomEQ_Wizard \
		--pwd "${EPREFIX}${APP_HOME}" \
		-pre "${FILESDIR}/roomeqwizard-pre"
	dosym roomeqwizard /usr/bin/rew

	doicon -s 256 .install4j/roomeqwizard.png
	make_desktop_entry roomeqwizard "Room EQ Wizard" roomeqwizard "AudioVideo;Audio;"
}
