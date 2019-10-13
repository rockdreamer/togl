call "C:\Users\appveyor\AppData\Local\Programs\Common\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" %VCVARSALL_PLATFORM%
mkdir dist
mkdir build
cd build
cmake --version
cmake .. ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=..\dist ^
    -G Ninja
cmake --build .
cmake --build . --target install
