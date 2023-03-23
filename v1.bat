@echo off
setlocal enableextensions enabledelayedexpansion

echo ----------------------v.1.0-----------------------------
echo.

if "%~1"=="" (
    set "directory=%cd%"    
    echo Attempting to count files in the current directory...
    echo.
) else (
    set "directory=%*"    
    echo Attempting to count files in the specified directories...
    echo.
)

set "totalcount=0"
set "error="

for %%d in (%directory%) do (
    if not exist "%%~d" (
        echo Directory "%%~d" not found.
        echo.
        echo Check spelling or try again.
        set "error=1"
    ) else (
        pushd "%%~d" >nul
        if errorlevel 1 (
            echo "%%~d" is not a directory.
            echo.
            echo Check spelling or try again.
            set "error=1"
        ) else (    
            set "count=0"        
            for /f "tokens=*" %%i in ('dir /a-d-h-r /b /s 2^>nul') do (
                set /a count+=1
            )
            echo The directory "%%~d" contains !count! files.
            set /a totalcount+=count
            popd >nul
        )
    )
)

if not defined error (
    echo.
    echo The directories contain %totalcount% files in total.
)

echo.
echo --------------------------------------------------------
echo.
pause

endlocal
if defined error (exit /b 1) else (exit /b 0)
