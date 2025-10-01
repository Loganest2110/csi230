. (Join-Path C:\Users\Logan\csi230\week05 ClassGatherer.ps1)

$result = daysTranslator (gatherClasses)

$classesByInstructor = $result | Where-Object { $_.Instructor -ilike "*Furkan*" }

$classesByInstructor

$classesByRoomAndDay = $result | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -ilike "Monday") } | Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code"

$classesByRoomAndDay

$ITSInstructors = $result | Where-Object {   ($_."Class Code" -ilike "SYS*") -or `
					     ($_."Class Code" -ilike "NET*") -or `
					     ($_."Class Code" -ilike "SEC*") -or `
					     ($_."Class Code" -ilike "FOR*") -or `
					     ($_."Class Code" -ilike "CSI*") -or `
					     ($_."Class Code" -ilike "DAT*") } | Select-Object "Instructor" | Sort-Object "Instructor" -Unique

$ITSInstructors

$result | Where-Object {$_.Instructor -in $ITSInstructors.Instructor} | Select-Object Count,Name | Group-Object "Instructor" | Sort-Object Count -Descending