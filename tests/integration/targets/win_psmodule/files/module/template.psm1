Function Get-Function {
    <#
    .SYNOPSIS
    Help for Get-Function

    .DESCRIPTION
    Description for Get-Function

    .EXAMPLE
    Get-Function

    .NOTES
    Notes for Get-Function
    #>
    return [PSCustomObject]@{
        Name = "--- NAME ---"
        Version = "--- VERSION ---"
        Repo = "--- REPO ---"
    }
}

Export-ModuleMember -Function Get-Function

