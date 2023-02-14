Name:           rue
Version:        1.0.0
Release:        1%{?dist}
Summary:        A card game about decisions, love and regret

License:        GPLv3
URL:            https://afloofdev.com/games/rue
Source0:        https://github.com/tomtsagk/%{name}/archive/refs/tags/v%{version}.tar.gz

BuildRequires:  make, glew-devel, SDL2-devel, SDL2_mixer-devel, libpng-devel, libvorbis-devel, opus, opus-tools, libopusenc, libogg-devel, opusfile
Requires:       glew-devel, SDL2-devel, SDL2_mixer-devel, libpng-devel, libvorbis-devel, opus, opus-tools, libopusenc, libogg-devel, opusfile

%description
A card game where all the players are sitting around a table.
A rose appears on the table that moves around.
The aim of the game is for each player to have the rose in front of them at the end of the round.

%global debug_package %{nil}

%prep
%autosetup

%build
make %{?_smp_mflags} prefix=/usr

%install
rm -rf $RPM_BUILD_ROOT
make %{?_smp_mflags} prefix=/usr DESTDIR=%{buildroot} install

%files
/usr/bin/rue
/usr/share/rue/*
/usr/share/applications/org.darkdimension.rue.desktop
/usr/share/metainfo/org.darkdimension.rue.metainfo.xml
/usr/share/icons/hicolor/512x512/apps/org.darkdimension.rue.png
/usr/share/icons/hicolor/256x256/apps/org.darkdimension.rue.png
/usr/share/icons/hicolor/128x128/apps/org.darkdimension.rue.png
/usr/share/icons/hicolor/64x64/apps/org.darkdimension.rue.png
/usr/share/icons/hicolor/32x32/apps/org.darkdimension.rue.png
/usr/share/icons/hicolor/16x16/apps/org.darkdimension.rue.png
%license LICENSE

%changelog
* Tue Feb 14 2023 Tom Tsagk <tomtsagk@afloofdev.com>
- Game was simplified
- First stable release

* Wed Aug 31 2022 Tom Tsagk <tomtsagk@afloofdev.com>
- 15 stages implemented.
- 5 working AI characters.
- 1 new background

* Wed Jun 15 2022 Tom Tsagk <tomtsagk@darkdimension.org>
- Add optional corner effects on cards
- Text is now using 2D bitamp font
- Added music and sound effects
- Add credits
- Add intro animation
- Add new textured table

* Fri Feb 18 2022 Tom Tsagk <tomtsagk@darkdimension.org>
- Fix bug that caused shaders to not draw meshes on some hardware

* Thu Feb 10 2022 Tom Tsagk <tomtsagk@darkdimension.org>
- Add `cmake` for easier compilation
- Add first 5 stages
- Add more fluff in main menu
- Re-add intro screen

* Fri Jan 07 2022 Tom Tsagk <tomtsagk@darkdimension.org>
- Update to version `0.1.0`
- Minor visual changes in main menu
- Add fullscreen toggle
- Add stages that need to be completed in order
- Fix localisation issue on compiled games

* Sun Aug 29 2021 Tom Tsagk <tomtsagk@darkdimension.org>
- Update to version `0.0.6` which removes dependency to `freeglut`.
- Added desktop application details, so it appears on launchers.

* Sun Aug 22 2021 Tom Tsagk <tomtsagk@darkdimension.org>
- Change source to github

* Sat Aug 08 2021 Tom Tsagk <tomtsagk@darkdimension.org>
- Initial Release
