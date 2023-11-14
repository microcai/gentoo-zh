# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=6.0
NUGETS="
automapper@12.0.1
clowd.squirrel@2.10.2
diffplex@1.7.1
discordrichpresence@1.2.1.24
ffmpeg.autogen@4.3.0.1
fody@6.8.0
hidsharpcore@1.2.1.1
htmlagilitypack@1.11.54
humanizer@2.14.1
humanizer.core@2.14.1
humanizer.core.af@2.14.1
humanizer.core.ar@2.14.1
humanizer.core.az@2.14.1
humanizer.core.bg@2.14.1
humanizer.core.bn-bd@2.14.1
humanizer.core.cs@2.14.1
humanizer.core.da@2.14.1
humanizer.core.de@2.14.1
humanizer.core.el@2.14.1
humanizer.core.es@2.14.1
humanizer.core.fa@2.14.1
humanizer.core.fi-fi@2.14.1
humanizer.core.fr@2.14.1
humanizer.core.fr-be@2.14.1
humanizer.core.he@2.14.1
humanizer.core.hr@2.14.1
humanizer.core.hu@2.14.1
humanizer.core.hy@2.14.1
humanizer.core.id@2.14.1
humanizer.core.is@2.14.1
humanizer.core.it@2.14.1
humanizer.core.ja@2.14.1
humanizer.core.ko-kr@2.14.1
humanizer.core.ku@2.14.1
humanizer.core.lv@2.14.1
humanizer.core.ms-my@2.14.1
humanizer.core.mt@2.14.1
humanizer.core.nb@2.14.1
humanizer.core.nb-no@2.14.1
humanizer.core.nl@2.14.1
humanizer.core.pl@2.14.1
humanizer.core.pt@2.14.1
humanizer.core.ro@2.14.1
humanizer.core.ru@2.14.1
humanizer.core.sk@2.14.1
humanizer.core.sl@2.14.1
humanizer.core.sr@2.14.1
humanizer.core.sr-latn@2.14.1
humanizer.core.sv@2.14.1
humanizer.core.th-th@2.14.1
humanizer.core.tr@2.14.1
humanizer.core.uk@2.14.1
humanizer.core.uz-cyrl-uz@2.14.1
humanizer.core.uz-latn-uz@2.14.1
humanizer.core.vi@2.14.1
humanizer.core.zh-cn@2.14.1
humanizer.core.zh-hans@2.14.1
humanizer.core.zh-hant@2.14.1
jetbrains.annotations@2022.3.1
managed-midi@1.10.0
markdig@0.23.0
messagepack@2.5.129
messagepack.annotations@2.5.129
microsoft.aspnetcore.connections.abstractions@7.0.12
microsoft.aspnetcore.http.connections.client@7.0.12
microsoft.aspnetcore.http.connections.common@7.0.12
microsoft.aspnetcore.signalr.client@7.0.12
microsoft.aspnetcore.signalr.client.core@7.0.12
microsoft.aspnetcore.signalr.common@7.0.12
microsoft.aspnetcore.signalr.protocols.json@7.0.12
microsoft.aspnetcore.signalr.protocols.messagepack@7.0.12
microsoft.aspnetcore.signalr.protocols.newtonsoftjson@7.0.12
microsoft.codeanalysis.bannedapianalyzers@3.3.4
microsoft.csharp@4.5.0
microsoft.csharp@4.7.0
microsoft.data.sqlite.core@7.0.12
microsoft.diagnostics.netcore.client@0.2.61701
microsoft.diagnostics.runtime@2.0.161401
microsoft.dotnet.platformabstractions@2.0.3
microsoft.extensions.configuration.abstractions@7.0.0
microsoft.extensions.dependencyinjection@6.0.0-rc.1.21451.13
microsoft.extensions.dependencyinjection@7.0.0
microsoft.extensions.dependencyinjection.abstractions@6.0.0-rc.1.21451.13
microsoft.extensions.dependencyinjection.abstractions@7.0.0
microsoft.extensions.dependencymodel@2.0.3
microsoft.extensions.features@7.0.12
microsoft.extensions.logging@7.0.0
microsoft.extensions.logging.abstractions@7.0.0
microsoft.extensions.logging.abstractions@7.0.1
microsoft.extensions.objectpool@5.0.11
microsoft.extensions.options@7.0.0
microsoft.extensions.options@7.0.1
microsoft.extensions.primitives@7.0.0
microsoft.netcore.app.host.linux-arm@6.0.12
microsoft.netcore.app.host.linux-arm64@6.0.12
microsoft.netcore.app.host.linux-musl-arm@6.0.12
microsoft.netcore.app.host.linux-musl-arm64@6.0.12
microsoft.netcore.app.host.linux-musl-x64@6.0.12
microsoft.netcore.platforms@1.0.1
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@2.0.0
microsoft.netcore.platforms@5.0.0
microsoft.netcore.targets@1.0.1
microsoft.netcore.targets@1.1.0
microsoft.net.stringtools@17.6.3
microsoft.toolkit.highperformance@7.1.2
microsoft.win32.primitives@4.3.0
microsoft.win32.registry@4.5.0
microsoft.win32.registry@5.0.0
mongodb.bson@2.19.1
mono.posix.netstandard@1.0.0
nativelibraryloader@1.0.13
netstandard.library@1.6.1
netstandard.library@2.0.0
newtonsoft.json@13.0.1
newtonsoft.json@13.0.3
nuget.common@5.11.0
nuget.configuration@5.11.0
nuget.dependencyresolver.core@5.11.0
nuget.frameworks@5.11.0
nuget.librarymodel@5.11.0
nuget.packaging@5.11.0
nuget.projectmodel@5.11.0
nuget.protocol@5.11.0
nuget.versioning@5.11.0
nunit@3.13.3
opentabletdriver@0.6.3
opentabletdriver.configurations@0.6.3
opentabletdriver.native@0.6.3
opentabletdriver.plugin@0.6.3
polysharp@1.10.0
ppy.localisationanalyser@2023.712.0
ppy.managedbass@2022.1216.0
ppy.managedbass.fx@2022.1216.0
ppy.managedbass.mix@2022.1216.0
ppy.osu.framework@2023.1111.0
ppy.osu.framework.nativelibs@2023.1013.0-nativelibs
ppy.osu.framework.sourcegeneration@2023.720.0
ppy.osu.game.resources@2023.1110.0
ppy.osutk.ns20@1.0.211
ppy.sdl2-cs@1.0.671-alpha
ppy.veldrid@4.9.3-g91ce5a6cda
ppy.veldrid.metalbindings@4.9.3-g91ce5a6cda
ppy.veldrid.openglbindings@4.9.3-g91ce5a6cda
ppy.veldrid.spirv@1.0.15-gca6cec7843
realm@11.5.0
realm.platformhelpers@11.5.0
remotion.linq@2.2.0
runtime.any.system.collections@4.3.0
runtime.any.system.diagnostics.tools@4.3.0
runtime.any.system.diagnostics.tracing@4.3.0
runtime.any.system.globalization@4.3.0
runtime.any.system.globalization.calendars@4.3.0
runtime.any.system.io@4.3.0
runtime.any.system.reflection@4.3.0
runtime.any.system.reflection.extensions@4.3.0
runtime.any.system.reflection.primitives@4.3.0
runtime.any.system.resources.resourcemanager@4.3.0
runtime.any.system.runtime@4.3.0
runtime.any.system.runtime.handles@4.3.0
runtime.any.system.runtime.interopservices@4.3.0
runtime.any.system.text.encoding@4.3.0
runtime.any.system.text.encoding.extensions@4.3.0
runtime.any.system.threading.tasks@4.3.0
runtime.any.system.threading.timer@4.3.0
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.native.system@4.0.0
runtime.native.system@4.3.0
runtime.native.system.io.compression@4.3.0
runtime.native.system.net.http@4.3.0
runtime.native.system.net.security@4.3.0
runtime.native.system.security.cryptography.apple@4.3.0
runtime.native.system.security.cryptography.openssl@4.3.0
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.unix.microsoft.win32.primitives@4.3.0
runtime.unix.system.console@4.3.0
runtime.unix.system.diagnostics.debug@4.3.0
runtime.unix.system.io.filesystem@4.3.0
runtime.unix.system.net.primitives@4.3.0
runtime.unix.system.net.sockets@4.3.0
runtime.unix.system.private.uri@4.3.0
runtime.unix.system.runtime.extensions@4.3.0
sentry@3.40.0
sharpcompress@0.33.0
sharpcompress@0.34.1
sharpfnt@2.0.0
sharpgen.runtime@2.0.0-beta.13
sharpgen.runtime.com@2.0.0-beta.13
sixlabors.imagesharp@2.1.0
sqlitepclraw.bundle_e_sqlite3@2.1.6
sqlitepclraw.core@2.1.4
sqlitepclraw.core@2.1.6
sqlitepclraw.lib.e_sqlite3@2.1.6
sqlitepclraw.provider.e_sqlite3@2.1.6
stbisharp@1.1.0
system.appcontext@4.1.0
system.appcontext@4.3.0
system.buffers@4.3.0
system.buffers@4.5.1
system.collections@4.0.11
system.collections@4.3.0
system.collections.concurrent@4.3.0
system.collections.immutable@1.7.1
system.componentmodel.annotations@5.0.0
system.console@4.3.0
system.diagnostics.debug@4.0.11
system.diagnostics.debug@4.3.0
system.diagnostics.diagnosticsource@4.3.0
system.diagnostics.tools@4.3.0
system.diagnostics.tracing@4.3.0
system.dynamic.runtime@4.0.11
system.dynamic.runtime@4.3.0
system.formats.asn1@5.0.0
system.globalization@4.0.11
system.globalization@4.3.0
system.globalization.calendars@4.3.0
system.globalization.extensions@4.3.0
system.io@4.1.0
system.io@4.3.0
system.io.compression@4.3.0
system.io.compression.zipfile@4.3.0
system.io.filesystem@4.0.1
system.io.filesystem@4.3.0
system.io.filesystem.primitives@4.3.0
system.io.packaging@7.0.0
system.io.pipelines@7.0.0
system.linq@4.1.0
system.linq@4.3.0
system.linq.expressions@4.1.0
system.linq.expressions@4.3.0
system.linq.queryable@4.0.1
system.memory@4.5.3
system.memory@4.5.4
system.memory@4.5.5
system.net.http@4.3.0
system.net.nameresolution@4.3.0
system.net.primitives@4.3.0
system.net.security@4.3.0
system.net.sockets@4.3.0
system.net.webheadercollection@4.3.0
system.net.websockets@4.3.0
system.net.websockets.client@4.3.2
system.objectmodel@4.0.12
system.objectmodel@4.3.0
system.private.uri@4.3.0
system.reflection@4.1.0
system.reflection@4.3.0
system.reflection.emit@4.0.1
system.reflection.emit@4.3.0
system.reflection.emit.ilgeneration@4.0.1
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.lightweight@4.0.1
system.reflection.emit.lightweight@4.3.0
system.reflection.extensions@4.0.1
system.reflection.extensions@4.3.0
system.reflection.metadata@1.8.1
system.reflection.primitives@4.0.1
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.1.0
system.reflection.typeextensions@4.3.0
system.resources.resourcemanager@4.0.1
system.resources.resourcemanager@4.3.0
system.runtime@4.1.0
system.runtime@4.3.0
system.runtime.compilerservices.unsafe@4.7.1
system.runtime.compilerservices.unsafe@5.0.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.compilerservices.unsafe@6.0.0-rc.1.21451.13
system.runtime.extensions@4.1.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.3.0
system.runtime.interopservices@4.3.0
system.runtime.interopservices.runtimeinformation@4.0.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.runtime.numerics@4.3.0
system.security.accesscontrol@4.5.0
system.security.accesscontrol@5.0.0
system.security.claims@4.3.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.cng@4.3.0
system.security.cryptography.cng@5.0.0
system.security.cryptography.csp@4.3.0
system.security.cryptography.encoding@4.3.0
system.security.cryptography.openssl@4.3.0
system.security.cryptography.pkcs@5.0.0
system.security.cryptography.primitives@4.3.0
system.security.cryptography.protecteddata@4.4.0
system.security.cryptography.x509certificates@4.3.0
system.security.principal@4.3.0
system.security.principal.windows@4.3.0
system.security.principal.windows@4.5.0
system.security.principal.windows@5.0.0
system.text.encoding@4.0.11
system.text.encoding@4.3.0
system.text.encoding.codepages@5.0.0
system.text.encoding.extensions@4.3.0
system.text.encodings.web@7.0.0
system.text.json@7.0.3
system.text.regularexpressions@4.3.0
system.threading@4.0.11
system.threading@4.3.0
system.threading.channels@6.0.0
system.threading.channels@7.0.0
system.threading.tasks@4.0.11
system.threading.tasks@4.3.0
system.threading.tasks.extensions@4.3.0
system.threading.threadpool@4.3.0
system.threading.timer@4.3.0
system.xml.readerwriter@4.3.0
system.xml.xdocument@4.3.0
taglibsharp@2.3.0
vk@1.0.25
vortice.d3dcompiler@2.4.2
vortice.direct3d11@2.4.2
vortice.directx@2.4.2
vortice.dxgi@2.4.2
vortice.mathematics@1.4.25
zstdsharp.port@0.7.2
"

inherit dotnet-pkg desktop xdg

DESCRIPTION="rhythm is just a *click* away! "
HOMEPAGE="
	https://osu.ppy.sh
	https://github.com/ppy/osu
"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ppy/osu.git"
else
	SRC_URI="https://github.com/ppy/osu/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	# updtream supported runtime:
	# linux-{,musl-}{arm,arm64,x64,x86}
	# only tested on linux-x64
	KEYWORDS="~amd64"
	S="${WORKDIR}/osu-${PV}"
fi

SRC_URI+=" ${NUGET_URIS} "

LICENSE="MIT CC-BY-NC-4.0"
SLOT="0"

DEPEND="
	virtual/dotnet-sdk:6.0
"
RDEPEND="
	${DEPEND}
	dev-util/desktop-file-utils
	media-libs/alsa-lib
	media-video/ffmpeg
	media-libs/libsdl2
	virtual/opengl
"
BDEPEND="${DEPEND}"

DOTNET_PKG_PROJECTS=( "${S}/osu.Desktop/osu.Desktop.csproj" )

DOCS=( README.md )

src_unpack() {
	dotnet-pkg_src_unpack

	[[ ${EGIT_REPO_URI} ]] && git-r3_src_unpack
}

src_configure() {
	dotnet-pkg-base_info
	dotnet-pkg_foreach-project dotnet-pkg-base_restore
	# skip **dotnet-pkg-base_foreach-solution** here
	# avoid requiring android workloads
}

src_compile() {
	DOTNET_PKG_BUILD_EXTRA_ARGS+=(
		-f net6.0
		-p:Version="${PV}"
	)
	dotnet-pkg_src_compile
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/osu!" osu-lazer

	newicon assets/lazer.png osu-lazer.png
	domenu "${FILESDIR}/osu-lazer.desktop"

	insinto "/usr/share/mime/packages"
	doins "${FILESDIR}/x-osu-lazer.xml"

	einstalldocs
}
