New-Variable -Name DNS_PARAMETER -Value 8.8.8.8 -Scope Script -Force
New-Variable -Name PORT_PARAMETER -Value 443 -Scope Script -Force

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
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        # TODO validate
        #[ValidateScript({$_ -ge (get-date)})]
        [String] $domain #TODO convert to string array for multiple blocks?
    )

    Process {
        #$IPs = Resolve-DnsName -Name $domain -Server $DNS_PARAMETER -NoHostsFile | Select-Object -Property IPAddress | Out-String
        $IPs = Resolve-DnsName -Name $domain -Server $DNS_PARAMETER -NoHostsFile | Foreach {"$($_.IPAddress)"} | Out-String
        Write-Verbose("`$IPs`:" + $IPs)
        New-NetFirewallRule -DisplayName "Block {$domain}" -Direction Outbound -LocalPort $PORT_PARAMETER -Protocol TCP -Action Block -RemoteAddress $IPs -Verbose
    }
}

Block-TrafficToURL "reddit.com" -Verbose

# https://github.com/PoshCode/PowerShellPracticeAndStyle
#
# Instead Of           Use
# ----------           ---
# $env:USERNAME        [Environment]::UserName
# $env:COMPUTERNAME    [Environment]::MachineName
# `n                   [Environment]::NewLine
# `r`n                 [Environment]::NewLine
# $env:TEMP            [IO.Path]::GetTempDirectory()