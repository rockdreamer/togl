:: Note: this script needs to be run with the /E:ON and /V:ON flags for the
:: cmd interpreter, at least for (SDK v7.0)
::
:: More details at:
:: https://github.com/cython/cython/wiki/64BitCythonExtensionsOnWindows
:: http://stackoverflow.com/a/13751649/163740
::
:: Initial Author: Olivier Grisel
:: License: CC0 1.0 Universal: http://creativecommons.org/publicdomain/zero/1.0/
::
:: Notes about batch files for Python people:
::
:: Quotes in values are literally part of the values:
::      SET FOO="bar"
:: FOO is now five characters long: " b a r "
:: If you don't want quotes, don't include them on the right-hand side.
::
:: The CALL lines at the end of this file look redundant, but if you move them
:: outside of the IF clauses, they do not run properly in the SET_SDK_64==Y
:: case, I don't know why.
@ECHO OFF

SET COMMAND_TO_RUN=%*
SET WIN_SDK_ROOT=C:\Program Files\Microsoft SDKs\Windows
SET WIN_WDK=c:\Program Files (x86)\Windows Kits\10\Include\wdf

:: Extract the major and minor versions, and allow for the minor version to be
:: more than 9.  This requires the version number to have two dots in it.
SET MAJOR_PYTHON_VERSION=%PYTHON_VERSION:~0,1%
IF "%PYTHON_VERSION:~3,1%" == "." (
    SET MINOR_PYTHON_VERSION=%PYTHON_VERSION:~2,1%
) ELSE (
    SET MINOR_PYTHON_VERSION=%PYTHON_VERSION:~2,2%
)

:: Based on the Python version, determine what SDK version to use, and whether
:: to set the SDK for 64-bit.
IF %MAJOR_PYTHON_VERSION% == 2 (
    SET WINDOWS_SDK_VERSION="v7.0"
) ELSE (
    IF %MAJOR_PYTHON_VERSION% == 3 (
        SET WINDOWS_SDK_VERSION="v7.1"
    ) ELSE (
        ECHO Unsupported Python version: "%MAJOR_PYTHON_VERSION%"
        EXIT 1
    )
)

IF  %VCVARSALL_PLATFORM% == amd64  (
    ECHO Configuring Windows SDK %WINDOWS_SDK_VERSION% for Python %MAJOR_PYTHON_VERSION% on a 64 bit architecture
    "%WIN_SDK_ROOT%\%WINDOWS_SDK_VERSION%\Setup\WindowsSdkVer.exe" -q -version:%WINDOWS_SDK_VERSION%
    "%WIN_SDK_ROOT%\%WINDOWS_SDK_VERSION%\Bin\SetEnv.cmd" /x64 /release
    ECHO Executing: %COMMAND_TO_RUN%
    call %COMMAND_TO_RUN% || EXIT 1
) ELSE (
    ECHO Configuring Windows SDK %WINDOWS_SDK_VERSION% for Python %MAJOR_PYTHON_VERSION% on a 32 bit architecture
    "%WIN_SDK_ROOT%\%WINDOWS_SDK_VERSION%\Setup\WindowsSdkVer.exe" -q -version:%WINDOWS_SDK_VERSION%
    "%WIN_SDK_ROOT%\%WINDOWS_SDK_VERSION%\Bin\SetEnv.cmd" /x86 /release
    ECHO Executing: %COMMAND_TO_RUN%
    call %COMMAND_TO_RUN% || EXIT 1
)
