function Set-Aliased {
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,HelpMessage='What is your script?')]
        $ps1
    )
    Write-Host "Running" -f cyan
    if (Test-Path (($ps1 -replace ".ps1","") + "-aliased.ps1")){
        Write-Host "Found Duplicate Aliased File - Removing" -f Red
        Remove-Item (($ps1 -replace ".ps1","") + "-aliased.ps1")
    }
    foreach ($line in (Get-Content $ps1)){
        #Write-Host $line -b black -NoNewline -f cyan
        foreach ($word in $line.Split(" ")[0..(($line.Split(" ")).Length -1)]){
                if (($word -like '*-*') -and ($word[0] -ne '-')){
                    if ($word -match '[(]|[{]'){
                        if($word.IndexOf("(") -eq -1){
                            #not (
                            $word = $word.Substring($word.IndexOf("{")+1)
                        }
                            if($word.IndexOf("{") -eq -1){
                            #not {
                            $word = $word.Substring($word.IndexOf("(")+1)
                        }   
                    }
                    Write-Host $word -b black -f darkcyan
                    #Slow Part
                    foreach ($cmd in ((Get-Alias).Definition | Sort-Object -Unique)){
                        #Write-Host $cmd -b black -NoNewline -f red
                        $alias = Get-Alias | Where-Object {$_.Definition -eq "$cmd"} | Select Name
                        If (($alias).Length -ge 2){$alias = ($alias).Name[0]}
                        Else {$alias = ($alias).Name}
                        #Write-Host $alias -b black -f DarkRed
                        if ($word -eq $cmd){
                            $line = $line -replace "$word", "$alias"
                            Write-Host "`"$word`" matches `"$cmd`" - Replaced with `"$alias`"" -f green
                        }
                    #cmd
                    }
                #word
                }
            }
        $line | Out-File (($ps1 -replace ".ps1","") + "-aliased.ps1") -encoding ascii -Append
    #line
    }
#function
Write-Host "Done" -f cyan
}
Set-Aliased -ps1 ./aliasme.ps1