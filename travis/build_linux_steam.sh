set -ev

# install steam
curl https://partner.steamgames.com/downloads/steamworks_sdk.zip > steamworks_sdk.zip
unzip steamworks_sdk.zip

# libpng
git clone git://git.code.sf.net/p/libpng/code libpng
cd libpng
./configure --prefix=${HOME}/AVDL_DEPENDENCIES
make -j6
make -j6 install
cd ..

# install vorbis
git clone https://gitlab.xiph.org/xiph/vorbis.git vorbis
cd vorbis
./autogen.sh
./configure --prefix=${HOME}/AVDL_DEPENDENCIES
make
make install
cd ..

# install opus
git clone https://gitlab.xiph.org/xiph/opus.git opus
cd opus
./autogen.sh
./configure --prefix=${HOME}/AVDL_DEPENDENCIES
make
make install
cd ..

# install ogg
git clone https://gitlab.xiph.org/xiph/ogg.git ogg
cd ogg
./autogen.sh
./configure --prefix=${HOME}/AVDL_DEPENDENCIES
make -j6
make -j6 install
cd ..

# install opusfile
export PKG_CONFIG_PATH=${HOME}/AVDL_DEPENDENCIES
git clone https://gitlab.xiph.org/xiph/opusfile.git opusfile
cd opusfile
./autogen.sh
./configure --prefix=${HOME}/AVDL_DEPENDENCIES
make -j6
make -j6 install
cd ..

export C_INCLUDE_PATH=${HOME}/AVDL_DEPENDENCIES/include
export LIBRARY_PATH=${HOME}/AVDL_DEPENDENCIES/lib:${HOME}/AVDL_DEPENDENCIES/lib64

# install SDL
git clone https://github.com/libsdl-org/SDL SDL
cd SDL
git checkout release-2.0.20
mkdir build
cd build
../configure --prefix=${HOME}/AVDL_DEPENDENCIES
make -j6
make -j6 install
cd ../..

# install SDL_mixer
git clone https://github.com/libsdl-org/SDL_mixer SDL_mixer
cd SDL_mixer
git checkout release-2.0.4
mkdir build
cd build
../configure --prefix=${HOME}/AVDL_DEPENDENCIES --enable-music-ogg-vorbis
make -j6
make -j6 install
cd ../..

# install glew
git clone https://github.com/nigels-com/glew glew
cd glew
git checkout glew-2.2.0
cd auto
make
cd ..
make GLEW_DEST=${HOME}/AVDL_DEPENDENCIES
make GLEW_DEST=${HOME}/AVDL_DEPENDENCIES install
cd ..

# install avdl
git clone https://github.com/tomtsagk/avdl avdl
cd avdl
git checkout develop
make -j6
sudo make -j6 install
cd ..

# install rue
make COMPILER_CUSTOM_FLAGS="-i ${HOME}/AVDL_DEPENDENCIES/include --steam" LINKER_CUSTOM_FLAGS="-L ${HOME}/AVDL_DEPENDENCIES/lib -L ${HOME}/AVDL_DEPENDENCIES/lib64 --steam -i sdk/public/steam -L sdk/redistributable_bin/linux64/" assetdir=
mkdir build/native/output/dependencies
mkdir build/native/output/bin
echo "LD_LIBRARY_PATH=./dependencies/ ./bin/rue" > build/native/output/rue.sh
chmod +x build/native/output/rue.sh
mv build/native/output/rue build/native/output/bin/rue
cp sdk/redistributable_bin/linux64/libsteam_api.so build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libGLEW.so* build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libSDL2-2.0.so* build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libSDL2_mixer-2.0.so* build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libopus.so* build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libogg.so* build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libopusfile.so* build/native/output/dependencies/
cp -d ${HOME}/AVDL_DEPENDENCIES/lib*/libpng*.so* build/native/output/dependencies/
cd build/native/output
zip --symlinks "$1" -r *
cd ../../../
mv "build/native/output/$1" .
