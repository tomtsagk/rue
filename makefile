#
# project data
#
NAME=rue
VERSION=1.0.1
REVISION=0
VERSION_CODE=8

#
# system data
#
prefix=/usr/local/
assetprefix=share/${NAME}/

#
# compiler flags
#
AVDL_BIN=avdl
COMPILER_FLAGS=--asset-loc "${assetprefix}"
COMPILER_CUSTOM_FLAGS=

#
# directories - separate for native and android
#
DIRECTORY_NATIVE=avdl_build
DIRECTORY_ANDROID=avdl_build_android

#
# desktop application data
#
icon512x512=metadata/icon-512x512.png
icon256x256=metadata/icon-256x256.png
icon128x128=metadata/icon-128x128.png
icon64x64=metadata/icon-64x64.png
icon32x32=metadata/icon-32x32.png
icon16x16=metadata/icon-16x16.png
desktopfile=metadata/org.darkdimension.rue.desktop
metadatafile=metadata/org.darkdimension.rue.metainfo.xml

#
# avdl files
#
NATIVE_BIN=${DIRECTORY_NATIVE}/bin/${NAME}

#
# default build - native only
#
all: native

#
# how to make builds for native and android
#
native:
	${AVDL_BIN} ${COMPILER_FLAGS} ${COMPILER_CUSTOM_FLAGS}

android:
	${AVDL_BIN} --android ${COMPILER_CUSTOM_FLAGS}

INSTALL_DIRS = ${DESTDIR}${prefix}/bin ${DESTDIR}${prefix}/share/${NAME}/assets \
	${DESTDIR}${prefix}/share/applications ${DESTDIR}${prefix}/share/metainfo \
	${DESTDIR}${prefix}/share/icons/hicolor/512x512/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/256x256/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/32x32/apps/ \
	${DESTDIR}${prefix}/share/icons/hicolor/16x16/apps/

${INSTALL_DIRS}:
	mkdir -p $@

install: ${INSTALL_DIRS}
	install ${NATIVE_BIN} ${DESTDIR}${prefix}/bin/${NAME}
	install ${DIRECTORY_NATIVE}/assets/* ${DESTDIR}${prefix}/share/${NAME}/assets
	install ${desktopfile} ${DESTDIR}${prefix}/share/applications
	install ${metadatafile} ${DESTDIR}${prefix}/share/metainfo/
	install ${icon512x512} ${DESTDIR}${prefix}/share/icons/hicolor/512x512/apps/org.darkdimension.rue.png
	install ${icon256x256} ${DESTDIR}${prefix}/share/icons/hicolor/256x256/apps/org.darkdimension.rue.png
	install ${icon128x128} ${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
	install ${icon64x64} ${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png
	install ${icon32x32} ${DESTDIR}${prefix}/share/icons/hicolor/32x32/apps/org.darkdimension.rue.png
	install ${icon16x16} ${DESTDIR}${prefix}/share/icons/hicolor/16x16/apps/org.darkdimension.rue.png

uninstall:
	rm -f ${DESTDIR}${prefix}/bin/${NAME}
	rm -rf ${DESTDIR}${prefix}/share/${NAME}
	rm -f ${DESTDIR}${prefix}/share/applications/org.darkdimension.rue.desktop
	rm -f ${DESTDIR}${prefix}/share/metainfo/org.darkdimension.rue.metainfo.xml
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/512x512/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/256x256/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/32x32/apps/org.darkdimension.rue.png
	rm -f ${DESTDIR}${prefix}/share/icons/hicolor/16x16/apps/org.darkdimension.rue.png

#
# clean project
#
clean:
	rm -rf .avdl_cache avdl_build avdl_build_android

#
# phony targets
#
.PHONY: clean native android
