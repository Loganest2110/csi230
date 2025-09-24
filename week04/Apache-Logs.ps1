$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String "404"

$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
  $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

$ipsoften = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoften | Group-Object -Property IP
$counts | Select-Object Count, Name