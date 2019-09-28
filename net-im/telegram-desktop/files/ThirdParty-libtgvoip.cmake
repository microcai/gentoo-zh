project(tgvoip)

option(ENABLE_PULSEAUDIO "Enable pulseaudio" ON)

find_package(PkgConfig REQUIRED)
pkg_check_modules(OPUS REQUIRED opus)

file(GLOB TGVOIP_SOURCES
	*.cpp
	audio/*.cpp
	os/linux/*.cpp
	os/posix/*.cpp
	video/*.cpp
)

file(GLOB_RECURSE WEBRTC_SOURCES
	*.c *.cc
)

set(TGVOIP_COMPILE_DEFINITIONS
	TGVOIP_USE_DESKTOP_DSP
	WEBRTC_APM_DEBUG_DUMP=0
	WEBRTC_LINUX
	WEBRTC_NS_FLOAT
	WEBRTC_POSIX
)

if(ENABLE_PULSEAUDIO)
	pkg_check_modules(LIBPULSE REQUIRED libpulse)
else()
	file(GLOB PULSEAUDIO_SOURCES
		os/linux/AudioInputPulse.cpp
		os/linux/AudioOutputPulse.cpp
		os/linux/AudioPulse.cpp
	)
	list(REMOVE_ITEM TGVOIP_SOURCES ${PULSEAUDIO_SOURCES})
	list(APPEND TGVOIP_COMPILE_DEFINITIONS WITHOUT_PULSE)
endif()

add_library(${PROJECT_NAME} STATIC
	${TGVOIP_SOURCES}
	${WEBRTC_SOURCES}
)

target_compile_definitions(${PROJECT_NAME} PUBLIC ${TGVOIP_COMPILE_DEFINITIONS})
target_include_directories(${PROJECT_NAME} PUBLIC
	${OPUS_INCLUDE_DIRS}
	audio
	webrtc_dsp
)
target_link_libraries(${PROJECT_NAME} dl ${OPUS_LIBRARIES})
