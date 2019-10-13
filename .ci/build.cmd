mkdir dist
mkdir build
cd build
cmake --version
cmake .. ^
    -DCMAKE_BUILD_TYPE=Release ^
    "-DCMAKE_C_COMPILER=C:/Users/appveyor/AppData/Local/Programs/Common/Microsoft/Visual C++ for Python/9.0/VC/bin/%VCVARSALL_PLATFORM%/cl.exe" ^
    "-DCMAKE_C_COMPILER=C:/Users/appveyor/AppData/Local/Programs/Common/Microsoft/Visual C++ for Python/9.0/VC/bin/%VCVARSALL_PLATFORM%/cl.exe" ^
    "-DCMAKE_LINKER=C:/Users/appveyor/AppData/Local/Programs/Common/Microsoft/Visual C++ for Python/9.0/VC/bin/%VCVARSALL_PLATFORM%/link.exe" ^
    -DCMAKE_INSTALL_PREFIX=..\dist ^
    -G Ninja
cmake --build .
cmake --build --target install .
