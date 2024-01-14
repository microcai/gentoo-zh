# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
		addr2line@0.19.0
		adler@1.0.2
		aes@0.7.5
		ahash@0.7.6
		aho-corasick@1.0.1
		allo-isolate@0.1.14
		alloc-no-stdlib@2.0.4
		alloc-stdlib@0.2.2
		alsa@0.7.0
		alsa-sys@0.3.1
		android_log-sys@0.3.0
		android_logger@0.13.1
		android_system_properties@0.1.5
		ansi_term@0.12.1
		anstream@0.3.2
		anstyle@1.0.0
		anstyle-parse@0.2.0
		anstyle-query@1.0.0
		anstyle-wincon@1.0.1
		anyhow@1.0.71
		arboard@3.2.0
		async-broadcast@0.5.1
		async-channel@1.8.0
		async-executor@1.5.1
		async-fs@1.6.0
		async-io@1.13.0
		async-lock@2.7.0
		async-process@1.7.0
		async-recursion@1.0.4
		async-task@4.4.0
		async-trait@0.1.68
		atk@0.16.0
		atk-sys@0.16.0
		atomic@0.5.1
		atomic-waker@1.1.1
		atty@0.2.14
		autocfg@0.1.8
		autocfg@1.1.0
		backtrace@0.3.67
		base64@0.21.0
		base64ct@1.6.0
		bindgen@0.59.2
		bindgen@0.64.0
		bindgen@0.65.1
		bit_field@0.10.2
		bitflags@1.3.2
		bitvec@1.0.1
		block@0.1.6
		block-buffer@0.10.4
		blocking@1.3.1
		brotli@3.3.4
		brotli-decompressor@2.3.4
		build-target@0.4.0
		bumpalo@3.12.2
		bytemuck@1.13.1
		byteorder@1.4.3
		bytes@1.4.0
		bzip2@0.4.4
		bzip2-sys@0.1.11+1.0.8
		cairo-rs@0.16.7
		cairo-sys-rs@0.16.3
		calloop@0.9.3
		camino@1.1.4
		cargo-platform@0.1.2
		cargo_metadata@0.14.2
		cbindgen@0.24.3
		cc@1.0.79
		cesu8@1.1.0
		cexpr@0.6.0
		cfg-expr@0.15.1
		cfg-if@0.1.10
		cfg-if@1.0.0
		chrono@0.4.24
		cidr-utils@0.5.10
		cipher@0.3.0
		clang-sys@1.6.1
		clap@2.34.0
		clap@3.2.25
		clap@4.2.7
		clap_builder@4.2.7
		clap_derive@4.2.0
		clap_lex@0.2.4
		clap_lex@0.4.1
		clipboard-win@4.5.0
		cloudabi@0.0.3
		cmake@0.1.50
		cocoa@0.24.1
		cocoa-foundation@0.1.1
		codespan-reporting@0.11.1
		color_quant@1.1.0
		colorchoice@1.0.0
		colored@1.9.3
		combine@4.6.6
		concurrent-queue@2.2.0
		console_error_panic_hook@0.1.7
		constant_time_eq@0.1.5
		convert_case@0.5.0
		core-foundation@0.7.0
		core-foundation@0.9.3
		core-foundation-sys@0.6.2
		core-foundation-sys@0.7.0
		core-foundation-sys@0.8.4
		core-graphics@0.19.2
		core-graphics@0.22.3
		core-graphics-types@0.1.1
		core-video-sys@0.1.4
		coreaudio-rs@0.11.2
		coreaudio-sys@0.2.12
		cpal@0.15.2
		cpufeatures@0.2.7
		crc32fast@1.3.2
		crossbeam-channel@0.5.8
		crossbeam-deque@0.8.3
		crossbeam-epoch@0.9.14
		crossbeam-queue@0.3.8
		crossbeam-utils@0.8.15
		crunchy@0.2.2
		crypto-common@0.1.6
		ctrlc@3.2.5
		cty@0.2.2
		cxx@1.0.94
		cxx-build@1.0.94
		cxxbridge-flags@1.0.94
		cxxbridge-macro@1.0.94
		dark-light@1.0.0
		darling@0.13.4
		darling_core@0.13.4
		darling_macro@0.13.4
		dart-sys@4.0.2
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
		dbus@0.9.7
		dbus-crossroads@0.5.2
		dconf_rs@0.3.0
		debug-helper@0.3.13
		default-net@0.14.1
		delegate@0.8.0
		derivative@2.2.0
		detect-desktop-environment@0.2.0
		digest@0.10.6
		directories-next@2.0.0
		dirs@2.0.2
		dirs@4.0.0
		dirs@5.0.1
		dirs-next@2.0.0
		dirs-sys@0.3.7
		dirs-sys@0.4.1
		dirs-sys-next@0.1.2
		dispatch@0.2.0
		dlib@0.5.0
		dlopen@0.1.8
		dlopen2@0.4.1
		dlopen2_derive@0.2.0
		dlopen_derive@0.1.4
		dlv-list@0.3.0
		docopt@1.1.1
		downcast-rs@1.2.0
		dtoa@0.4.8
		ed25519@1.5.3
		either@1.8.1
		embed-resource@2.1.1
		encoding_rs@0.8.32
		enum-iterator@1.4.1
		enum-iterator-derive@1.2.1
		enum-map@2.5.0
		enum-map-derive@0.11.0
		enum_dispatch@0.3.11
		enumflags2@0.7.7
		enumflags2_derive@0.7.7
		env_logger@0.9.3
		env_logger@0.10.0
		epoll@4.3.1
		errno@0.3.1
		errno-dragonfly@0.1.2
		error-code@2.3.1
		event-listener@2.5.3
		exr@1.6.3
		fastrand@1.9.0
		fdeflate@0.3.0
		fern@0.6.2
		field-offset@0.3.5
		filetime@0.2.21
		flate2@1.0.26
		flexi_logger@0.25.4
		flume@0.10.14
		flutter_rust_bridge@1.75.3
		flutter_rust_bridge_codegen@1.75.3
		flutter_rust_bridge_macros@1.75.3
		fnv@1.0.7
		fon@0.6.0
		foreign-types@0.3.2
		foreign-types-shared@0.1.1
		form_urlencoded@1.1.0
		fruitbasket@0.10.0
		fuchsia-cprng@0.1.1
		funty@2.0.0
		futures@0.3.28
		futures-channel@0.3.28
		futures-core@0.3.28
		futures-executor@0.3.28
		futures-io@0.3.28
		futures-lite@1.13.0
		futures-macro@0.3.28
		futures-sink@0.3.28
		futures-task@0.3.28
		futures-util@0.3.28
		gdk@0.16.2
		gdk-pixbuf@0.16.7
		gdk-pixbuf-sys@0.16.3
		gdk-sys@0.16.0
		gdkwayland-sys@0.16.0
		gdkx11-sys@0.16.0
		generic-array@0.14.7
		gethostname@0.2.3
		getrandom@0.2.9
		gif@0.12.0
		gimli@0.27.2
		gio@0.16.7
		gio-sys@0.16.3
		glib@0.10.3
		glib@0.16.7
		glib-macros@0.10.1
		glib-macros@0.16.8
		glib-sys@0.10.1
		glib-sys@0.16.3
		glob@0.3.1
		gobject-sys@0.10.0
		gobject-sys@0.16.3
		gstreamer@0.16.7
		gstreamer-app@0.16.5
		gstreamer-app-sys@0.9.1
		gstreamer-base@0.16.5
		gstreamer-base-sys@0.9.1
		gstreamer-sys@0.9.1
		gstreamer-video@0.16.7
		gstreamer-video-sys@0.9.1
		gtk@0.16.2
		gtk-sys@0.16.0
		gtk3-macros@0.16.3
		h2@0.3.18
		half@2.2.1
		hashbrown@0.12.3
		heck@0.3.3
		heck@0.4.1
		hermit-abi@0.1.19
		hermit-abi@0.2.6
		hermit-abi@0.3.1
		hex@0.4.3
		hmac@0.12.1
		hound@3.5.0
		http@0.2.9
		http-body@0.4.5
		httparse@1.8.0
		httpdate@1.0.2
		humantime@2.1.0
		hyper@0.14.26
		hyper-rustls@0.23.2
		iana-time-zone@0.1.56
		iana-time-zone-haiku@0.1.1
		ident_case@1.0.1
		idna@0.3.0
		image@0.24.6
		include_dir@0.7.3
		include_dir_macros@0.7.3
		indexmap@1.9.3
		inotify@0.10.0
		inotify-sys@0.1.5
		instant@0.1.12
		io-lifetimes@1.0.10
		ipnet@2.7.2
		is-terminal@0.4.7
		itertools@0.9.0
		itertools@0.10.5
		itoa@0.3.4
		itoa@1.0.6
		jni@0.19.0
		jni@0.20.0
		jni@0.21.1
		jni-sys@0.3.0
		jobserver@0.1.26
		jpeg-decoder@0.3.0
		js-sys@0.3.62
		kernel32-sys@0.2.2
		keyboard-types@0.6.2
		lazy_static@1.4.0
		lazycell@1.3.0
		lebe@0.5.2
		libappindicator@0.8.0
		libappindicator-sys@0.8.0
		libc@0.2.144
		libdbus-sys@0.2.5
		libloading@0.7.4
		libloading@0.8.0
		libm@0.2.6
		libpulse-binding@2.27.1
		libpulse-simple-binding@2.27.1
		libpulse-simple-sys@1.20.1
		libpulse-sys@1.20.1
		libsamplerate-sys@0.1.12
		libsodium-sys@0.2.7
		libxdo@0.6.0
		libxdo-sys@0.11.0
		line-wrap@0.1.1
		link-cplusplus@1.0.8
		linked-hash-map@0.5.6
		linux-raw-sys@0.3.7
		lock_api@0.4.9
		log@0.4.17
		mac_address@1.1.4
		mach2@0.4.1
		machine-uid@0.3.0
		malloc_buf@0.0.6
		md5@0.7.0
		memalloc@0.1.0
		memchr@2.5.0
		memmap2@0.3.1
		memoffset@0.6.5
		memoffset@0.7.1
		memoffset@0.8.0
		mime@0.3.17
		minimal-lexical@0.2.1
		miniz_oxide@0.6.2
		miniz_oxide@0.7.1
		mio@0.8.6
		miow@0.5.0
		muda@0.5.0
		muldiv@0.2.1
		nanorand@0.7.0
		ndk@0.5.0
		ndk@0.6.0
		ndk@0.7.0
		ndk-context@0.1.1
		ndk-glue@0.5.2
		ndk-macro@0.3.0
		ndk-sys@0.2.2
		ndk-sys@0.3.0
		ndk-sys@0.4.1+23.1.7779620
		netlink-packet-core@0.5.0
		netlink-packet-route@0.15.0
		netlink-packet-utils@0.5.2
		netlink-sys@0.8.5
		nix@0.22.3
		nix@0.23.2
		nix@0.24.3
		nix@0.26.2
		nom@7.1.3
		ntapi@0.4.1
		nu-ansi-term@0.46.0
		num-bigint@0.4.3
		num-complex@0.4.3
		num-derive@0.3.3
		num-integer@0.1.45
		num-rational@0.3.2
		num-rational@0.4.1
		num-traits@0.1.43
		num-traits@0.2.15
		num_cpus@1.15.0
		num_enum@0.5.11
		num_enum_derive@0.5.11
		objc@0.2.7
		objc-foundation@0.1.1
		objc_exception@0.1.2
		objc_id@0.1.1
		object@0.30.3
		oboe@0.5.0
		oboe-sys@0.5.0
		once_cell@1.17.1
		opaque-debug@0.3.0
		openssl-probe@0.1.5
		option-ext@0.2.0
		ordered-multimap@0.4.3
		ordered-stream@0.2.0
		os-version@0.2.0
		os_str_bytes@6.5.0
		osascript@0.3.0
		overload@0.1.1
		pam-macros@0.0.3
		pam-sys@1.0.0-alpha4
		pango@0.16.5
		pango-sys@0.16.3
		parking@2.1.0
		parking_lot@0.11.2
		parking_lot@0.12.1
		parking_lot_core@0.8.6
		parking_lot_core@0.9.7
		password-hash@0.4.2
		paste@1.0.12
		pathdiff@0.2.1
		pbkdf2@0.11.0
		peeking_take_while@0.1.2
		percent-encoding@2.2.0
		phf@0.7.24
		phf_codegen@0.7.24
		phf_generator@0.7.24
		phf_shared@0.7.24
		pin-project@1.0.12
		pin-project-internal@1.0.12
		pin-project-lite@0.2.9
		pin-utils@0.1.0
		pkg-config@0.3.27
		plist@1.4.3
		png@0.17.8
		polling@2.8.0
		ppv-lite86@0.2.17
		pretty-hex@0.2.1
		prettyplease@0.2.4
		primal-check@0.3.3
		proc-macro-crate@0.1.5
		proc-macro-crate@1.3.1
		proc-macro-error@1.0.4
		proc-macro-error-attr@1.0.4
		proc-macro2@0.4.30
		proc-macro2@1.0.56
		protobuf@3.2.0
		protobuf-codegen@3.2.0
		protobuf-parse@3.2.0
		protobuf-support@3.2.0
		qoi@0.4.1
		quest@0.3.0
		quick-xml@0.28.2
		quinn@0.9.3
		quinn-proto@0.9.3
		quinn-udp@0.3.2
		quote@0.6.13
		quote@1.0.27
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
		raw-window-handle@0.4.3
		raw-window-handle@0.5.2
		rayon@1.7.0
		rayon-core@1.11.0
		rdrand@0.4.0
		realfft@3.2.0
		redox_syscall@0.2.16
		redox_syscall@0.3.5
		redox_users@0.4.3
		regex@1.8.1
		regex-syntax@0.7.1
		repng@0.2.2
		reqwest@0.11.17
		ring@0.16.20
		ringbuf@0.3.3
		rpassword@2.1.0
		rpassword@7.2.0
		rtoolbox@0.0.1
		rubato@0.12.0
		runas@1.0.0
		rust-ini@0.18.0
		rustc-demangle@0.1.23
		rustc-hash@1.1.0
		rustc_version@0.4.0
		rustfft@6.1.0
		rustix@0.37.19
		rustls@0.20.8
		rustls-native-certs@0.6.2
		rustls-pemfile@1.0.2
		rustversion@1.0.12
		ryu@1.0.13
		safemem@0.3.3
		same-file@1.0.6
		samplerate@0.2.4
		schannel@0.1.21
		scoped-tls@1.0.1
		scopeguard@1.1.0
		scratch@1.0.5
		sct@0.7.0
		security-framework@2.8.2
		security-framework-sys@2.8.0
		semver@1.0.17
		serde@0.9.15
		serde@1.0.163
		serde_derive@1.0.163
		serde_json@0.9.10
		serde_json@1.0.96
		serde_repr@0.1.12
		serde_spanned@0.6.1
		serde_urlencoded@0.7.1
		serde_yaml@0.8.26
		sha1@0.10.5
		sha2@0.10.6
		shared_memory@0.12.4
		shlex@1.1.0
		shutdown_hooks@0.1.0
		signal-hook@0.3.15
		signal-hook-registry@1.4.1
		signature@1.6.4
		simd-adler32@0.3.5
		siphasher@0.2.3
		slab@0.4.8
		smallvec@1.10.0
		smithay-client-toolkit@0.15.4
		socket2@0.3.19
		socket2@0.4.9
		sodiumoxide@0.2.7
		spin@0.5.2
		spin@0.9.8
		static_assertions@1.1.0
		str-buf@1.0.6
		strength_reduce@0.2.4
		strsim@0.8.0
		strsim@0.10.0
		strum@0.18.0
		strum@0.24.1
		strum_macros@0.18.0
		strum_macros@0.24.3
		subtle@2.4.1
		syn@0.15.44
		syn@1.0.109
		syn@2.0.15
		sys-locale@0.3.0
		sysinfo@0.29.0
		system-configuration@0.5.0
		system-configuration-sys@0.5.0
		system-deps@1.3.2
		system-deps@6.1.0
		system_shutdown@4.0.1
		tap@1.0.1
		target-lexicon@0.12.7
		target_build_utils@0.3.1
		tempfile@3.5.0
		termcolor@1.2.0
		termios@0.3.3
		textwrap@0.11.0
		textwrap@0.16.0
		thiserror@1.0.40
		thiserror-impl@1.0.40
		threadpool@1.8.1
		tiff@0.8.1
		time@0.1.45
		time@0.3.21
		time-core@0.1.1
		time-macros@0.2.9
		tinyvec@1.6.0
		tinyvec_macros@0.1.1
		tokio@1.28.1
		tokio-macros@2.1.0
		tokio-rustls@0.23.4
		tokio-util@0.7.8
		toml@0.5.11
		toml@0.7.3
		toml_datetime@0.6.1
		toml_edit@0.19.8
		topological-sort@0.2.2
		tower-service@0.3.2
		tracing@0.1.37
		tracing-attributes@0.1.24
		tracing-core@0.1.30
		transpose@0.2.2
		tray-icon@0.5.1
		try-lock@0.2.4
		typenum@1.16.0
		uds_windows@1.0.2
		uname@0.1.1
		unicode-bidi@0.3.13
		unicode-ident@1.0.8
		unicode-normalization@0.1.22
		unicode-segmentation@1.10.1
		unicode-width@0.1.10
		unicode-xid@0.1.0
		untrusted@0.7.1
		url@2.3.1
		users@0.10.0
		users@0.11.0
		utf8parse@0.2.1
		uuid@1.3.2
		vec_map@0.8.2
		version-compare@0.0.10
		version-compare@0.1.1
		version_check@0.9.4
		vswhom@0.1.0
		vswhom-sys@0.1.2
		waker-fn@1.1.0
		walkdir@2.3.3
		want@0.3.0
		wasi@0.10.0+wasi-snapshot-preview1
		wasi@0.11.0+wasi-snapshot-preview1
		wasm-bindgen@0.2.85
		wasm-bindgen-backend@0.2.85
		wasm-bindgen-futures@0.4.35
		wasm-bindgen-macro@0.2.85
		wasm-bindgen-macro-support@0.2.85
		wasm-bindgen-shared@0.2.85
		wayland-client@0.29.5
		wayland-commons@0.29.5
		wayland-cursor@0.29.5
		wayland-protocols@0.29.5
		wayland-scanner@0.29.5
		wayland-sys@0.29.5
		web-sys@0.3.62
		webm@1.0.2
		webm-sys@1.0.3
		webpki@0.22.0
		webpki-roots@0.22.6
		weezl@0.1.7
		which@4.4.0
		whoami@1.4.0
		widestring@1.0.2
		win-sys@0.3.1
		winapi@0.2.8
		winapi@0.3.9
		winapi-build@0.1.1
		winapi-i686-pc-windows-gnu@0.4.0
		winapi-util@0.1.5
		winapi-wsapoll@0.1.1
		winapi-x86_64-pc-windows-gnu@0.4.0
		windows@0.32.0
		windows@0.34.0
		windows@0.44.0
		windows@0.46.0
		windows@0.48.0
		windows-implement@0.44.0
		windows-interface@0.44.0
		windows-service@0.6.0
		windows-sys@0.42.0
		windows-sys@0.45.0
		windows-sys@0.48.0
		windows-targets@0.42.2
		windows-targets@0.48.0
		windows_aarch64_gnullvm@0.42.2
		windows_aarch64_gnullvm@0.48.0
		windows_aarch64_msvc@0.32.0
		windows_aarch64_msvc@0.34.0
		windows_aarch64_msvc@0.42.2
		windows_aarch64_msvc@0.48.0
		windows_i686_gnu@0.32.0
		windows_i686_gnu@0.34.0
		windows_i686_gnu@0.42.2
		windows_i686_gnu@0.48.0
		windows_i686_msvc@0.32.0
		windows_i686_msvc@0.34.0
		windows_i686_msvc@0.42.2
		windows_i686_msvc@0.48.0
		windows_x86_64_gnu@0.32.0
		windows_x86_64_gnu@0.34.0
		windows_x86_64_gnu@0.42.2
		windows_x86_64_gnu@0.48.0
		windows_x86_64_gnullvm@0.42.2
		windows_x86_64_gnullvm@0.48.0
		windows_x86_64_msvc@0.32.0
		windows_x86_64_msvc@0.34.0
		windows_x86_64_msvc@0.42.2
		windows_x86_64_msvc@0.48.0
		winit@0.26.1
		winnow@0.4.6
		winreg@0.10.1
		winreg@0.11.0
		winres@0.1.12
		wol-rs@1.0.0
		wyz@0.5.1
		x11@2.21.0
		x11-dl@2.21.0
		x11rb@0.10.1
		x11rb-protocol@0.10.0
		xcursor@0.3.4
		xdg-home@1.0.0
		xml-rs@0.8.9
		yaml-rust@0.4.5
		zbus@3.12.0
		zbus_macros@3.12.0
		zbus_names@2.5.0
		zip@0.6.5
		zstd@0.11.2+zstd.1.5.2
		zstd@0.12.3+zstd.1.5.2
		zstd-safe@5.0.2+zstd.1.5.2
		zstd-safe@6.0.5+zstd.1.5.4
		zstd-sys@2.0.8+zstd.1.5.5
		zune-inflate@0.2.54
		zvariant@3.12.0
		zvariant_derive@3.12.0
		zvariant_utils@1.0.0
"

declare -A GIT_CRATES=(
	[hwcodec]="https://github.com/21pages/hwcodec;d55f7761ef692fae738259d8c14506d901eb824c"
	[confy]="https://github.com/open-trade/confy;9f231b2039cf8a8f8cdf6b829c5ac0016e146077"
	[tokio-socks]="https://github.com/open-trade/tokio-socks;14a5c2564fa20a2765ea53d03c573ee2b7e20421"
	[tfc]="https://github.com/fufesou/The-Fat-Controller;9dd86151525fd010dc93f6bc9b6aedd1a75cc342;The-Fat-Controller-%commit%"
	[magnum-opus]="https://github.com/rustdesk/magnum-opus;79be072c939168e907fe851690759dcfd6a326af"
	[parity-tokio-ipc]="https://github.com/open-trade/parity-tokio-ipc;a5b7861249107cbacc856cd43507cb95f40aef6e"
	[tao]="https://github.com/Kingtous/tao;dea701661a182cf2d944d5d05b5d299c78079871"
	[tao-macros]="https://github.com/Kingtous/tao;dea701661a182cf2d944d5d05b5d299c78079871;tao-%commit%/tao-macros"
	[sciter-rs]="https://github.com/open-trade/rust-sciter;82025b9ba77d5ae14543009444033036dbe25917;rust-sciter-%commit%"
	[evdev]="https://github.com/fufesou/evdev;cec616e37790293d2cd2aa54a96601ed6b1b35a9"
	[impersonate_system]="https://github.com/21pages/impersonate-system;84b401893d5b6628c8b33b295328d13fbbe2674b;impersonate-system-%commit%"
	[mouce]="https://github.com/fufesou/mouce;ed83800d532b95d70e39915314f6052aa433e9b9"
	[pam]="https://github.com/fufesou/pam;10da2cbbabe32cbc9de22a66abe44738e7ec0ea0"
	[rdev]="https://github.com/fufesou/rdev;f43a42fbedf1234a4bc132581790d63c9a2c8f92"
	[rust-pulsectl]="https://github.com/open-trade/pulsectl;5e68f4c2b7c644fa321984688602d71e8ad0bba3"
	[trayicon]="https://github.com/open-trade/trayicon-rs;35bd01963271b45a0b6a0f65f1ce03a5f35bc691;trayicon-rs-%commit%"
	[x11]="https://github.com/bjornsnoen/x11-rs;c2e9bfaa7b196938f8700245564d8ac5d447786a;x11-rs-%commit%/x11"
	[rust-pulsectl]="https://github.com/open-trade/pulsectl;5e68f4c2b7c644fa321984688602d71e8ad0bba3;pulsectl-%commit%"
)

inherit cargo systemd desktop xdg

DESCRIPTION="Open source virtual / remote desktop infrastructure for everyone"
HOMEPAGE="https://rustdesk.com/"
EGIT_COMMIT="650dee20bb53ee8457d9f1716452ae9acd13c2fe"
_THIDR_PARTY_COMMIT="20ee6a80eab87a1cec585d2a4365b14be879de49"
_SCRITER_COMMIT="0298f1b34e9a0ff1dffb889d82c506a5da8bfb1e"
SRC_URI="
	https://github.com/rustdesk/rustdesk/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/st0nie/gentoo-deps/releases/download/vcpkg/vcpkg-20230513.tar.gz
	https://github.com/c-smile/sciter-sdk/raw/${_SCRITER_COMMIT}/bin.lnx/x64/libsciter-gtk.so -> ${P}-libsciter-gtk.so
	${CARGO_CRATE_URIS}
"

LICENSE="AGPL-3"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64"

IUSE="wayland +hwaccel"

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
	dev-util/cmake
	sys-devel/clang
	dev-build/ninja
	media-libs/gstreamer
	media-libs/gst-plugins-base
"
QA_PRESTRIPPED="
	/usr/share/${PN}/${PN}
	/usr/share/${PN}/libsciter-gtk.so
"

S="${WORKDIR}/rustdesk-${EGIT_COMMIT}"

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
