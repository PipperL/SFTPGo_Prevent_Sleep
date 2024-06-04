# SFTPGo_Prevent_Sleep
SFTPGo Event action - Keep Windows alive



### Purpose

These scripts are used for keep windows 11 alive while serving the content to remote player (aka Kodi in my case).

### Requirement

- SFTPGo installed
- PowerShell installed (should shipped with Windows

### Installation
1. Copy the scripts to your harddrive (eg: d:\code\SFTPGo_Prevent_Sleep\)
2. Setup SFTPGo Event actions in SFTPGo WebAdmin -> Event Manager -> Event actions.
   You can refer the following screenshots for setting the Command and Arguments fields.
   
3. Setup SFTPGo Event rules in SFTPGo WebAdmin -> Event Manager -> Event rules.   
3.1: Setup an event triggered when serving the contents (aka. Fs events download), actions link to SET_stream_flag as shown in step 2.
3.2: Setup an event scheduled (per hour), executing the corresponding action (Check_flag_and_Prevent_sleep).

4. The minimum schedule interval of SFTPGo is 1 hour. so it is better to make the Windows idle time (before entering the sleep/standby) larger then 1 hour.

### Debug
If everything goes well, you shall find:
- After starting serving the contents (download begin), the timestamp flag (SFTPGO_CONNECTION_ONGOING.txt) was created and the file modified time is updated.
- After scheduled time (default begin of every hour), the Powershell script will be executed. You can check if the "prevent sleep" is effective by checking executeing the following command under cmd (adminstrater mode needed)
```
powercfg /requests
```
- you can also check some details by manually executing the following command under cmd:
```
powershell Check_timestamp.ps1
```
	
 
