file(GLOB CODEGEN_COMMON_SOURCES
	codegen/codegen/common/*.h
	codegen/codegen/common/*.cpp
	lib_base/base/crc32hash.cpp
)

add_library(codegen_common OBJECT ${CODEGEN_COMMON_SOURCES})
target_include_directories(codegen_common PUBLIC $<TARGET_PROPERTY:Qt5::Core,INTERFACE_INCLUDE_DIRECTORIES>)
target_compile_options(codegen_common PUBLIC $<TARGET_PROPERTY:Qt5::Core,INTERFACE_COMPILE_OPTIONS>)
target_include_directories(codegen_common PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/codegen ${CMAKE_CURRENT_SOURCE_DIR}/lib_base)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/codegen ${CMAKE_CURRENT_SOURCE_DIR}/lib_base)

foreach(TOOL emoji lang numbers style)
	string(TOUPPER ${TOOL} TOOL_U)
	file(GLOB CODEGEN_${TOOL_U}_SOURCES
		codegen/codegen/${TOOL}/*.h
		codegen/codegen/${TOOL}/*.cpp
	)
	add_executable(codegen_${TOOL} ${CODEGEN_${TOOL_U}_SOURCES} $<TARGET_OBJECTS:codegen_common>)
	target_include_directories(codegen_${TOOL} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/codegen ${CMAKE_CURRENT_SOURCE_DIR}/lib_base)
	target_link_libraries(codegen_${TOOL} Qt5::Core Qt5::Gui)
endforeach()
