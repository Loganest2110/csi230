function getLogs{

param ( $days )

$loginouts = Get-EventLog Security -source Microsoft-Windows-Security-Auditing -After (Get-Date).Date.AddDays(-$days) | Where-Object { $_.InstanceId -in 4624,4634 }

$loginoutsTable = @()
for ($i = 0; $i -lt $loginouts.Count; $i++) {

$event = ""
if($loginouts[$i].InstanceId -eq 4624) {$event = "Logon"}
if($loginouts[$i].InstanceId -eq 4634) {$event = "Logout"}

$user = $loginouts[$i].ReplacementStrings[5]

$loginoutsTable += [PsCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
				     "Id" = $loginouts[$i].InstanceId;
				     "Event" = $event;
				     "User" = $user;
				    }
}
$loginoutsTable
}