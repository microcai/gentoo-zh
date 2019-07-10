include(TelegramCodegenTools)

set(GENERATED_DIR ${CMAKE_BINARY_DIR}/generated)
file(MAKE_DIRECTORY ${GENERATED_DIR})
set(GENERATED_SOURCES)

set(GENERATED_SCHEME_SOURCES
	${GENERATED_DIR}/scheme.h
	${GENERATED_DIR}/scheme.cpp
)
add_custom_command(
	OUTPUT ${GENERATED_SCHEME_SOURCES}
	COMMAND python ${CMAKE_SOURCE_DIR}/SourceFiles/codegen/scheme/codegen_scheme.py
		-o${GENERATED_DIR} ${CMAKE_SOURCE_DIR}/Resources/scheme.tl
	DEPENDS Resources/scheme.tl
	COMMENT "Codegen scheme.tl"
)
list(APPEND GENERATED_SOURCES ${GENERATED_SCHEME_SOURCES})

file(GLOB_RECURSE STYLES
	Resources/*.palette
	Resources/*.style
	SourceFiles/*.style
)
foreach(STYLE ${STYLES})
	get_filename_component(STYLE_FILENAME ${STYLE} NAME)
	get_filename_component(STYLE_NAME ${STYLE} NAME_WE)
	if (${STYLE} MATCHES \\.palette$)
		set(GENERATED_STYLE_SOURCES
			${GENERATED_DIR}/styles/palette.h
			${GENERATED_DIR}/styles/palette.cpp
		)
	else()
		set(GENERATED_STYLE_SOURCES
			${GENERATED_DIR}/styles/style_${STYLE_NAME}.h
			${GENERATED_DIR}/styles/style_${STYLE_NAME}.cpp
		)
	endif()

	# style generator does not like '-' in file path, so let's use relative paths...
	add_custom_command(
		OUTPUT ${GENERATED_STYLE_SOURCES}
		COMMAND ${CMAKE_BINARY_DIR}/codegen_style
			-IResources -ISourceFiles -o${GENERATED_DIR}/styles ${STYLE}
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		DEPENDS codegen_style ${STYLE}
		COMMENT "Codegen style ${STYLE_FILENAME}"
	)
	list(APPEND GENERATED_SOURCES ${GENERATED_STYLE_SOURCES})
endforeach()

set(RES_EMOJI emoji_autocomplete.json)
set(GENERATED_EMOJI_SOURCES
	${GENERATED_DIR}/emoji.h
	${GENERATED_DIR}/emoji.cpp
	${GENERATED_DIR}/emoji_suggestions_data.h
	${GENERATED_DIR}/emoji_suggestions_data.cpp
)
set(RES_LANG langs/lang.strings)
set(GENERATED_LANG_SOURCES
	${GENERATED_DIR}/lang_auto.h
	${GENERATED_DIR}/lang_auto.cpp
)
set(RES_NUMBERS numbers.txt)
set(GENERATED_NUMBERS_SOURCES
	${GENERATED_DIR}/numbers.h
	${GENERATED_DIR}/numbers.cpp
)

foreach(GEN emoji lang numbers)
	string(TOUPPER ${GEN} GEN_U)
	set(RES ${CMAKE_SOURCE_DIR}/Resources/${RES_${GEN_U}})
	get_filename_component(RES_FILENAME ${RES} NAME)
	add_custom_command(
		OUTPUT ${GENERATED_${GEN_U}_SOURCES}
		COMMAND ${CMAKE_BINARY_DIR}/codegen_${GEN} -o${GENERATED_DIR} ${RES}
		DEPENDS codegen_${GEN}
		COMMENT "Codegen ${GEN} ${RES_FILENAME}"
	)
	list(APPEND GENERATED_SOURCES ${GENERATED_${GEN_U}_SOURCES})
endforeach()

add_custom_target(telegram_codegen DEPENDS ${GENERATED_SOURCES})
