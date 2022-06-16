#
# project data
#
NAME=rue
VERSION=0.3.0
REVISION=2

#
# system data
#
prefix=/usr/local
assetdir=${prefix}/share/${NAME}/
savedir=~/.${NAME}/saves/

#
# compiler flags
#
COMPILER_FLAGS= -I include/ --save-loc "${savedir}" --install-loc "${assetdir}" \
	--game-name "${NAME}" --game-version "${VERSION}" --game-revision "${REVISION}"
LINKER_FLAGS= --game-name "${NAME}" --game-version "${VERSION}" --game-revision "${REVISION}" \
	--install-loc "${assetdir}"
LINKER_CUSTOM_FLAGS=

#
# directories - separate for native and android
#
DIRECTORY_NATIVE=build/native
DIRECTORY_NATIVE_OBJ=${DIRECTORY_NATIVE}/objects
DIRECTORY_NATIVE_OUT=${DIRECTORY_NATIVE}/output
DIRECTORY_NATIVE_ALL=${DIRECTORY_NATIVE} ${DIRECTORY_NATIVE_OBJ} ${DIRECTORY_NATIVE_OUT}

DIRECTORY_ANDROID=build/android
DIRECTORY_ANDROID_OBJ=${DIRECTORY_ANDROID}/objects
DIRECTORY_ANDROID_OUT=${DIRECTORY_ANDROID}/output
DIRECTORY_ANDROID_ALL=${DIRECTORY_ANDROID} ${DIRECTORY_ANDROID_OBJ}

DIRECTORY_ALL=${DIRECTORY_NATIVE_ALL} ${DIRECTORY_ANDROID_ALL}

#
# source code files
#
SRC=$(wildcard src/*.dd)
HEADERS=$(wildcard include/*.ddh)

#
# asset files
#
PLY=$(wildcard assets/*.ply)
BMP=$(wildcard assets/*.bmp)
WAV=$(wildcard assets/*.wav)
OGG=$(wildcard assets/*.ogg)
JSON=$(wildcard assets/*.json)
ASSETS=${PLY} ${BMP} ${WAV} ${OGG} ${JSON}

#
# native output files
#
NATIVE_OBJ=${SRC:src/%.dd=${DIRECTORY_NATIVE_OBJ}/%.o}
NATIVE_OBJ_C=${NATIVE_OBJ:%.o=%.c}
NATIVE_OUT=${DIRECTORY_NATIVE_OUT}/${NAME}
NATIVE_ASSETS=${ASSETS:assets/%=${DIRECTORY_NATIVE_OBJ}/%}

#
# android output files
#
ANDROID_OBJ=${SRC:src/%.dd=${DIRECTORY_ANDROID_OBJ}/%.o}
ANDROID_ASSETS=${ASSETS:assets/%=${DIRECTORY_ANDROID_OBJ}/%}

#
# desktop application data
#
icon128x128=metadata/icon-128x128.png
icon64x64=metadata/icon-64x64.png
desktopfile=metadata/org.darkdimension.rue.desktop
metadatafile=metadata/org.darkdimension.rue.metainfo.xml

#
# default build - native only
#
all: native

#
# how to make builds for native and android
#
native: ${DIRECTORY_NATIVE_ALL} ${NATIVE_OUT} ${NATIVE_ASSETS}

android: ${DIRECTORY_ANDROID_ALL} ${ANDROID_OBJ} ${ANDROID_ASSETS}
	avdl --android -o ${DIRECTORY_ANDROID_OUT} ${ANDROID_OBJ}

#
# native - compile files - assets - final executable
#
${DIRECTORY_NATIVE_OBJ}/%.o: src/%.dd ${HEADERS}
	avdl -c $< -o $@ ${COMPILER_FLAGS}

${DIRECTORY_NATIVE_OBJ}/%: assets/%
	avdl -c $< -o ${DIRECTORY_NATIVE_OUT} && touch $@

${NATIVE_OUT}: ${NATIVE_OBJ}
	avdl $^ -o ${DIRECTORY_NATIVE_OUT} ${LINKER_FLAGS} ${LINKER_CUSTOM_FLAGS}

#
# android - compile files
#
${DIRECTORY_ANDROID_OBJ}/%.o: src/%.dd ${HEADERS}
	avdl --android -c $< -o $@ -I include/

${DIRECTORY_ANDROID_OBJ}/%: assets/%
	avdl --android -c $< -o ${DIRECTORY_ANDROID_OUT} && touch $@

#
# make any directory needed
#
${DIRECTORY_ALL}:
	mkdir -p $@

INSTALL_DIRS = ${DESTDIR}${prefix}/bin ${DESTDIR}${prefix}/share/${NAME}/assets \
	${DESTDIR}${prefix}/share/applications ${DESTDIR}${prefix}/share/metainfo \
	${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/

${INSTALL_DIRS}:
	mkdir -p $@

install: ${INSTALL_DIRS}
	install ${NATIVE_OUT} ${DESTDIR}${prefix}/bin/${NAME}
	install ${DIRECTORY_NATIVE_OUT}/assets/* ${DESTDIR}${prefix}/share/${NAME}/assets
	install ${desktopfile} ${DESTDIR}${prefix}/share/applications
	install ${metadatafile} ${DESTDIR}${prefix}/share/metainfo/
	install ${icon128x128} ${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
	install ${icon64x64} ${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png

uninstall:
	rm -f ${DESTDIR}${prefix}/bin/${NAME}
	rm -rf ${DESTDIR}${prefix}/share/${NAME}
	rm -f ${DESTDIR}${prefix}/share/applications/org.darkdimension.rue.desktop
	rm -f ${DESTDIR}${prefix}/share/metainfo/org.darkdimension.rue.metainfo.xml
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png

#
# clean project
#
clean:
	rm -f ${NATIVE_OBJ} ${NATIVE_OUT} ${NATIVE_ASSETS} ${NATIVE_OBJ_C}

#
# phony targets
#
.PHONY: clean native android
