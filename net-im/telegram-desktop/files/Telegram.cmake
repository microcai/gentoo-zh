cmake_minimum_required(VERSION 3.8)

project(TelegramDesktop)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}/gyp
	${CMAKE_SOURCE_DIR}/cmake
)

option(BUILD_TESTS "Build all available test suites" OFF)
option(ENABLE_CRASH_REPORTS "Enable crash reports" OFF)
option(ENABLE_GTK_INTEGRATION "Enable GTK integration" ON)
option(ENABLE_OPENAL_EFFECTS "Enable OpenAL effects" ON)
option(ENABLE_PULSEAUDIO "Enable pulseaudio" ON)

find_package(LibLZMA REQUIRED)
find_package(OpenAL REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(Threads REQUIRED)
find_package(X11 REQUIRED)
find_package(ZLIB REQUIRED)

find_package(Qt5 REQUIRED COMPONENTS Core DBus Gui Widgets Network)
get_target_property(QTCORE_INCLUDE_DIRS Qt5::Core INTERFACE_INCLUDE_DIRECTORIES)
list(GET QTCORE_INCLUDE_DIRS 0 QT_INCLUDE_DIR)

foreach(__qt_module IN ITEMS QtCore QtGui)
	list(APPEND QT_PRIVATE_INCLUDE_DIRS
		${QT_INCLUDE_DIR}/${__qt_module}/${Qt5_VERSION}
		${QT_INCLUDE_DIR}/${__qt_module}/${Qt5_VERSION}/${__qt_module}
	)
endforeach()
message(STATUS "Using Qt private include directories: ${QT_PRIVATE_INCLUDE_DIRS}")

find_package(PkgConfig REQUIRED)
pkg_check_modules(FFMPEG REQUIRED libavcodec libavformat libavutil libswresample libswscale)
pkg_check_modules(LIBDRM REQUIRED libdrm)
pkg_check_modules(LIBVA REQUIRED libva libva-drm libva-x11)
pkg_check_modules(MINIZIP REQUIRED minizip)

add_subdirectory(lib_crl)
add_subdirectory(ThirdParty/libtgvoip)
add_subdirectory(ThirdParty/rlottie)

include(TelegramCodegen)
set_property(SOURCE ${GENERATED_SOURCES} PROPERTY SKIP_AUTOMOC ON)

include_directories(SourceFiles)
list(APPEND THIRDPARTY_INCLUDE_DIRS
	ThirdParty/lib_crl
	lib_rpl
	lib_ui
	lib_tl
	lib_spellcheck
	lib_lottie
	lib_ui/emoji_suggestions
	ThirdParty/emoji_suggestions
	ThirdParty/GSL/include
	ThirdParty/libtgvoip
	ThirdParty/variant/include
)


file(GLOB QRC_FILES
	Resources/qrc/telegram/telegram.qrc
	Resources/qrc/telegram/sounds.qrc
	Resources/qrc/emoji_preview.qrc
	Resources/qrc/emoji_1.qrc
	Resources/qrc/emoji_2.qrc
	Resources/qrc/emoji_3.qrc
	Resources/qrc/emoji_4.qrc
	Resources/qrc/emoji_5.qrc

	lib_ui/qt_conf/linux.qrc
	lib_ui/fonts/fonts.qrc

	# This only disables system plugin search path
	# We do not want this behavior for system build
	# Resources/qrc/telegram_linux.qrc
)

file(GLOB FLAT_SOURCE_FILES
	SourceFiles/*.cpp
	SourceFiles/api/*.cpp
	SourceFiles/base/*.cpp
	SourceFiles/calls/*.cpp
	SourceFiles/chat_helpers/*.cpp
	SourceFiles/core/*.cpp
	SourceFiles/data/*.cpp
	SourceFiles/dialogs/*.cpp
	SourceFiles/inline_bots/*.cpp
	SourceFiles/intro/*.cpp
	SourceFiles/lang/*.cpp
	SourceFiles/main/*.cpp
	SourceFiles/lottie/*.cpp
	SourceFiles/mtproto/*.cpp
	SourceFiles/overview/*.cpp
	SourceFiles/passport/*.cpp
	SourceFiles/platform/linux/*.cpp
	SourceFiles/profile/*.cpp
	SourceFiles/settings/*.cpp
	SourceFiles/storage/*.cpp
	SourceFiles/storage/cache/*.cpp
	SourceFiles/support/*.cpp
#	lib_base/base/*.cpp
#	lib_base/base/platform/*.cpp
#	lib_base/base/platform/linux/*.cpp
	lib_ui/emoji_suggestions/*.cpp

	lib_lottie/lottie/*.cpp

	lib_spellcheck/spellcheck/*.cpp
	lib_spellcheck/spellcheck/platform/linux/*.cpp
)

set(LIBBASE_SOURCES

	lib_base/base/platform/linux/base_file_utilities_linux.cpp
	lib_base/base/platform/linux/base_file_utilities_linux.h
	lib_base/base/platform/linux/base_info_linux.cpp
	lib_base/base/platform/linux/base_info_linux.h
	lib_base/base/platform/linux/base_last_input_linux.cpp
	lib_base/base/platform/linux/base_last_input_linux.h
	lib_base/base/platform/linux/base_layout_switch_linux.cpp
	lib_base/base/platform/linux/base_layout_switch_linux.h
	lib_base/base/platform/linux/base_process_linux.cpp
	lib_base/base/platform/linux/base_process_linux.h
	lib_base/base/platform/linux/base_url_scheme_linux.cpp
	lib_base/base/platform/linux/base_url_scheme_linux.h
	lib_base/base/platform/base_platform_info.h
	lib_base/base/platform/base_platform_last_input.h
	lib_base/base/platform/base_platform_layout_switch.h
	lib_base/base/platform/base_platform_file_utilities.h
	lib_base/base/platform/base_platform_process.h
	lib_base/base/platform/base_platform_url_scheme.h
	lib_base/base/algorithm.h
	lib_base/base/assertion.cpp
	lib_base/base/assertion.h
	lib_base/base/basic_types.h
	lib_base/base/binary_guard.h
	lib_base/base/build_config.h
	lib_base/base/bytes.h
	lib_base/base/call_delayed.cpp
	lib_base/base/call_delayed.h
	lib_base/base/crash_report_header.cpp
	lib_base/base/crash_report_header.h
	lib_base/base/crc32hash.cpp
	lib_base/base/crc32hash.h
	lib_base/base/concurrent_timer.cpp
	lib_base/base/concurrent_timer.h
	lib_base/base/flags.h
	lib_base/base/enum_mask.h
	lib_base/base/event_filter.cpp
	lib_base/base/event_filter.h
	lib_base/base/base_file_utilities.cpp
	lib_base/base/base_file_utilities.h
	lib_base/base/flat_map.h
	lib_base/base/flat_set.h
	lib_base/base/functors.h
	lib_base/base/index_based_iterator.h
	lib_base/base/integration.cpp
	lib_base/base/integration.h
	lib_base/base/invoke_queued.h
	lib_base/base/last_used_cache.h
	lib_base/base/last_user_input.cpp
	lib_base/base/last_user_input.h
	lib_base/base/match_method.h
	lib_base/base/object_ptr.h
	lib_base/base/observer.cpp
	lib_base/base/observer.h
	lib_base/base/ordered_set.h
	lib_base/base/openssl_help.h
	lib_base/base/optional.h
	lib_base/base/overload.h
	lib_base/base/parse_helper.cpp
	lib_base/base/parse_helper.h
	lib_base/base/qthelp_regex.h
	lib_base/base/qthelp_url.cpp
	lib_base/base/qthelp_url.h
	lib_base/base/qt_connection.h
	lib_base/base/qt_signal_producer.h
	lib_base/base/runtime_composer.cpp
	lib_base/base/runtime_composer.h
	lib_base/base/single_instance.cpp
	lib_base/base/single_instance.h
	lib_base/base/thread_safe_wrap.h
	lib_base/base/timer.cpp
	lib_base/base/timer.h
	lib_base/base/timer_rpl.h
	lib_base/base/type_traits.h
	lib_base/base/unique_any.h
	lib_base/base/unique_function.h
	lib_base/base/unique_qptr.h
	lib_base/base/unixtime.cpp
	lib_base/base/unixtime.h
	lib_base/base/value_ordering.h
	lib_base/base/variant.h
	lib_base/base/virtual_method.h
	lib_base/base/weak_ptr.h
	lib_base/base/zlib_help.h

	lib_base/base/file_lock_posix.cpp
)

file(GLOB FLAT_EXTRA_FILES
	SourceFiles/qt_static_plugins.cpp
	SourceFiles/base/*_tests.cpp
	SourceFiles/base/tests_main.cpp
	SourceFiles/data/data_feed_messages.cpp
	SourceFiles/passport/passport_edit_identity_box.cpp
	SourceFiles/passport/passport_form_row.cpp
	SourceFiles/storage/*_tests.cpp
	SourceFiles/storage/storage_clear_legacy_win.cpp
	SourceFiles/storage/storage_feed_messages.cpp
	SourceFiles/storage/storage_file_lock_win.cpp
	SourceFiles/storage/cache/*_tests.cpp
)
list(REMOVE_ITEM FLAT_SOURCE_FILES ${FLAT_EXTRA_FILES})

file(GLOB_RECURSE SUBDIRS_SOURCE_FILES
	SourceFiles/boxes/*.cpp
	SourceFiles/export/*.cpp
	SourceFiles/history/*.cpp
	SourceFiles/info/*.cpp
	SourceFiles/ffmpeg/*.cpp
	SourceFiles/media/*.cpp
	SourceFiles/media/streaming/*.cpp
	SourceFiles/ui/*.cpp
	SourceFiles/window/*.cpp
	SourceFiles/platform/win/*
	lib_ui/ui/*.cpp
	lib_ui/ui/style/*.cpp
	lib_ui/ui/effects/*.cpp
)
file(GLOB SUBDIRS_SOURCE_EXTRA_FILES
	SourceFiles/history/feed/history_feed_section.cpp
	SourceFiles/info/channels/info_channels_widget.cpp
	SourceFiles/info/feed/*.cpp
	lib_ui/ui/platform/mac/*
	lib_ui/ui/platform/win/*
	SourceFiles/platform/win/*
)
list(REMOVE_ITEM SUBDIRS_SOURCE_FILES ${SUBDIRS_SOURCE_EXTRA_FILES})

add_executable(Telegram WIN32 ${QRC_FILES} ${LIBBASE_SOURCES} ${FLAT_SOURCE_FILES} ${SUBDIRS_SOURCE_FILES})

set(TELEGRAM_COMPILE_DEFINITIONS
	Q_OS_LINUX64
	TDESKTOP_DISABLE_AUTOUPDATE
	TDESKTOP_DISABLE_DESKTOP_FILE_GENERATION
	TDESKTOP_DISABLE_UNITY_INTEGRATION
	__STDC_FORMAT_MACROS
)

set(TELEGRAM_INCLUDE_DIRS
	${FFMPEG_INCLUDE_DIRS}
	${LIBDRM_INCLUDE_DIRS}
	${LIBLZMA_INCLUDE_DIRS}
	${LIBVA_INCLUDE_DIRS}
	${MINIZIP_INCLUDE_DIRS}
	${OPENAL_INCLUDE_DIR}
	${ZLIB_INCLUDE_DIR}

	${GENERATED_DIR}
	${QT_PRIVATE_INCLUDE_DIRS}
	${THIRDPARTY_INCLUDE_DIRS}
)

set(TELEGRAM_LINK_LIBRARIES
	crl tgvoip xxhash
	OpenSSL::Crypto
	OpenSSL::SSL
	Qt5::DBus
	Qt5::Network
	Qt5::Widgets
	Threads::Threads
	${FFMPEG_LIBRARIES}
	${LIBDRM_LIBRARIES}
	${LIBLZMA_LIBRARIES}
	${LIBVA_LIBRARIES}
	${MINIZIP_LIBRARIES}
	${OPENAL_LIBRARY}
	${X11_X11_LIB}
	${ZLIB_LIBRARY_RELEASE}
	rlottie::rlottie
	lz4
)

if(ENABLE_CRASH_REPORTS)
	find_package(Breakpad REQUIRED)
	list(APPEND TELEGRAM_LINK_LIBRARIES
		breakpad_client
	)
else()
	list(APPEND TELEGRAM_COMPILE_DEFINITIONS
		TDESKTOP_DISABLE_CRASH_REPORTS
	)
endif()

if(ENABLE_GTK_INTEGRATION)
	pkg_check_modules(APPINDICATOR REQUIRED appindicator3-0.1)
	pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
	list(APPEND TELEGRAM_INCLUDE_DIRS
		${APPINDICATOR_INCLUDE_DIRS}
		${GTK3_INCLUDE_DIRS}
	)
	list(APPEND TELEGRAM_LINK_LIBRARIES
		${APPINDICATOR_LIBRARIES}
		${GTK3_LIBRARIES}
	)
	list(APPEND TELEGRAM_COMPILE_DEFINITIONS
		TDESKTOP_FORCE_GTK_FILE_DIALOG
	)
else()
	list(APPEND TELEGRAM_COMPILE_DEFINITIONS
		TDESKTOP_DISABLE_GTK_INTEGRATION
	)
endif()

if(ENABLE_OPENAL_EFFECTS)
	list(APPEND TELEGRAM_COMPILE_DEFINITIONS
		AL_ALEXT_PROTOTYPES
	)
else()
	list(APPEND TELEGRAM_COMPILE_DEFINITIONS
		TDESKTOP_DISABLE_OPENAL_EFFECTS
	)
endif()

if(DEFINED ENV{TDESKTOP_API_ID} AND DEFINED ENV{TDESKTOP_API_HASH})
	message(STATUS "Found custom 'api_id' and 'api_hash'")
	list(APPEND TELEGRAM_COMPILE_DEFINITIONS
		TDESKTOP_API_ID=$ENV{TDESKTOP_API_ID}
		TDESKTOP_API_HASH=$ENV{TDESKTOP_API_HASH}
	)
endif()

target_sources(Telegram PRIVATE ${GENERATED_SOURCES})
add_dependencies(Telegram telegram_codegen)

target_compile_definitions(Telegram PUBLIC ${TELEGRAM_COMPILE_DEFINITIONS})
target_include_directories(Telegram PUBLIC ${TELEGRAM_INCLUDE_DIRS})
target_link_libraries(Telegram ${TELEGRAM_LINK_LIBRARIES})

target_compile_options(Telegram PUBLIC -include ${CMAKE_SOURCE_DIR}/SourceFiles/stdafx.h)

if(BUILD_TESTS)
	include(TelegramTests)
endif()

set_target_properties(Telegram PROPERTIES
	AUTOMOC_MOC_OPTIONS -bSourceFiles/stdafx.h
	OUTPUT_NAME "telegram-desktop"
)

install(TARGETS Telegram RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

MESSAGE(STATUS "<<< Gentoo configuration >>>
Build type      ${CMAKE_BUILD_TYPE}
Install path    ${CMAKE_INSTALL_PREFIX}
Compiler flags:
C               ${CMAKE_C_FLAGS}
C++             ${CMAKE_CXX_FLAGS}
Linker flags:
Executable      ${CMAKE_EXE_LINKER_FLAGS}
Module          ${CMAKE_MODULE_LINKER_FLAGS}
Shared          ${CMAKE_SHARED_LINKER_FLAGS}\n")
