# __main__

# check timestamp

$TimeStampFileName = "SFTPGO_CONNECTION_ONGOING.txt"
# KEEP_ALIVE_TIME: can be set to make the server alive (not going sleep). 
# Normally a movie is 2-hours long. So I set the time as 2.5hr (150min)
#
$KEEP_ALIVE_TIME = "150" #unit: minutes


# Check if file existed, if no, means no connection ongoing, exit.

$TimeStampFilePath = "$PSScriptRoot\$TimeStampFileName"

# Write-Host $TimeStampFilePath
if (Test-Path -path $TimeStampFilePath -PathType Leaf ) {
	Write-Host "The file exists" -f green
	# check if the TimeStampFile is expired
	$FileDate = [datetime](Get-Item $TimeStampFilePath).LastWriteTime
	$ThresholdDate = $FileDate.AddMinutes($KEEP_ALIVE_TIME)
	$CurrentDate = Get-Date
	$TimeDiff = ($ThresholdDate - $CurrentDate).TotalMinutes
	$SleepTime = [Math]::Ceiling($TimeDiff)
	$SleepTimeSecond = $SleepTime *60  #convert to seconds
	
	# Write-Host $ThresholdDate		#DEBUG
	Write-Host "File Date: $FileDate"
	Write-Host "ThresholdDate: $ThresholdDate"
	Write-Host "CurrentDate: $CurrentDate"
	Write-Host "Target TimeDiff: $TimeDiff"
	Write-Host "Target SleepTime (sec): $SleepTimeSecond"
	
	if ((Get-Date) -gt $ThresholdDate) {
		Write-Host "The file is expired."
		Write-Host "Removing TimeStampFile..."		
		Remove-Item $TimeStampFilePath		
	} else {
		Write-Host "The file is not expired."
		Write-Host "Firing up Suspend-Powerplan function for $SleepTimeSecond seconds ..."
		
		Start-Process -FilePath "powershell" -ArgumentList "$PSScriptRoot\Suspend-Powerplan.ps1 -SleepTimeSecond $SleepTimeSecond"
		
		
		#& "$PSScriptRoot\Suspend-Powerplan.ps1" -SleepTimeSecond $SleepTimeSecond
		#& "$PSScriptRoot\Suspend-Powerplan.ps1" 
		#Start-Process -FilePath "powershell" -ArgumentList "Get-ExecutionPolicy >>d:\tmp\log.txt; $PSScriptRoot\Suspend-Powerplan.ps1 -SleepTimeSecond $SleepTimeSecond" -RedirectStandardError "d:\tmp\log2.txt"
	
	}
	
} else {
	Write-Host "The file does not exist" -f yellow
}	



