find_package(OpenAL REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(PkgConfig REQUIRED)
find_package(Threads REQUIRED)
find_package(X11 REQUIRED)

pkg_check_modules(FFMPEG REQUIRED
	libavcodec
	libavformat
	libavutil
	libswscale
	libswresample
)
pkg_check_modules(LZ4 REQUIRED liblz4)
pkg_check_modules(OPUS REQUIRED opus)
pkg_check_modules(ZLIB REQUIRED minizip zlib)

find_package(Qt5 REQUIRED COMPONENTS Core DBus Gui Network Widgets)
get_target_property(QTCORE_INCLUDE_DIRS Qt5::Core INTERFACE_INCLUDE_DIRECTORIES)
list(GET QTCORE_INCLUDE_DIRS 0 QT_INCLUDE_DIR)

foreach(qt_module IN ITEMS QtCore QtGui)
	list(APPEND QT_PRIVATE_INCLUDE_DIRS
		${QT_INCLUDE_DIR}/${qt_module}/${Qt5_VERSION}
		${QT_INCLUDE_DIR}/${qt_module}/${Qt5_VERSION}/${qt_module}
	)
endforeach()
message(STATUS "Using Qt private include directories: ${QT_PRIVATE_INCLUDE_DIRS}")

set(QT_PLUGINS
	QComposePlatformInputContextPlugin
	QGenericEnginePlugin
	QGifPlugin
	QJpegPlugin
	QWebpPlugin
	QXcbIntegrationPlugin
)

foreach(qt_plugin IN ITEMS ${QT_PLUGINS})
	get_target_property(qt_plugin_loc Qt5::${qt_plugin} LOCATION)
	list(APPEND QT_PLUGIN_DIRS ${qt_plugin_loc})
endforeach()
message(STATUS "Using Qt plugins: ${QT_PLUGIN_DIRS}")

set(OPENAL_DEFINITIONS
	AL_ALEXT_PROTOTYPES
	AL_LIBTYPE_STATIC
)
set(QT_DEFINITIONS
	_REENTRANT
	QT_CORE_LIB
	QT_GUI_LIB
	QT_NETWORK_LIB
	QT_PLUGIN
	QT_STATICPLUGIN
	QT_WIDGETS_LIB
)

if (build_linux32)
	list(APPEND QT_DEFINITIONS Q_OS_LINUX32)
else()
	list(APPEND QT_DEFINITIONS Q_OS_LINUX64)
endif()

set(OPENAL_INCLUDE_DIRS ${OPENAL_INCLUDE_DIR})
set(QT_INCLUDE_DIRS ${QT_PRIVATE_INCLUDE_DIRS})

set(OPENAL_LIBRARIES ${OPENAL_LIBRARY})
set(OPENSSL_LIBRARIES
	OpenSSL::Crypto
	OpenSSL::SSL
)
set(QT_LIBRARIES
	Qt5::DBus
	Qt5::Network
	Qt5::Widgets Threads::Threads dl ${X11_X11_LIB}
)

set(EXTERNAL_LIBS ffmpeg lz4 openal openssl opus qt zlib)

if(NOT DESKTOP_APP_DISABLE_CRASH_REPORTS)
	pkg_check_modules(CRASH_REPORTS REQUIRED breakpad-client)
	list(APPEND EXTERNAL_LIBS crash_reports)
endif()

foreach(LIB IN ITEMS ${EXTERNAL_LIBS})
	add_library(external_${LIB} INTERFACE IMPORTED GLOBAL)
	add_library(desktop-app::external_${LIB} ALIAS external_${LIB})
	string(TOUPPER ${LIB} LIB_U)

	if(DEFINED ${LIB_U}_DEFINITIONS)
		target_compile_definitions(
			external_${LIB} INTERFACE ${${LIB_U}_DEFINITIONS}
		)
	endif()

	if(DEFINED ${LIB_U}_INCLUDE_DIRS)
		target_include_directories(
			external_${LIB} SYSTEM INTERFACE ${${LIB_U}_INCLUDE_DIRS}
		)
	endif()

	if(DEFINED ${LIB_U}_LIBRARIES)
		target_link_libraries(
			external_${LIB} INTERFACE ${${LIB_U}_LIBRARIES}
		)
	endif()
endforeach()
