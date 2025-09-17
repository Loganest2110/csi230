function getShutdowns{

param ( $days )

$shutdownstarts = Get-EventLog System -After (Get-Date).Date.AddDays(-$days) | Where-Object { $_.EventId -in 6005,6006 }

$shutdownstartsTable = @()
for ($i = 0; $i -lt $shutdownstarts.Count; $i++) {

$event = ""
if($shutdownstarts[$i].EventId -eq 6005) {$event = "Start"}
if($shutdownstarts[$i].EventId -eq 6006) {$event = "Shutdown"}

$user = "System"

$shutdownstartsTable += [PsCustomObject]@{"Time" = $shutdownstarts[$i].TimeGenerated;
				     "Id" = $shutdownstarts[$i].EventId;
				     "Event" = $event;
				     "User" = $user;
				    }
}
$shutdownstartsTable
}