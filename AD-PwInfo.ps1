$username = Read-Host -Prompt "Please enter the username to check"
$server = "Your Server"

Get-ADUser -Identity $username -Server $server -Properties * | Select-Object accountexpirationdate, accountexpires, accountlockouttime, badlogoncount, badpwdcount, lastbadpasswordattempt, lastlogondate, lockedout, passwordexpired, passwordlastset, pwdlastset | Format-List