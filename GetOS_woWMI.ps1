Get-ADComputer -Filter * -Properties Name, OperatingSystem | Select-Object Name, OperatingSystem | Tee-Object -Variable results | 
Export-CSV -Path ".\OSReport-$((get-addomain).forest)-$(Get-Date -Format MMddyyyy_HHmmss).csv"
$results