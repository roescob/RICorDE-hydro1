ECHO off
REM =============
REM VARIABLES
REM =============
set PARAM_FP=%~dp0\parameters_out11.ini

REM default path for outputs
set ROOT_DIR=C:\Users\koysa\OneDrive\Documents\GitHub\RICorDE-hydro1\outputs

REM =============
REM SETUP
REM =============
REM activate pyqgis
#call "G:\My Drive\RESEARCH\RICorDE_evaluation_inputs_outputs_logs\python-qgis-ltr_3228_activation.bat"
call "C:\Users\koysa\OneDrive\Documents\GitHub\RICorDE-hydro1\tutorials\trial\python-qgis-activate-20230112.bat"
 
REM =============
REM EXECUTE 
REM =============
ECHO Executing RICorDE
python "%~dp0../../main.py" %PARAM_FP% -rd %ROOT_DIR% -t r1 

pause