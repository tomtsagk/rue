# Rue

A card game where all the players are sitting around a table. A rose appears on the table that moves around.

The aim of the game is for each player to have the rose in front of them at the end of the round. Each player can use cards that influence the rose’s movement.

This game is currently in Alpha and still under active development. 

Visit its official page here: [Rue by Dark Dimension](https://darkdimension.org/games/rue)

## Available on these Linux Distros

You can find this project packaged for the following Linux distributions:

### Ubuntu 20.04.2 LTS

Make sure to install the [avdl](https://notabug.org/tomtsagk/avdl) project first.

Add the Personal Package Archives (PPA) to your system,
then update repositories and install:

    add-apt-repository ppa:darkdimension/rue
    apt-get update
    apt-get install rue

Note: These commands require `root` permissions, usually aquired with
the `sudo` command.

### Arch Linux

You can find this project in the Arch User Repository (AUR). Make sure
to install the dependencies listed here:

[https://aur.archlinux.org/packages/rue/](https://aur.archlinux.org/packages/rue/)

Using the command line, move to an empty directory and run:

    git clone https://aur.archlinux.org/rue.git
    makepkg
    pacman -U rue-<version>-<arch>.pkg.tar.zst

Note: The command `pacman -U` needs `root` permissions, as it is
used to install packaged from a local file.

## Build for Linux

Before building this game, you need to have the [avdl](https://notabug.org/tomtsagk/avdl) compiler installed.

Then use the following commands to build it:

    make
    make install

By default, this will install the project at `/usr/local`. To change that, you
can supply a custom `prefix` value like below:

    make prefix=/usr
    make prefix=/usr install

To build the project as a standalone in a folder, without installing it,
use the following commands instead:

    make assetdir=

This will put a self-contained build at `build/native/out`.

## Build for Windows

Unfortunately this is not very straightforward. When building the project on a Linux machine using `make`,
the `avdl` compiler will create `.c` files of the source code. Those can then be used to
compile the windows version, linked against windows libraries.

This is planned to be improved.

## Build for Android

Before building this game, you need to have the [avdl](https://notabug.org/tomtsagk/avdl) compiler installed.
This works best on a Linux machine.

Use the following commands to build it:

    make android

Once complete, and assuming no errors occur, there will be a few `.c` files located in `build/android/objects`.
These files can then be put in the Android project inside [avdl](https://notabug.org/tomtsagk/avdl) (located in
`engines/android`), together with the assets, and be build.

The last step is not very automated, and is planned to be improved.
