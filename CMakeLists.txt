cmake_minimum_required(VERSION 3.10)

# set the project name
project(rue VERSION 1.0)

# compile for windows, with dynamic location
add_compile_definitions(
	DD_PLATFORM_NATIVE
	AVDL_DYNAMIC_PKG_LOCATION
)

# add the executable
add_executable(rue WIN32
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
	cengine/dd_opengl.c
	cengine/dd_sound.c
	cengine/dd_string3d.c
	cengine/dd_vec3.c
	cengine/dd_vec4.c
	cengine/dd_world.c
	cengine/main.c
	cengine/whereami.c
	src/button.c
	src/card.c
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

# dependencies
set(SDL2_DIR       "${CMAKE_CURRENT_SOURCE_DIR}/libraries/SDL2-2.0.20"     )
set(SDL2_mixer_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libraries/SDL2_mixer-2.0.4")
set(GLEW_DIR       "${CMAKE_CURRENT_SOURCE_DIR}/libraries/glew-2.2.0"      )

find_package(SDL2       REQUIRED)
find_package(SDL2_mixer REQUIRED)
find_package(GLEW       REQUIRED)
find_package(OpenGL     REQUIRED)

target_link_libraries(rue ${GLEW_LIBRARIES}      )
target_link_libraries(rue ${SDL2_LIBRARIES}      )
target_link_libraries(rue ${SDL2_MIXER_LIBRARIES})
target_link_libraries(rue ${OPENGL_LIBRARIES}    )

# add include directory, for binary `rue`, including dependencies
target_include_directories(rue PUBLIC
	cengine
	include
	${SDL2_INCLUDE_DIRS}
	${SDL2_MIXER_INCLUDE_DIRS}
	${GLEW_INCLUDE_DIRS}
	${OPENGL_INCLUDE_DIR}
)

# main executable
install(TARGETS rue DESTINATION bin/)

# install assets
install(FILES
	assets/button.asset
	assets/button_disabled.asset
	assets/button_exit.asset
	assets/button_minus.asset
	assets/button_options.asset
	assets/button_play.asset
	assets/button_plus.asset
	assets/card.asset
	assets/card_approach.asset
	assets/card_border.asset
	assets/card_border_texture.asset
	assets/card_grab.asset
	assets/card_grab_gen.asset
	assets/card_one_step_cond.asset
	assets/card_replace.asset
	assets/card_single_step.asset
	assets/card_trade.asset
	assets/card_triple_step.asset
	assets/card_tutorial.asset
	assets/card_win.asset
	assets/character.asset
	assets/character_1.asset
	assets/dd_theme.asset
	assets/eye.asset
	assets/letter_0.asset
	assets/letter_1.asset
	assets/letter_2.asset
	assets/letter_3.asset
	assets/letter_4.asset
	assets/letter_5.asset
	assets/letter_6.asset
	assets/letter_7.asset
	assets/letter_8.asset
	assets/letter_9.asset
	assets/letter_a.asset
	assets/letter_b.asset
	assets/letter_c.asset
	assets/letter_d.asset
	assets/letter_e.asset
	assets/letter_f.asset
	assets/letter_g.asset
	assets/letter_h.asset
	assets/letter_i.asset
	assets/letter_j.asset
	assets/letter_k.asset
	assets/letter_l.asset
	assets/letter_m.asset
	assets/letter_n.asset
	assets/letter_o.asset
	assets/letter_p.asset
	assets/letter_q.asset
	assets/letter_r.asset
	assets/letter_s.asset
	assets/letter_t.asset
	assets/letter_u.asset
	assets/letter_v.asset
	assets/letter_w.asset
	assets/letter_x.asset
	assets/letter_y.asset
	assets/letter_z.asset
	assets/logo.asset
	assets/logo_rue.asset
	assets/logo_rue_texture.asset
	assets/looking_at.asset
	assets/menu_copy.asset
	assets/overlay_background.asset
	assets/particle.asset
	assets/rose.asset
	assets/stage_1.asset
	assets/stage_2.asset
	assets/table_1.asset
	assets/table_arrow.asset
	assets/table_arrow_decoration.asset
	DESTINATION
	assets
)

# packaging using `cpack`
include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_VENDOR "Dark Dimension")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "1")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A card game about deduction, love and regret")
set(CPACK_PACKAGE_DESCRIPTION "A card game where all the players are sitting around a table. A rose appears on the table that moves around.")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://darkdimension.org/games/rue.html")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "rue")
set(CPACK_NSIS_MODIFY_PATH ON)
include(CPack)
