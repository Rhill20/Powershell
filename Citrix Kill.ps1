$processNames = @("SelfService", "Receiver", "concentr", "redirector", "SelfServicePlugin", "AuthManSvr")

foreach ($processName in $processNames) {
    Get-Process -Name $processName | Stop-Process -Force
}