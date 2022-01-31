set(GLEW_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/include")

if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
	set(GLEW_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/lib/Release/x64/glew32.lib;${CMAKE_CURRENT_LIST_DIR}/lib/Release/x64/glew32s.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/bin/Release/x64/glew32.dll" DESTINATION bin/)
else ()
	set(GLEW_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/lib/Release/Win32/glew32.lib;${CMAKE_CURRENT_LIST_DIR}/lib/Release/Win32/glew32s.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/bin/Release/Win32/glew32.dll" DESTINATION bin/)
endif ()

string(STRIP "${GLEW_LIBRARIES}" GLEW_LIBRARIES)
