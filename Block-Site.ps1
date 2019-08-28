﻿New-Variable -Name DNS_PARAMETER -Value 8.8.8.8 -Scope Script

function Block-TrafficToURL() {
    <#
    .SYNOPSIS
        Blocks HTTP traffic to the given domain
    .DESCRIPTION
        TODO
    .PARAMETER domain
        The domain name of the site to block, such as "reddit.com".
    .NOTES
        Detail on what the script does, if this is needed. TODO
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        # TODO validate
        #[ValidateScript({$_ -ge (get-date)})]
        [String] $domain
    )

    Process {
        $IPs = Resolve-DnsName -Name $domain -Server $DNS_PARAMETER -NoHostsFile | Select-Object -Property IPAddress
        # TODO
    }
}

# https://github.com/PoshCode/PowerShellPracticeAndStyle
#
# Instead Of           Use
# ----------           ---
# $env:USERNAME        [Environment]::UserName
# $env:COMPUTERNAME    [Environment]::MachineName
# `n                   [Environment]::NewLine
# `r`n                 [Environment]::NewLine
# $env:TEMP            [IO.Path]::GetTempDirectory()