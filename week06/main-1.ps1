. (Join-Path C:\Users\Logan\csi230\week06 Users.ps1)
. (Join-Path C:\Users\Logan\csi230\week06 Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "0 - List At Risk Users`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"


	if(checkUser $name) {
	   Write-Host "User already exists." | Out-String
	   return
	}

	if((checkPassword $password) -eq $false) {
	   Write-Host "Password does not meet criteria." | Out-String
	   return
	}

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

	if((checkUser $name) -eq $false) {
	   Write-Host "User doesn't exist." | Out-String
	   return
	}

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if((checkUser $name) -eq $false) {
	   Write-Host "User doesn't exist." | Out-String
	   return
	}

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

	if((checkUser $name) -eq $false) {
	   Write-Host "User doesn't exist." | Out-String
	   return
	}

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"
	$days = Read-Host -Prompt "Please enter the amount of days back you want to check."
	
	if((checkUser $name) -eq $false) {
	   Write-Host "User doesn't exist." | Out-String
	   return
	}

        $userLogins = getLogInAndOffs $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
        $days = Read-Host -Prompt "Please enter the amount of days back you want to check."

	if((checkUser $name) -eq $false) {
	   Write-Host "User doesn't exist." | Out-String
	   return
	}

        $userLogins = getFailedLogins $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

   elseif($choice -eq 0){

        $days = Read-Host -Prompt "Please enter the amount of days back you want to check."

	$userLogins = getFailedLogins $days
	
	$userLogins = $userLogins | Group-Object | Select-Object Name, Count

	foreach($userLogin in $userLogins) {
	   if($userLogin.Count -gt 10) {
	      Write-Host "$userLogin.Name `n" | Out-String
	   }
	}
   }

   else {
	Write-Host "Please enter one of the given choices." | Out-String
   }


}




