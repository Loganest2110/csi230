function addressGetter($page, $code, $browser){

$notfounds = Get-Content C:\xampp\apache\logs\access.log | Where-Object {$_ -match $code -and $_ -match $page -and $_ -match $browser}

$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"

if($notfounds) {
	$ipsUnorganized = $regex.Matches($notfounds)
}

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
  $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

$ipsoften = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoften | Group-Object -Property IP
$counts | Select-Object Count, Name
}