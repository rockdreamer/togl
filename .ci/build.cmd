mkdir dist
mkdir build
cd build
cmake --version
if %VCVARSALL_PLATFORM% == amd64 (
    set COMPILER_PATH=C:/Users/appveyor/AppData/Local/Programs/Common/Microsoft/Visual C++ for Python/9.0/VC/bin/%VCVARSALL_PLATFORM%
) else (
    set COMPILER_PATH=C:/Users/appveyor/AppData/Local/Programs/Common/Microsoft/Visual C++ for Python/9.0/VC/bin
)
set PATH=%COMPILER_PATH%;%PATH%
cmake .. ^
    -DCMAKE_BUILD_TYPE=Release ^
    "-DCMAKE_C_COMPILER=%COMPILER_PATH%/cl.exe" ^
    "-DCMAKE_C_COMPILER=%COMPILER_PATH%/cl.exe" ^
    "-DCMAKE_LINKER=%COMPILER_PATH%/link.exe" ^
    -DCMAKE_INSTALL_PREFIX=..\dist ^
    -G Ninja
cmake --build .
cmake --build --target install .
