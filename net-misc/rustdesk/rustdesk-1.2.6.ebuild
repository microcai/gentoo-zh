# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aes@0.8.3
	ahash@0.7.7
	ahash@0.8.6
	aho-corasick@1.1.2
	allo-isolate@0.1.20
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.16
	alsa-sys@0.3.1
	alsa@0.7.1
	android-tzdata@0.1.1
	android_log-sys@0.3.1
	android_logger@0.13.3
	android_system_properties@0.1.5
	ansi_term@0.12.1
	anstream@0.6.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	anyhow@1.0.75
	apple-bindgen@0.2.0
	apple-sdk@0.4.0
	apple-sys@0.2.0
	async-broadcast@0.5.1
	async-channel@1.9.0
	async-compression@0.4.8
	async-executor@1.6.0
	async-fs@1.6.0
	async-io@1.13.0
	async-lock@2.8.0
	async-process@1.8.1
	async-recursion@1.0.5
	async-signal@0.2.4
	async-task@4.5.0
	async-trait@0.1.79
	atk-sys@0.18.0
	atk@0.18.0
	atomic-waker@1.1.2
	atomic@0.5.3
	atty@0.2.14
	autocfg@0.1.8
	autocfg@1.1.0
	backtrace@0.3.69
	base32@0.4.0
	base64@0.21.5
	base64@0.22.0
	base64ct@1.6.0
	bindgen@0.59.2
	bindgen@0.63.0
	bindgen@0.65.1
	bindgen@0.68.1
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.4.1
	bitmask-enum@2.2.2
	bitvec@1.0.1
	block-buffer@0.10.4
	block-sys@0.1.0-beta.1
	block2@0.2.0-alpha.6
	block@0.1.6
	blocking@1.4.1
	brotli-decompressor@2.5.1
	brotli@3.4.0
	build-target@0.4.0
	bumpalo@3.14.0
	bytecount@0.6.7
	bytemuck@1.14.0
	byteorder@1.5.0
	bytes@1.6.0
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.4.4
	cairo-rs@0.18.5
	cairo-sys-rs@0.18.2
	cc@1.0.83
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-expr@0.15.5
	cfg-if@0.1.10
	cfg-if@1.0.0
	chrono@0.4.31
	cidr-utils@0.5.11
	cipher@0.4.4
	clang-sys@1.6.1
	clap@2.34.0
	clap@4.4.7
	clap_builder@4.4.7
	clap_lex@0.6.0
	clipboard-win@5.1.0
	cloudabi@0.0.3
	cmake@0.1.50
	cocoa-foundation@0.1.2
	cocoa@0.24.1
	cocoa@0.25.0
	color_quant@1.1.0
	colorchoice@1.0.0
	combine@4.6.6
	concurrent-queue@2.3.0
	console_error_panic_hook@0.1.7
	const_fn@0.4.9
	const_format@0.2.32
	const_format_proc_macros@0.2.32
	constant_time_eq@0.1.5
	constant_time_eq@0.2.6
	convert_case@0.4.0
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	core-graphics-types@0.1.2
	core-graphics@0.22.3
	core-graphics@0.23.1
	coreaudio-rs@0.11.3
	coreaudio-sys@0.2.13
	cpal@0.15.2
	cpufeatures@0.2.11
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-queue@0.3.8
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	crypto-common@0.1.6
	ctrlc@3.4.1
	dart-sys@4.0.2
	dashmap@5.5.3
	dasp@0.11.0
	dasp_envelope@0.11.0
	dasp_frame@0.11.0
	dasp_interpolate@0.11.0
	dasp_peak@0.11.0
	dasp_ring_buffer@0.11.0
	dasp_rms@0.11.0
	dasp_sample@0.11.0
	dasp_signal@0.11.0
	dasp_slice@0.11.0
	dasp_window@0.11.1
	dbus-crossroads@0.5.2
	dbus@0.9.7
	debug-helper@0.3.13
	default-net@0.14.1
	deranged@0.3.9
	derivative@2.2.0
	derive-new@0.5.9
	derive_more@0.99.17
	digest@0.10.7
	directories-next@2.0.0
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.3.7
	dirs-sys@0.4.1
	dirs@2.0.2
	dirs@5.0.1
	dispatch@0.2.0
	dlib@0.5.2
	dlopen2@0.4.1
	dlopen2_derive@0.2.0
	dlopen@0.1.8
	dlopen_derive@0.1.4
	dlv-list@0.3.0
	docopt@1.1.1
	downcast-rs@1.2.0
	dtoa@0.4.8
	ed25519@1.5.3
	either@1.9.0
	encoding_rs@0.8.34
	enquote@1.1.0
	enum-map-derive@0.14.0
	enum-map@2.7.0
	enumflags2@0.7.8
	enumflags2_derive@0.7.8
	env_logger@0.10.0
	env_logger@0.9.3
	epoll@4.3.3
	equivalent@1.0.1
	errno@0.3.5
	error-code@3.0.0
	event-listener@2.5.3
	event-listener@3.0.0
	exr@1.71.0
	fastrand@1.9.0
	fastrand@2.0.1
	fdeflate@0.3.0
	field-offset@0.3.6
	filetime@0.2.22
	fixedbitset@0.4.2
	flate2@1.0.28
	flexi_logger@0.27.3
	flume@0.11.0
	flutter_rust_bridge@1.80.1
	flutter_rust_bridge_macros@1.82.3
	fnv@1.0.7
	fon@0.6.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.1.1
	foreign-types-shared@0.3.1
	foreign-types@0.3.2
	foreign-types@0.5.0
	form_urlencoded@1.2.0
	fruitbasket@0.10.0
	fuchsia-cprng@0.1.1
	funty@2.0.0
	fuser@0.13.0
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-lite@1.13.0
	futures-macro@0.3.29
	futures-sink@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	futures@0.3.29
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.5
	gdk-sys@0.18.0
	gdk@0.18.0
	gdkwayland-sys@0.18.0
	gdkx11-sys@0.18.0
	generic-array@0.14.7
	gethostname@0.3.0
	gethostname@0.4.3
	getrandom@0.2.10
	gif@0.12.0
	gimli@0.28.0
	gio-sys@0.18.1
	gio@0.18.4
	git2@0.16.1
	glib-macros@0.10.1
	glib-macros@0.18.5
	glib-sys@0.10.1
	glib-sys@0.18.1
	glib@0.10.3
	glib@0.18.5
	glob@0.3.1
	gobject-sys@0.10.0
	gobject-sys@0.18.0
	gstreamer-app-sys@0.9.1
	gstreamer-app@0.16.5
	gstreamer-base-sys@0.9.1
	gstreamer-base@0.16.5
	gstreamer-sys@0.9.1
	gstreamer-video-sys@0.9.1
	gstreamer-video@0.16.7
	gstreamer@0.16.7
	gtk-sys@0.18.0
	gtk3-macros@0.18.0
	gtk@0.18.1
	h2@0.3.26
	half@2.2.1
	hashbrown@0.12.3
	hashbrown@0.14.2
	heck@0.3.3
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.3
	hex@0.4.3
	hmac@0.12.1
	home@0.5.5
	hound@3.5.1
	html-escape@0.2.13
	http-body@0.4.6
	http@0.2.12
	httparse@1.8.0
	httpdate@1.0.3
	humantime@2.1.0
	hyper-rustls@0.24.2
	hyper-tls@0.5.0
	hyper@0.14.28
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.58
	idna@0.4.0
	image@0.24.7
	include_dir@0.7.3
	include_dir_macros@0.7.3
	indexmap@1.9.3
	indexmap@2.0.2
	inotify-sys@0.1.5
	inotify@0.10.2
	inout@0.1.3
	instant@0.1.12
	io-lifetimes@1.0.11
	ipnet@2.9.0
	is-terminal@0.4.9
	is_debug@1.0.1
	itertools@0.9.0
	itoa@0.3.4
	itoa@1.0.9
	jni-sys@0.3.0
	jni@0.19.0
	jni@0.20.0
	jni@0.21.1
	jobserver@0.1.27
	jpeg-decoder@0.3.0
	js-sys@0.3.64
	kernel32-sys@0.2.2
	keyboard-types@0.7.0
	lazy_static@1.4.0
	lazycell@1.3.0
	lebe@0.5.2
	libappindicator-sys@0.9.0
	libappindicator@0.9.0
	libc@0.2.150
	libdbus-sys@0.2.5
	libgit2-sys@0.14.2+1.5.1
	libloading@0.7.4
	libloading@0.8.1
	libm@0.2.8
	libpulse-binding@2.28.1
	libpulse-simple-binding@2.28.1
	libpulse-simple-sys@1.21.1
	libpulse-sys@1.21.0
	libsamplerate-sys@0.1.12
	libsodium-sys@0.2.7
	libxdo-sys@0.11.0
	libxdo@0.6.0
	libz-sys@1.1.12
	line-wrap@0.1.1
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.10
	lock_api@0.4.11
	log@0.4.20
	mac_address@1.1.5
	mach2@0.4.1
	malloc_buf@0.0.6
	md5@0.7.0
	memalloc@0.1.0
	memchr@2.6.4
	memoffset@0.6.5
	memoffset@0.7.1
	memoffset@0.9.0
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.11
	muda@0.11.4
	muldiv@0.2.1
	native-tls@0.2.11
	ndk-context@0.1.1
	ndk-sys@0.4.1+23.1.7779620
	ndk@0.7.0
	netlink-packet-core@0.5.0
	netlink-packet-route@0.15.0
	netlink-packet-utils@0.5.2
	netlink-sys@0.8.5
	nix@0.23.2
	nix@0.24.3
	nix@0.26.4
	nix@0.27.1
	nom8@0.2.0
	nom@7.1.3
	ntapi@0.4.1
	nu-ansi-term@0.49.0
	num-bigint@0.4.4
	num-complex@0.4.4
	num-derive@0.3.3
	num-integer@0.1.45
	num-rational@0.3.2
	num-rational@0.4.1
	num-traits@0.1.43
	num-traits@0.2.17
	num_cpus@1.16.0
	num_enum@0.5.11
	num_enum_derive@0.5.11
	num_threads@0.1.6
	objc-foundation@0.1.1
	objc-sys@0.2.0-beta.2
	objc2-encode@2.0.0-pre.2
	objc2@0.3.0-beta.2
	objc@0.2.7
	objc_exception@0.1.2
	objc_id@0.1.1
	object@0.32.1
	oboe-sys@0.5.0
	oboe@0.5.0
	once_cell@1.18.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.98
	openssl@0.10.62
	option-ext@0.2.0
	ordered-multimap@0.4.3
	ordered-stream@0.2.0
	os-version@0.2.0
	os_info@3.7.0
	os_pipe@1.1.4
	osascript@0.3.0
	page_size@0.5.0
	pam-macros@0.0.3
	pango-sys@0.18.0
	pango@0.18.3
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	password-hash@0.4.2
	paste@1.0.14
	pbkdf2@0.11.0
	peeking_take_while@0.1.2
	percent-encoding@2.3.0
	petgraph@0.6.4
	phf@0.7.24
	phf_codegen@0.7.24
	phf_generator@0.7.24
	phf_shared@0.7.24
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-project@1.1.3
	pin-utils@0.1.0
	piper@0.2.1
	pkg-config@0.3.27
	plist@1.5.1
	png@0.17.10
	polling@2.8.0
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	pretty-hex@0.2.1
	prettyplease@0.2.15
	primal-check@0.3.3
	proc-macro-crate@0.1.5
	proc-macro-crate@1.3.1
	proc-macro-crate@2.0.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@0.4.30
	proc-macro2@1.0.79
	protobuf-codegen@3.4.0
	protobuf-parse@3.4.0
	protobuf-support@3.4.0
	protobuf@3.4.0
	qoi@0.4.1
	qrcode-generator@4.1.9
	qrcodegen@1.8.0
	quest@0.3.0
	quick-xml@0.30.0
	quote@0.6.13
	quote@1.0.35
	radium@0.7.0
	rand@0.6.5
	rand@0.8.5
	rand_chacha@0.1.1
	rand_chacha@0.3.1
	rand_core@0.3.1
	rand_core@0.4.2
	rand_core@0.6.4
	rand_hc@0.1.0
	rand_isaac@0.1.1
	rand_jitter@0.1.4
	rand_os@0.1.3
	rand_pcg@0.1.2
	rand_xorshift@0.1.1
	raw-window-handle@0.5.2
	raw-window-handle@0.6.0
	rayon-core@1.12.0
	rayon@1.8.0
	rdrand@0.4.0
	realfft@3.3.0
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	redox_users@0.4.3
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	repng@0.2.2
	ring@0.17.5
	ringbuf@0.3.3
	rpassword@2.1.0
	rpassword@7.2.0
	rtoolbox@0.0.1
	rubato@0.12.0
	runas@1.2.0
	rust-ini@0.18.0
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustfft@6.1.0
	rustix@0.37.27
	rustix@0.38.21
	rustls-native-certs@0.6.3
	rustls-native-certs@0.7.0
	rustls-pemfile@1.0.3
	rustls-pemfile@2.1.2
	rustls-pki-types@1.4.1
	rustls-platform-verifier-android@0.1.0
	rustls-platform-verifier@0.3.1
	rustls-webpki@0.101.7
	rustls-webpki@0.102.2
	rustls@0.21.10
	rustls@0.23.4
	rustversion@1.0.14
	ryu@1.0.15
	safemem@0.3.3
	same-file@1.0.6
	samplerate@0.2.4
	schannel@0.1.22
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	security-framework-sys@2.10.0
	security-framework@2.10.0
	semver@1.0.20
	serde@0.9.15
	serde@1.0.190
	serde_derive@1.0.190
	serde_json@0.9.10
	serde_json@1.0.107
	serde_repr@0.1.16
	serde_spanned@0.6.4
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.8
	shadow-rs@0.21.0
	shared_memory@0.12.4
	shlex@1.3.0
	shutdown_hooks@0.1.0
	signal-hook-registry@1.4.1
	signature@1.6.4
	simd-adler32@0.3.7
	siphasher@0.2.3
	slab@0.4.9
	smallvec@1.11.1
	socket2@0.3.19
	socket2@0.4.10
	socket2@0.5.5
	sodiumoxide@0.2.7
	spin@0.9.8
	static_assertions@1.1.0
	strength_reduce@0.2.4
	strsim@0.10.0
	strsim@0.8.0
	strum@0.18.0
	strum@0.24.1
	strum_macros@0.18.0
	strum_macros@0.24.3
	subtle@2.5.0
	syn@0.15.44
	syn@1.0.109
	syn@2.0.55
	sync_wrapper@0.1.2
	sys-locale@0.3.1
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	system-deps@1.3.2
	system-deps@6.1.2
	system_shutdown@4.0.1
	tap@1.0.1
	target-lexicon@0.12.12
	target_build_utils@0.3.1
	tauri-winrt-notification@0.1.3
	tempfile@3.8.1
	termcolor@1.3.0
	termios@0.3.3
	textwrap@0.11.0
	thiserror-impl@1.0.50
	thiserror@1.0.50
	threadpool@1.8.1
	tiff@0.9.0
	time-core@0.1.2
	time-macros@0.2.15
	time@0.1.45
	time@0.3.30
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.3.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-rustls@0.26.0
	tokio-socks@0.5.1
	tokio-util@0.7.10
	tokio@1.38.0
	toml@0.5.11
	toml@0.6.0
	toml@0.7.8
	toml@0.8.6
	toml_datetime@0.5.1
	toml_datetime@0.6.5
	toml_edit@0.18.1
	toml_edit@0.19.15
	toml_edit@0.20.7
	totp-rs@5.4.0
	tower-service@0.3.2
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	transpose@0.2.3
	tree_magic_mini@3.0.3
	try-lock@0.2.5
	typenum@1.17.0
	tz-rs@0.6.14
	tzdb@0.5.7
	uds_windows@1.0.2
	uname@0.1.1
	unicode-bidi@0.3.13
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	unicode-xid@0.1.0
	unicode-xid@0.2.4
	untrusted@0.9.0
	url@2.4.1
	urlencoding@2.1.3
	users@0.10.0
	users@0.11.0
	utf16string@0.2.0
	utf8-width@0.1.7
	utf8parse@0.2.1
	uuid@1.5.0
	vcpkg@0.2.15
	vec_map@0.8.2
	version-compare@0.0.10
	version-compare@0.1.1
	version_check@0.9.4
	waker-fn@1.1.1
	walkdir@2.4.0
	want@0.3.1
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasite@0.1.0
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	wayland-backend@0.3.2
	wayland-client@0.31.1
	wayland-protocols-wlr@0.2.0
	wayland-protocols@0.31.0
	wayland-scanner@0.31.0
	wayland-sys@0.31.1
	web-sys@0.3.64
	webpki-roots@0.25.4
	webpki-roots@0.26.1
	weezl@0.1.7
	which@4.4.2
	whoami@1.5.0
	widestring@1.0.2
	win-sys@0.3.1
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.2.8
	winapi@0.3.9
	windows-core@0.51.1
	windows-core@0.52.0
	windows-implement@0.52.0
	windows-interface@0.52.0
	windows-service@0.6.0
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows-version@0.1.0
	windows@0.32.0
	windows@0.34.0
	windows@0.44.0
	windows@0.46.0
	windows@0.48.0
	windows@0.51.1
	windows@0.52.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.32.0
	windows_aarch64_msvc@0.34.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.32.0
	windows_i686_gnu@0.34.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.32.0
	windows_i686_msvc@0.34.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.32.0
	windows_x86_64_gnu@0.34.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.32.0
	windows_x86_64_msvc@0.34.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winnow@0.5.17
	winreg@0.11.0
	winreg@0.50.0
	winres@0.1.12
	wl-clipboard-rs@0.8.0
	wol-rs@1.0.1
	wyz@0.5.1
	x11-dl@2.21.0
	x11@2.21.0
	x11rb-protocol@0.12.0
	x11rb-protocol@0.13.0
	x11rb@0.12.0
	x11rb@0.13.0
	xdg-home@1.0.0
	zbus@3.14.1
	zbus_macros@3.14.1
	zbus_names@2.6.0
	zerocopy-derive@0.6.6
	zerocopy-derive@0.7.32
	zerocopy@0.6.6
	zerocopy@0.7.32
	zeroize@1.7.0
	zip@0.6.6
	zstd-safe@5.0.2+zstd.1.5.2
	zstd-safe@7.0.0
	zstd-sys@2.0.9+zstd.1.5.5
	zstd@0.11.2+zstd.1.5.2
	zstd@0.13.0
	zune-inflate@0.2.54
	zvariant@3.15.0
	zvariant_derive@3.15.0
	zvariant_utils@1.0.1
"

declare -A GIT_CRATES=(
	[android-wakelock]='https://github.com/21pages/android-wakelock;d0292e5a367e627c4fa6f1ca6bdfad005dca7d90;android-wakelock-%commit%'
	[arboard]='https://github.com/fufesou/arboard;956b5f8693b4fc7fddd7b8cafbe1111a892b34b1;arboard-%commit%'
	[cacao]='https://github.com/clslaid/cacao;05e1536b0b43aaae308ec72c0eed703e875b7b95;cacao-%commit%'
	[confy]='https://github.com/rustdesk-org/confy;83db9ec19a2f97e9718aef69e4fc5611bb382479;confy-%commit%'
	[core-foundation-sys]='https://github.com/madsmtm/core-foundation-rs;7d593d016175755e492a92ef89edca68ac3bd5cd;core-foundation-rs-%commit%/core-foundation-sys'
	[core-foundation]='https://github.com/madsmtm/core-foundation-rs;7d593d016175755e492a92ef89edca68ac3bd5cd;core-foundation-rs-%commit%/core-foundation'
	[core-graphics-types]='https://github.com/madsmtm/core-foundation-rs;7d593d016175755e492a92ef89edca68ac3bd5cd;core-foundation-rs-%commit%/core-graphics-types'
	[core-graphics]='https://github.com/madsmtm/core-foundation-rs;7d593d016175755e492a92ef89edca68ac3bd5cd;core-foundation-rs-%commit%/core-graphics'
	[evdev]='https://github.com/fufesou/evdev;cec616e37790293d2cd2aa54a96601ed6b1b35a9;evdev-%commit%'
	[hwcodec]='https://github.com/21pages/hwcodec;b84d5bbefa949194d1fc51a5c7e9d7988e315ce6;hwcodec-%commit%'
	[impersonate_system]='https://github.com/21pages/impersonate-system;2f429010a5a10b1fe5eceb553c6672fd53d20167;impersonate-system-%commit%'
	[keepawake]='https://github.com/rustdesk-org/keepawake-rs;ad94454a75cf1ff9e95e217dee9dd6a378bf625e;keepawake-rs-%commit%'
	[machine-uid]='https://github.com/21pages/machine-uid;381ff579c1dc3a6c54db9dfec47c44bcb0246542;machine-uid-%commit%'
	[magnum-opus]='https://github.com/rustdesk-org/magnum-opus;5cd2bf989c148662fa3a2d9d539a71d71fd1d256;magnum-opus-%commit%'
	[mouce]='https://github.com/fufesou/mouce;ed83800d532b95d70e39915314f6052aa433e9b9;mouce-%commit%'
	[pam-sys]='https://github.com/fufesou/pam-sys;3337c9bb9a9c68d7497ec8c93cad2368c26091b7;pam-sys-%commit%'
	[pam]='https://github.com/fufesou/pam;3a2aaa6e07b176d8e2d66a5eec38d2ddb45f009f;pam-%commit%'
	[parity-tokio-ipc]='https://github.com/rustdesk-org/parity-tokio-ipc;3623ec9ebef50c9b118e03b03df831008a4d1441;parity-tokio-ipc-%commit%'
	[rdev]='https://github.com/fufesou/rdev;b3434caee84c92412b45a2f655a15ac5dad33488;rdev-%commit%'
	[reqwest]='https://github.com/rustdesk-org/reqwest;9cb758c9fb2f4edc62eb790acfd45a6a3da21ed3;reqwest-%commit%'
	[rust-pulsectl]='https://github.com/open-trade/pulsectl;5e68f4c2b7c644fa321984688602d71e8ad0bba3;pulsectl-%commit%'
	[sciter-rs]='https://github.com/open-trade/rust-sciter;fab913b7c2e779b05c249b0c5de5a08759b2c15d;rust-sciter-%commit%'
	[sysinfo]='https://github.com/rustdesk-org/sysinfo;f45dcc6510d48c3a1401c5a33eedccc8899f67b2;sysinfo-%commit%'
	[tao-macros]='https://github.com/rustdesk-org/tao;288c219cb0527e509590c2b2d8e7072aa9feb2d3;tao-%commit%/tao-macros'
	[tao]='https://github.com/rustdesk-org/tao;288c219cb0527e509590c2b2d8e7072aa9feb2d3;tao-%commit%'
	[tfc]='https://github.com/fufesou/The-Fat-Controller;9dd86151525fd010dc93f6bc9b6aedd1a75cc342;The-Fat-Controller-%commit%'
	[tokio-socks]='https://github.com/rustdesk-org/tokio-socks;94e97c6d7c93b0bcbfa54f2dc397c1da0a6e43d3;tokio-socks-%commit%'
	[tray-icon]='https://github.com/tauri-apps/tray-icon;b8dbd42c6f94a29f34b0a0daa619486277185512;tray-icon-%commit%'
	[wallpaper]='https://github.com/21pages/wallpaper.rs;ce4a0cd3f58327c7cc44d15a63706fb0c022bacf;wallpaper.rs-%commit%'
	[webm-sys]='https://github.com/21pages/rust-webm;d2c4d3ac133c7b0e4c0f656da710b48391981e64;rust-webm-%commit%/src/sys'
	[webm]='https://github.com/21pages/rust-webm;d2c4d3ac133c7b0e4c0f656da710b48391981e64;rust-webm-%commit%'
	[x11-clipboard]='https://github.com/clslaid/x11-clipboard;5fc2e73bc01ada3681159b34cf3ea8f0d14cd904;x11-clipboard-%commit%'
	[x11]='https://github.com/bjornsnoen/x11-rs;c2e9bfaa7b196938f8700245564d8ac5d447786a;x11-rs-%commit%/x11'
)

inherit cargo desktop systemd xdg

DESCRIPTION="An open-source remote desktop, and alternative to TeamViewer."
HOMEPAGE="https://rustdesk.com/"
_WEBM_PV="1.0.0.31"
_HWCODEC_DEPS_COMMIT="3c871c657272b8c386089c7889ef45f2f7a8b6b7"
_HWCODEC_EXTERNALS_COMMIT="fd2ab190c333204d51173794e39fb03d3f2dbb43"
SRC_URI="
	mirror+https://github.com/rustdesk/rustdesk/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
	mirror+https://github.com/st0nie/gentoo-deps/releases/download/vcpkg/vcpkg-20240222.tar.gz
	mirror+https://github.com/webmproject/libwebm/archive/refs/tags/libwebm-${_WEBM_PV}.tar.gz
	mirror+https://github.com/21pages/deps/archive/${_HWCODEC_DEPS_COMMIT}.tar.gz
		-> hwcodec-deps-${_HWCODEC_DEPS_COMMIT}.tar.gz
	mirror+https://github.com/21pages/externals/archive/${_HWCODEC_EXTERNALS_COMMIT}.tar.gz
		-> hwcodec-externals-${_HWCODEC_EXTERNALS_COMMIT}.tar.gz
	https://raw.githubusercontent.com/c-smile/sciter-sdk/master/bin.lnx/x64/libsciter-gtk.so
		-> ${P}-libsciter-gtk.so

	mirror+${CARGO_CRATE_URIS}
"

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0 CC0-1.0
	GPL-2 GPL-3 GPL-3+ ISC MIT MPL-2.0 openssl SSLeay Unicode-DFS-2016 Unlicense ZLIB
	Sciter
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="wayland +hwaccel"

RESTRICT="mirror"

RDEPEND="
	media-libs/alsa-lib
	x11-libs/gtk+:3
	x11-libs/libxcb
	x11-libs/libXfixes
	media-libs/libpulse
	x11-misc/xdotool
	media-libs/libva
	wayland? ( media-video/pipewire[gstreamer] )
	hwaccel? ( x11-libs/libvdpau )
"
BDEPEND="
	dev-lang/nasm
	dev-lang/yasm
	media-libs/alsa-lib
	media-libs/libpulse
	dev-build/cmake
	sys-devel/clang
	dev-build/ninja
	media-libs/gstreamer
	media-libs/gst-plugins-base
	>=virtual/rust-1.75.0
"

QA_PRESTRIPPED="
	/usr/share/${PN}/${PN}
	/usr/share/${PN}/libsciter-gtk.so
"

src_prepare() {
	PATCHES+=(
		"${FILESDIR}"/rust-sciter.patch
	)
	cd "${S}"/..

	default

	cd -
	cd ../rust-webm-*/src/sys || die
	rm -rf libwebm/ || die
	ln -s "${WORKDIR}"/libwebm-libwebm-*/ libwebm || die

	local _HWCODEC_COMMIT=`echo "${GIT_CRATES[hwcodec]}" | awk -F';' '{print $2}'`
	rm -rf "${WORKDIR}"/hwcodec-*/deps "${WORKDIR}"/hwcodec-${_HWCODEC_COMMIT}/externals || die
	ln -s "${WORKDIR}"/deps-${_HWCODEC_DEPS_COMMIT}	"${WORKDIR}"/hwcodec-${_HWCODEC_COMMIT}/deps || die
	ln -s "${WORKDIR}"/externals-${_HWCODEC_EXTERNALS_COMMIT}		"${WORKDIR}"/hwcodec-${_HWCODEC_COMMIT}/externals || die
}

src_configure() {
	if use hwaccel ;then
		local myfeatures=(hwcodec)
	fi

	cargo_src_configure
}

src_compile() {
	VCPKG_ROOT="$WORKDIR"/vcpkg cargo_src_compile
}

src_install() {
	local rustdesk_dir="/usr/share/${PN}"

	exeinto "${rustdesk_dir}"
	insinto "${rustdesk_dir}"
	doexe target/release/rustdesk
	newins "${DISTDIR}/${P}-libsciter-gtk.so" libsciter-gtk.so
	rm src/ui/*.rs || die
	newbin "${FILESDIR}/rustdesk.sh" rustdesk
	insinto "${rustdesk_dir}/src"
	doins -r src/ui

	newicon -s 32 $(realpath res/32x32.png || die) rustdesk.png
	newicon -s 128 $(realpath res/128x128.png || die) rustdesk.png
	newicon -s 256 $(realpath res/128x128@2x.png || die) rustdesk.png

	domenu "${FILESDIR}"/rustdesk{,-link}.desktop
	systemd_dounit "${FILESDIR}"/rustdesk.service

	einstalldocs
}
