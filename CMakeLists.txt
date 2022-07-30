cmake_minimum_required(VERSION 3.10)

# set the project name
project(rue VERSION 0.2.3)

# compile for windows, with dynamic location
add_compile_definitions(
	DD_PLATFORM_NATIVE
	AVDL_DYNAMIC_PKG_LOCATION
)

set(AVDL_SRC
	cengine/avdl_achievements.c
	cengine/avdl_assetManager.c
	cengine/avdl_data.c
	cengine/avdl_localisation.c
	cengine/avdl_particle_system.c
	cengine/avdl_shaders.c
	cengine/dd_dynamic_array.c
	cengine/dd_filetomesh.c
	cengine/dd_fov.c
	cengine/dd_game.c
	cengine/dd_gamejolt.c
	cengine/dd_image.c
	cengine/dd_json.c
	cengine/dd_log.c
	cengine/dd_math.c
	cengine/dd_matrix.c
	cengine/dd_mesh.c
	cengine/dd_meshColour.c
	cengine/dd_meshTexture.c
	cengine/dd_mouse.c
	cengine/dd_music.c
	cengine/dd_opengl.c
	cengine/dd_sound.c
	cengine/dd_string3d.c
	cengine/dd_vec3.c
	cengine/dd_vec4.c
	cengine/dd_world.c
	cengine/main.c

	src/button.c
	src/card.c
	src/credits.c
	src/game.c
	src/intro.c
	src/main_game.c
	src/menu.c
	src/menu_custom_game.c
	src/menu_home.c
	src/menu_stages.c
	src/options.c
	src/overlayButtons.c
	src/player.c
	src/saveload.c
	rue.rc
)
message("steam test")
if (${AVDL_STEAM})
	message("add steam files")
	set(AVDL_SRC
		${AVDL_SRC}
		cengine/avdl_achievements.c
		cengine/avdl_steam.c
	)
else()
	message("no steam files")
	set(AVDL_SRC
		${AVDL_SRC}
		cengine/avdl_achievements_steam.cpp
		cengine/avdl_steam_cpp.cpp
		cengine/main_cpp.cpp
	)
endif()

# add the executable
add_executable(rue WIN32
	${AVDL_SRC}
)


# SDL dependency
#set(SDL2_DIR       "${CMAKE_CURRENT_SOURCE_DIR}/libraries/SDL2-2.0.22"     )
set(SDL2_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/include")
if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
	set(SDL2_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/lib/x64/SDL2.lib;${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/lib/x64/SDL2main.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/lib/x64/SDL2.dll" DESTINATION bin/)
else ()
	set(SDL2_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/lib/x86/SDL2.lib;${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/lib/x86/SDL2main.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2-2.0.22/lib/x86/SDL2.dll" DESTINATION bin/)
endif ()

# SDL_mixer dependency
#set(SDL2_mixer_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libraries/SDL2_mixer-2.6.0/cmake")
set(SDL2_MIXER_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/include")

if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
	set(SDL2_MIXER_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x64/SDL2_mixer.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x64/SDL2_mixer.dll" DESTINATION bin/)
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x64/optional/libogg-0.dll" DESTINATION bin/)
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x64/optional/libopus-0.dll" DESTINATION bin/)
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x64/optional/libopusfile-0.dll" DESTINATION bin/)
else ()
	set(SDL2_MIXER_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x86/SDL2_mixer.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x86/SDL2_mixer.dll" DESTINATION bin/)
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x86/optional/libogg-0.dll" DESTINATION bin/)
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x86/optional/libopus-0.dll" DESTINATION bin/)
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/SDL2_mixer-2.6.0/lib/x86/optional/libopusfile-0.dll" DESTINATION bin/)
endif ()

# glew dependency
#set(GLEW_DIR       "${CMAKE_CURRENT_SOURCE_DIR}/libraries/glew-2.2.0"      )
set(GLEW_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/include")

if (${CMAKE_SIZEOF_VOID_P} MATCHES 8)
	set(GLEW_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/lib/Release/x64/glew32.lib;${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/lib/Release/x64/glew32s.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/bin/Release/x64/glew32.dll" DESTINATION bin/)
else ()
	set(GLEW_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/lib/Release/Win32/glew32.lib;${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/lib/Release/Win32/glew32s.lib")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/glew-2.2.0/bin/Release/Win32/glew32.dll" DESTINATION bin/)
endif ()

# dependency zlib
install(FILES "C:/Program Files (x86)/zlib/bin/zlib.dll" DESTINATION bin/)

# dependency png
set(PNG_LIBRARY "C:/Program Files (x86)/libpng/lib/libpng16.lib")
set(PNG_PNG_INCLUDE_DIR "C:/Program Files (x86)/libpng/include")
install(FILES "C:/Program Files (x86)/libpng/bin/libpng16.dll" DESTINATION bin/)

find_package(OpenGL     REQUIRED)
find_package(PNG	REQUIRED)

target_link_libraries(rue ${GLEW_LIBRARIES}      )
target_link_libraries(rue ${SDL2_LIBRARIES}      )
target_link_libraries(rue ${SDL2_MIXER_LIBRARIES})
target_link_libraries(rue ${OPENGL_LIBRARIES}    )
target_link_libraries(rue ${PNG_LIBRARY}         )


if (${AVDL_STEAM})
	target_link_libraries(rue "libraries/sdk/redistributable_bin/win64/steam_api64")
	install(FILES "${CMAKE_CURRENT_LIST_DIR}/libraries/sdk/redistributable_bin/win64/steam_api64.dll" DESTINATION bin/)
endif()

# add include directory, for binary `rue`, including dependencies
target_include_directories(rue PUBLIC
	cengine
	include
	${SDL2_INCLUDE_DIRS}
	${SDL2_MIXER_INCLUDE_DIRS}
	${GLEW_INCLUDE_DIRS}
	${OPENGL_INCLUDE_DIR}
	${PNG_PNG_INCLUDE_DIR}
	${ZLIB_INCLUDE_DIR}
)

# main executable
install(TARGETS rue DESTINATION bin/)

# install assets
install(FILES
	assets/button_click_big.ogg
	assets/button_click_small.ogg
	assets/button_disabled.ply
	assets/button_exit.ply
	assets/button_hover.ogg
	assets/button_minus.ply
	assets/button_options.ply
	assets/button_play.ply
	assets/button_plus.ply
	assets/button.ply
	assets/card_approach.png
	assets/card_border.ply
	assets/card_border_texture.png
	assets/card_corner_frown.png
	assets/card_corner_heart.png
	assets/card_corner_tear.png
	assets/card_corner_thunder.png
	assets/card_deselect.ogg
	assets/card_empty.png
	assets/card_grab_gen.png
	assets/card_grab.png
	assets/card_hold_one_step.png
	assets/card_ignore_move.png
	assets/card_look.ogg
	assets/card_next_hand.png
	assets/card_one_step_cond.png
	assets/card_place.ogg
	assets/card.ply
	assets/card_replace.png
	assets/card_rose_seeker.png
	assets/card_select.ogg
	assets/card_single_step.png
	assets/card_trade.png
	assets/card_triple_step.png
	assets/card_tutorial.png
	assets/card_win.png
	assets/character_1.png
	assets/character_2.png
	assets/character_3.png
	assets/character.ply
	assets/dd_theme.ogg
	assets/eng_white.png
	assets/eye.ply
	assets/game_theme.opus
	assets/logo.ply
	assets/logo_rue_texture.png
	assets/looking_at.ply
	assets/main_menu_theme.opus
	assets/menu_copy.json
	assets/overlay_background.ply
	assets/particle.ply
	assets/rose.png
	assets/rue_logo.png
	assets/stage_1.ply
	assets/stage_2.ply
	assets/table_1.ply
	assets/table_2.ply
	assets/table_arrow_decoration.ply
	assets/table_arrow.ply
	assets/table_rose.png
	assets/ui_particle.ply
	assets/ui_particle_start.ply
	DESTINATION
	assets
)

# packaging using `cpack`
include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_VENDOR "Dark Dimension")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A card game about deduction, love and regret")
set(CPACK_PACKAGE_DESCRIPTION "A card game where all the players are sitting around a table. A rose appears on the table that moves around.")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://darkdimension.org/games/rue.html")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "rue")
set(CPACK_NSIS_MODIFY_PATH ON)
include(CPack)
