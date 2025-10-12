. (Join-Path C:\Users\Logan\csi230\week04 ApacheLogs.ps1)
. (Join-Path C:\Users\Logan\csi230\week06 Event-Logs.ps1)
. (Join-Path C:\Users\Logan\csi230\week06 main-1.ps1)
. (Join-Path C:\Users\Logan\csi230\week01 Process4.ps1)

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start chrome web browser and navigate it to champlain.edu`n"
$Prompt += "5 - Exit `n"

$operation = $true

while($operation) {

    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if($choice -eq 1) {
	$tableRecords = ApacheLogs1
	$tableRecords | Format-Table -Autosize -Wrap
    }

    elseif($choice -eq 2) {
	$failedLogins = getFailedLogins 10
	Write-Host ($userLogins | Format-Table | Out-String)
    }

    elseif($choice -eq 3) {
	displayAtRiskUsers
    }

    elseif($choice -eq 4) {
	openPage
    }

    elseif($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    else {
	Write-Host "Please enter one of the given choices." | Out-String
    }
}