REM configuring a pyqgis run from a standalone qgis install

REM ==========================================
REM installation details
REM ==========================================
set QVER=QGIS 3.22.8
set IDIR=C:\Program Files\%QVER%
set QREL=qgis-ltr
set PYVER=Python39
ECHo %QVER%
@echo off

REM ==========================================
REM setup script
REM ==========================================
call "%IDIR%\bin\o4w_env.bat"
@echo off
path %OSGEO4W_ROOT%\apps\%QREL%\bin;%PATH%
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/%QREL%
set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\%QREL%\qtplugins;%OSGEO4W_ROOT%\apps\Qt5\plugins
set PYTHONPATH=%OSGEO4W_ROOT%\apps\%QREL%\python;%PYTHONPATH%


REM ==========================================
REM add QGIS dlls
REM ==========================================
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%QREL%\python\plugins
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%PYVER%\
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%PYVER%\DLLs
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%PYVER%\Lib
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%PYVER%\Lib\site-packages
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%QREL%\python\qgis\core\additions
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%QREL%\python\plugins\processing
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\%QREL%\python\plugins\qgis


REM ==========================================
REM print out system setup variables
REM ==========================================
ECHO pyqgis environment  built w/:
ECHO ...

ECHO PROJ_LIB = %PROJ_LIB%
ECHO GDAL_DATA = %GDAL_DATA%

ECHO QREL = %QREL%
ECHO ...

ECHO PATH = 
ECHO %PATH%
ECHO ...

ECHO PYTHONPATH = 
ECHO %PYTHONPATH%
ECHO ...

ECHO PYTHONHOME = %PYTHONHOME%
ECHO ...

