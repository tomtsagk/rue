#
# project data
#
NAME=rue
VERSION=v0.0.8

#
# directories - separate for native and android
#
DIRECTORY_NATIVE=build/native
DIRECTORY_NATIVE_OBJ=${DIRECTORY_NATIVE}/objects
DIRECTORY_NATIVE_ASSETS=${DIRECTORY_NATIVE}/output/assets
DIRECTORY_NATIVE_OUT=${DIRECTORY_NATIVE}/output
DIRECTORY_NATIVE_ALL=${DIRECTORY_NATIVE} ${DIRECTORY_NATIVE_OBJ} ${DIRECTORY_NATIVE_ASSETS} ${DIRECTORY_NATIVE_OUT}

DIRECTORY_ANDROID=build/android
DIRECTORY_ANDROID_OBJ=${DIRECTORY_ANDROID}/objects
DIRECTORY_ANDROID_OUT=${DIRECTORY_ANDROID}/output
DIRECTORY_ANDROID_ALL=${DIRECTORY_ANDROID} ${DIRECTORY_ANDROID_OBJ} ${DIRECTORY_ANDROID}

DIRECTORY_ALL=${DIRECTORY_NATIVE_ALL} ${DIRECTORY_ANDROID_ALL}

#
# source files
#
SRC=$(wildcard src/*.dd)
HEADERS=$(wildcard include/*.ddh)
PLY=$(wildcard assets/*.ply)
BMP=$(wildcard assets/*.bmp)
WAV=$(wildcard assets/*.wav)
OGG=$(wildcard assets/*.ogg)

#
# native output files
#
NATIVE_OBJ=${SRC:src/%.dd=${DIRECTORY_NATIVE_OBJ}/%.o}
NATIVE_OBJ_C=${NATIVE_OBJ:%.o=%.c}
NATIVE_OUT=${DIRECTORY_NATIVE_OUT}/${NAME}-${VERSION}.x86_64
NATIVE_ASSETS_OBJ=${PLY:assets/%.ply=build/native/output/assets/%.asset} ${BMP:assets/%.bmp=build/native/output/assets/%.asset} \
	${WAV:assets/%.wav=build/native/output/assets/%.asset} ${OGG:assets/%.ogg=build/native/output/assets/%.asset}

#
# android output files
#
ANDROID_OBJ=${SRC:src/%.dd=${DIRECTORY_ANDROID_OBJ}/%.o}

#
# system data
#
prefix=/usr/local
assetdir=${prefix}/share/rue/

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
native: ${DIRECTORY_NATIVE_ALL} ${NATIVE_OUT} ${NATIVE_ASSETS_OBJ}
android: ${DIRECTORY_ANDROID_ALL} ${ANDROID_OBJ}
	avdl --android -o ${DIRECTORY_ANDROID_OUT} ${ANDROID_OBJ}
	$(foreach i,${PLY} ${BMP} ${WAV} ${OGG},avdl --android -c -o ${DIRECTORY_ANDROID_OUT} ${i};)

#
# native - compile files - assets - final executable
#
${DIRECTORY_NATIVE_OBJ}/%.o: src/%.dd ${HEADERS}
	avdl -c $< -o $@ -I include/ --install-loc "${assetdir}"


${DIRECTORY_NATIVE_ASSETS}/%.asset: assets/%.ply
	avdl -c $< -o $@

${DIRECTORY_NATIVE_ASSETS}/%.asset: assets/%.bmp
	avdl -c $< -o $@

${DIRECTORY_NATIVE_ASSETS}/%.asset: assets/%.wav
	avdl -c $< -o $@

${DIRECTORY_NATIVE_ASSETS}/%.asset: assets/%.ogg
	avdl -c $< -o $@


${NATIVE_OUT}: ${NATIVE_OBJ}
	avdl $^ -o $@ ${avdlargs}

#
# android - compile files
#
${DIRECTORY_ANDROID_OBJ}/%.o: src/%.dd ${HEADERS}
	avdl --android -c $< -o $@ -I include/

#
# make any directory needed
#
${DIRECTORY_ALL}:
	mkdir -p $@

INSTALL_DIRS = ${DESTDIR}${prefix}/bin ${DESTDIR}${prefix}/share/rue/assets \
	${DESTDIR}${prefix}/share/applications ${DESTDIR}${prefix}/share/metainfo \
	${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/

${INSTALL_DIRS}:
	mkdir -p $@

install: ${INSTALL_DIRS}
	install ${NATIVE_OUT} ${DESTDIR}${prefix}/bin/rue
	install ${NATIVE_ASSETS_OBJ} ${DESTDIR}${prefix}/share/rue/assets
	install ${desktopfile} ${DESTDIR}${prefix}/share/applications
	install ${metadatafile} ${DESTDIR}${prefix}/share/metainfo/
	install ${icon128x128} ${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
	install ${icon64x64} ${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png

uninstall:
	rm -f ${DESTDIR}${prefix}/bin/rue
	rm -rf ${DESTDIR}${prefix}/share/rue
	rm -f ${DESTDIR}${prefix}/share/applications/org.darkdimension.rue.desktop
	rm -f ${DESTDIR}${prefix}/share/metainfo/org.darkdimension.rue.metainfo.xml
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png

#
# clean project
#
clean:
	rm -f ${NATIVE_OBJ} ${NATIVE_OUT} ${NATIVE_ASSETS_OBJ} ${NATIVE_OBJ_C}

#
# phony targets
#
.PHONY: clean native android
