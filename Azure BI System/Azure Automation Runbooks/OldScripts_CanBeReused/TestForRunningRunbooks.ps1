workflow TestForRunningRunbooks
{
    <#
    Write-Output "ch1"
    $result = Call-StoredProcWithoutParameters
    Write-Output "ch2"
    foreach($x in $result)
    {
        Write-Output "ch3"
        $x.ComponentName;
        $x.ComponentType;
    }
    Write-Output "ch4"
    #>
    $time = [System.DateTime]::UtcNow;
    Write-Output "Execution time: $time";
}