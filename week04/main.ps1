. (Join-Path C:\Users\Logan\csi230\week04 Apache-Logs.ps1)
. (Join-Path C:\Users\Logan\csi230\week04 ApacheLogs1.ps1)

addressGetter -page page1.html -code 200 -browser Chrome

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -Autosize -Wrap