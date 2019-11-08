project(crl)

find_package(Qt5 REQUIRED COMPONENTS Core)

file(GLOB CRL_SOURCE_FILES
	crl/*.cpp
	crl/common/*.cpp
	crl/dispatch/*.cpp
	crl/linux/*.cpp
	crl/qt/*.cpp
	crl/winapi/*.cpp
)

add_library(${PROJECT_NAME} STATIC ${CRL_SOURCE_FILES})
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${PROJECT_NAME} Qt5::Core)
