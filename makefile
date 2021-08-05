#
# project data
#
NAME=rue
VERSION=v0.0.4

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
DIRECTORY_ANDROID_ALL=${DIRECTORY_ANDROID} ${DIRECTORY_ANDROID_OBJ}

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
ANDROID_OBJ=${SRC:src/%.dd=${DIRECTORY_ANDROID_OBJ}/%.c}

#
# system data
#
prefix=/usr/local
assetdir=${prefix}/share/rue/

#
# default build - native only
#
all: native

#
# how to make builds for native and android
#
native: ${DIRECTORY_NATIVE_ALL} ${NATIVE_OUT} ${NATIVE_ASSETS_OBJ}
android: ${DIRECTORY_ANDROID_ALL} ${ANDROID_OBJ}

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
	avdl $^ -o $@

#
# android - compile files
#
${DIRECTORY_ANDROID_OBJ}/%.c: src/%.dd ${HEADERS}
	avdl --android -t $< -o $@ -I include/

#
# make any directory needed
#
${DIRECTORY_ALL}:
	mkdir -p $@

install:
	mkdir -p ${DESTDIR}${prefix}/bin
	install ${NATIVE_OUT} ${DESTDIR}${prefix}/bin/rue
	mkdir -p ${DESTDIR}${prefix}/share/rue/assets
	install ${NATIVE_ASSETS_OBJ} ${DESTDIR}${prefix}/share/rue/assets

#
# clean project
#
clean:
	rm -f ${NATIVE_OBJ} ${NATIVE_OUT} ${NATIVE_ASSETS_OBJ} ${NATIVE_OBJ_C}

#
# phony targets
#
.PHONY: clean native android
