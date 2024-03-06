$username = Read-Host -Prompt "Please enter the username to unlock"
$server = "YOUR SERVER"  

Unlock-ADAccount -Identity $username -Server $server