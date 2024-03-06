$username = Read-Host "Enter the username"
$server = "YOUR SERVER" 
Get-ADUser $username -Properties * -Server $server | Select -ExpandProperty Manager