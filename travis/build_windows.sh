set -ev

mkdir libraries
cd libraries

# zlib
wget http://www.zlib.net/zlib-1.2.12.tar.gz
tar xf zlib-1.2.12.tar.gz
cd zlib-1.2.12
mkdir build
cd build
cmake ../ .
cmake --build . --config Release
cmake --install .
cd ../../

# libpng
git clone git://git.code.sf.net/p/libpng/code libpng
cd libpng
mkdir build
cd build
cmake ../ .
cmake --build . --config Release
cmake --install .
cd ../../

# SDL
wget https://github.com/libsdl-org/SDL/releases/download/release-2.0.22/SDL2-devel-2.0.22-VC.zip
unzip SDL2-devel-2.0.22-VC.zip

# SDL_mixer
wget https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.6.0/SDL2_mixer-devel-2.6.0-VC.zip
unzip SDL2_mixer-devel-2.6.0-VC.zip

# glew
wget https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0-win32.zip
unzip glew-2.2.0-win32.zip

# avdl
git clone https://github.com/tomtsagk/avdl avdl
cd avdl
git checkout develop
mkdir build
cd build
cmake ../ . -DCMAKE_INSTALL_PREFIX="C:/Program Files/avdl"
cmake --build . --config Release
cmake --install .
cd ../..

mkdir ../cengine
cp -r avdl/engines/cengine/src/*.c avdl/engines/cengine/include/*.h ../cengine

# exit dependencies
cd ..

# build rue itself
mkdir build
for i in src/*.dd; do C:/Program\ Files/avdl/bin/avdl.exe -t -I include/ $i -o ${i/.dd/.c}; echo $i; done
cd build
cmake ../ . -DCMAKE_INSTALL_PREFIX="C:/Program Files/rue_install"
cmake --build . --config Release
cmake --install .
cd ..
7z a -tzip "$1" "C:/Program Files/rue_install/*" -r
