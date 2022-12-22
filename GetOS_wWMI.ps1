$comps = New-Object System.Collections.Generic.List[System.Object]
Get-ADObject -LDAPFilter "(objectClass=computer)" | ForEach-Object {
    $currComp = $_.name
    Try {
        $comps.add([PSCustomObject]@{"Hostname"=$_.name;
                                     "OS"="$($(Get-WmiObject -ComputerName $_.name -Class 'Win32_OperatingSystem' -ErrorAction Stop).Caption)"
                                   })
    }
    Catch {
        $comps.add([PSCustomObject]@{"Hostname"=$currComp;
                                     "OS"="Unavailable. Exception: $($_.Exception.Message)"
                                     })
    }
}

$comps | Select-Object
