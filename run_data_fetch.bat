@echo off
REM Data Fetch Runner for Windows Task Scheduler
REM This script runs both databricks_data_fetch.py and forecast_data_fetch.py
REM and logs the output with timestamps

echo ========================================
echo Starting Data Fetch at %date% %time%
echo ========================================

REM Change to the script directory
cd /d "C:\Users\lee.s.61\Procter and Gamble\PO priority - Project Eagles\data"

REM Create logs directory if it doesn't exist
if not exist "logs" mkdir logs

REM Set log file with timestamp
set LOG_FILE=logs\data_fetch_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.log
set LOG_FILE=%LOG_FILE: =0%

echo Logging to: %LOG_FILE%

REM Run databricks_data_fetch.py
echo.
echo ========================================
echo Running databricks_data_fetch.py
echo ========================================
python databricks_data_fetch.py >> "%LOG_FILE%" 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [%date% %time%] databricks_data_fetch.py completed successfully >> "%LOG_FILE%"
) else (
    echo [%date% %time%] databricks_data_fetch.py failed with error code %ERRORLEVEL% >> "%LOG_FILE%"
)

REM Run forecast_data_fetch.py
echo.
echo ========================================
echo Running forecast_data_fetch.py
echo ========================================
python forecast_data_fetch.py >> "%LOG_FILE%" 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [%date% %time%] forecast_data_fetch.py completed successfully >> "%LOG_FILE%"
) else (
    echo [%date% %time%] forecast_data_fetch.py failed with error code %ERRORLEVEL% >> "%LOG_FILE%"
)

echo.
echo ========================================
echo Data Fetch completed at %date% %time%
echo ========================================
echo [%date% %time%] Data fetch batch completed >> "%LOG_FILE%"

REM Keep only last 10 log files to prevent disk space issues
for /f "skip=10 delims=" %%i in ('dir /b /o-d logs\data_fetch_*.log 2^>nul') do del "logs\%%i"

echo Data fetch completed. Check logs folder for details.
