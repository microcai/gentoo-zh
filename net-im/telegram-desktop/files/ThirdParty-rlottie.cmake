cmake_minimum_required( VERSION 3.2 )

#declare project
project( rlottie VERSION 0.0.1 LANGUAGES C CXX ASM)

#declare target
add_library( rlottie STATIC  "" )

#declare version of the target
set(player_version_major 0)
set(player_version_minor 0)
set(player_version_patch 1)
set(player_version ${player_version_major}.${player_version_minor}.${player_version_patch} )
set_target_properties(rlottie PROPERTIES
                        VERSION    ${player_version}
                        SOVERSION  ${player_version_major}
                      )

#declare alias so that library can be used inside the build tree, e.g. when testing
add_library(rlottie::rlottie ALIAS rlottie)

option(LOTTIE_MODULE "Enable LOTTIE MODULE SUPPORT" OFF)
option(LOTTIE_THREAD "Enable LOTTIE THREAD SUPPORT" ON)
option(LOTTIE_CACHE "Enable LOTTIE CACHE SUPPORT" ON)

CONFIGURE_FILE(${CMAKE_CURRENT_LIST_DIR}/cmake/config.h.in config.h)

target_include_directories(rlottie
    PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}/inc"
    PRIVATE
        "${CMAKE_CURRENT_BINARY_DIR}"
    )

#declare target compilation options
target_compile_options(rlottie
                    PUBLIC
                    PRIVATE
                        -std=c++14
                        -Os
                        -fno-exceptions
                        -fno-unwind-tables
                        -fno-asynchronous-unwind-tables
                        -fno-rtti
                        -Wall
                        -Werror
                        -Wextra
                        -Wnon-virtual-dtor
                        -Woverloaded-virtual
                        -Wno-unused-parameter
                        -fvisibility=hidden
                    )

#declare dependancy
set( CMAKE_THREAD_PREFER_PTHREAD TRUE )
find_package( Threads )

target_link_libraries(rlottie
                    PUBLIC
                        "${CMAKE_THREAD_LIBS_INIT}"
                     )

# for dlopen, dlsym and dlclose dependancy
target_link_libraries(rlottie
                    PRIVATE
                    ${CMAKE_DL_LIBS})

if(APPLE)
    target_link_libraries(rlottie
                        PUBLIC
                             "-Wl, -undefined error"
                          )
else()
    target_link_libraries(rlottie
                        PUBLIC
                             "-Wl,--no-undefined"
                          )
endif()


if (NOT LIB_INSTALL_DIR)
    set (LIB_INSTALL_DIR "/usr/lib")
endif (NOT LIB_INSTALL_DIR)

#declare source and include files
add_subdirectory(inc)
add_subdirectory(src)
add_subdirectory(example)

SET(PREFIX ${CMAKE_INSTALL_PREFIX})
SET(EXEC_DIR ${PREFIX})
SET(LIBDIR ${LIB_INSTALL_DIR})
SET(INCDIR ${PREFIX}/include)
