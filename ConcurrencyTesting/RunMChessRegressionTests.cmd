@ECHO OFF
@IF "%ChessConfig%" == "" @SET ChessConfig=Release

:: Make sure the folder is created and empty
@ECHO Setting up temp folder...
@SET TempFldrName=RegressionTests
@IF EXIST %TempFldrName%\ (
	::@ECHO Removing existing temp folder: %TempFldrName%
	:RMDIR_Tmp
	RMDIR %TempFldrName% /S /Q
	@IF EXIST %TempFldrName%\ GOTO RMDIR_Tmp
)
@IF NOT EXIST %TempFldrName%\ (
	::@ECHO Creating temp folder: %TempFldrName%
	:MD_Tmp
	MD %TempFldrName%
	@IF NOT EXIST %TempFldrName%\ GOTO MD_Tmp
)
@ECHO Temp folder setup complete.
@CD %TempFldrName%

@ECHO ON
@ECHO.
@ECHO Starting MCut...
SETLOCAL ENABLEDELAYEDEXPANSION

:: Build a new argument string excluding the first one
SET COUNT=0
SET ARGS=
FOR %%A IN (%*) DO (
    SET /A COUNT+=1
    IF !COUNT! GTR 1 SET ARGS=!ARGS! %%A
)

mcut runAllTests ..\..\ConcurrencyTools\RegressionTesting\MChess\bin\%ChessConfig%\MChess.RegressionTests.dll %ARGS%
::mcut runAllTests ..\..\ConcurrencyTools\RegressionTesting\RegressionTesting.TestList.%ChessConfig%.xml
::@IF NOT ERRORLEVEL 0 PAUSE

@PAUSE