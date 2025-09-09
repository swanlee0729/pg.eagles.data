# 🕐 Windows Task Scheduler Setup for Data Fetch

This guide will help you set up Windows Task Scheduler to automatically run the data fetch scripts every 3 hours.

## 📋 Prerequisites

1. **Python Environment**: Ensure Python is installed and accessible from command line
2. **Dependencies**: Install required packages:
   ```cmd
   pip install pandas databricks-sql-connector openpyxl
   ```
3. **Environment Variables**: Set up your Databricks credentials (optional if hardcoded)

## 🚀 Setup Steps

### Step 1: Open Task Scheduler
1. Press `Win + R`, type `taskschd.msc`, and press Enter
2. Or search "Task Scheduler" in Start menu

### Step 2: Create Basic Task
1. In the right panel, click **"Create Basic Task..."**
2. **Name**: `Project Eagles Data Fetch`
3. **Description**: `Automatically fetch data from Databricks every 3 hours`
4. Click **Next**

### Step 3: Set Trigger
1. Select **"Daily"**
2. Click **Next**
3. **Start date**: Today's date
4. **Start time**: Set to a convenient time (e.g., 9:00 AM)
5. **Recur every**: `1 days`
6. Click **Next**

### Step 4: Set Action
1. Select **"Start a program"**
2. Click **Next**
3. **Program/script**: Browse to and select:
   ```
   C:\Users\lee.s.61\Procter and Gamble\PO priority - Project Eagles\data\run_data_fetch.bat
   ```
4. **Start in (optional)**: 
   ```
   C:\Users\lee.s.61\Procter and Gamble\PO priority - Project Eagles\data
   ```
5. Click **Next**

### Step 5: Advanced Settings
1. Check **"Open the Properties dialog..."**
2. Click **Finish**

### Step 6: Configure Advanced Properties
In the Properties dialog:

#### General Tab:
- ✅ **Run whether user is logged on or not**
- ✅ **Run with highest privileges**
- **Configure for**: Windows 10

#### Triggers Tab:
1. Select your trigger and click **Edit**
2. **Advanced settings**:
   - ✅ **Repeat task every**: `3 hours`
   - **For a duration of**: `Indefinitely`
   - ✅ **Enabled**
3. Click **OK**

#### Actions Tab:
- Verify the action points to `run_data_fetch.bat`
- **Start in**: `C:\Users\lee.s.61\Procter and Gamble\PO priority - Project Eagles\data`

#### Settings Tab:
- ✅ **Allow task to be run on demand**
- ✅ **Run task as soon as possible after a scheduled start is missed**
- ✅ **If the task fails, restart every**: `10 minutes`
- **Attempt to restart up to**: `3 times`
- ✅ **Stop the task if it runs longer than**: `2 hours`

#### Conditions Tab:
- ✅ **Start the task only if the computer is on AC power**
- ✅ **Stop if the computer switches to battery power**

### Step 7: Test the Task
1. Right-click your task in Task Scheduler
2. Select **"Run"**
3. Check the logs folder for output:
   ```
   C:\Users\lee.s.61\Procter and Gamble\PO priority - Project Eagles\data\logs\
   ```

## 📁 File Structure After Setup

```
data/
├── databricks_data_fetch.py
├── forecast_data_fetch.py
├── run_data_fetch.bat          ← Batch file for scheduler
├── logs/                       ← Auto-created log folder
│   ├── data_fetch_20241201_090000.log
│   ├── data_fetch_20241201_120000.log
│   └── ...
├── material_data.csv           ← Generated files
├── material_data.xlsx
├── material_data.json
├── coo_data.csv
├── coo_data.xlsx
├── coo_data.json
├── combined_data.csv
├── combined_data.xlsx
├── combined_data.json
├── forecast_data.csv
├── forecast_data.xlsx
├── forecast_data.json
├── forecast_summary_data.csv
├── forecast_summary_data.xlsx
└── forecast_summary_data.json
```

## 🔍 Monitoring and Troubleshooting

### Check Task Status
1. Open Task Scheduler
2. Find your task in the task list
3. Check the **"Last Run Result"** column
4. **0x0** = Success, **0x1** = Error

### View Logs
- Logs are saved in the `logs/` folder with timestamps
- Each run creates a new log file
- Only the last 10 log files are kept to save disk space

### Common Issues

#### Python Not Found
- Ensure Python is in your system PATH
- Or modify the batch file to use full Python path:
  ```batch
  C:\Python39\python.exe databricks_data_fetch.py
  ```

#### Permission Issues
- Run Task Scheduler as Administrator
- Ensure the task runs with highest privileges

#### Network Issues
- Check if your Databricks credentials are correct
- Verify network connectivity to Databricks

### Manual Testing
To test the scripts manually:
```cmd
cd "C:\Users\lee.s.61\Procter and Gamble\PO priority - Project Eagles\data"
python databricks_data_fetch.py
python forecast_data_fetch.py
```

## ⚙️ Customization Options

### Change Frequency
- Edit the trigger in Task Scheduler
- Change "Repeat task every" to your desired interval

### Add Email Notifications
You can modify the batch file to send email notifications on success/failure.

### Modify Log Retention
Edit the batch file to change how many log files to keep:
```batch
REM Keep only last 20 log files
for /f "skip=20 delims=" %%i in ('dir /b /o-d logs\data_fetch_*.log 2^>nul') do del "logs\%%i"
```

## 📞 Support

If you encounter issues:
1. Check the log files in the `logs/` folder
2. Verify Python and dependencies are installed
3. Test the scripts manually first
4. Check Task Scheduler event logs for detailed error messages
