@echo off
color 0a
cd ..
echo BUILDING GAME
lime build windows -debug -32
echo.
echo done.
pause
pwd
explorer.exe export\debug\windows\32\bin