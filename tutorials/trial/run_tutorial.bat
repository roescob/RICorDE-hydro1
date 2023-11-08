ECHO off
REM =============
REM VARIABLES
REM =============
set PARAM_FP=%~dp0\parameters.ini

REM default path for outputs
set ROOT_DIR=C:\RICorDE-dev\outputs

REM =============
REM SETUP
REM =============
REM activate pyqgis
call "C:\Program Files\QGIS 3.22.8\ricorde\python-qgis-ltr_3228_activate.bat"

 
REM =============
REM EXECUTE 
REM =============
ECHO Executing RICorDE
python "%~dp0../../main.py" %PARAM_FP% -rd %ROOT_DIR% -t r1 

pause