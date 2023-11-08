REM =============
REM VARIABLES
REM =============
::specify parameter file path
set PARAM_FP=%~dp0RICorDE_bryant2022.ini

::specify root directory for building outputs, loggers, etc.
set ROOT_DIR=C:\LS\10_IO\ricorde\bryant2022\

REM =============
REM SETUP
REM =============
REM Activate pyqgis environment and 
call "G:\My Drive\RESEARCH\RICorDE_evaluation_inputs_outputs_logs\python-qgis-ltr_3228_activation.bat"

 
REM set the path to RICorDE's main caller
set MAIN=%SRC_DIR%\main.py

REM =============
REM EXECUTE 
REM =============
ECHO Executing RICorDE
python %MAIN% %PARAM_FP% -rd %ROOT_DIR% -t r1 

cmd /k