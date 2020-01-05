set_target_properties(Telegram PROPERTIES
	OUTPUT_NAME "telegram-desktop"
)

install(TARGETS Telegram RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

