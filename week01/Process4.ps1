function openPage() {

$name = "chrome"
$url = "https://champlain.edu"
$process = Get-Process -Name $name
if ($process) {
Stop-Process -Name $name
}
else {
Start-Process "chrome.exe" $url
}

}