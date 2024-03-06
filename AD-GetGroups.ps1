$username = Read-Host "Enter the username"
$server = "YOUR SERVER"
$user = Get-ADUser -Identity $username -Server $server -Properties MemberOf
$groups = $user.MemberOf | Get-ADGroup -Server $server | Select-Object -ExpandProperty Name
$groups | Sort-Object | ForEach-Object { Write-Output $_ }