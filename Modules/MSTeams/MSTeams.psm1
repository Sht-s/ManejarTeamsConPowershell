function Get-MSTeams{
    [CmdletBinding()] param([Parameter(Mandatory)] [string] $userID)
    $teams = Get-Team -User $userID
    return $teams
}

function New-MSTeams{
    $name = Read-Host -Prompt "`nIngrese el nombre de su nuevo Team: "
    $descript = Read-Host -Prompt "Ingrese la descripción de su nuevo Team: "
    New-Team -DisplayName $name -Description $descript
    Write-Host "`nTeam creado.`n"
}

function Remove-MSTeams{
    [CmdletBinding()] param([Parameter(Mandatory)] [string] $userID)
    $opc = 1
    do{
        $Error.Clear()
        $name = Read-Host -Prompt "`nIngrese el nombre exacto del Team que desea eliminar: "
        $team = Get-Team -User $userID -DisplayName $name -ErrorAction SilentlyContinue
        if($Error.count -ne 0){
            $opc = Read-Host -Prompt "Nombre inválido. ¿Desea seguir intentando? (CualquierNúmero = SI, 0 = NO): "
        }
    }while (($opc -ne 0) -and ($Error.count -ne 0))
    
    if($opc -eq 0){
        Write-Host "`nNo se ha eliminado ningún Team. Regresamos al menú...`n"
        Break
    }
    $teamID = $team.GroupId
    Remove-Team -GroupId $teamID
    Write-Host "`nTeam eliminado.`n"
}

function Read-MSTeams{
    [CmdletBinding()] param([Parameter(Mandatory)] [string] $userID)
    $teamsinfo = Get-Team -User $userID
    $opc = 1
    do{
        $Error.Clear()
        $name = Read-Host -Prompt "`nIngrese el nombre que le quiere dar al reporte de sus Teams: "
        $dir = Read-Host -Prompt "`nIngrese la ruta exacta donde quiere guardar su '$name.txt': "
        $finaldir = "$dir$name.txt"
        Set-Content $finaldir $teamsinfo -ErrorAction SilentlyContinue
        if($Error.count -ne 0){
            $opc = Read-Host -Prompt "Datos inválidos. ¿Desea seguir intentando? (CualquierNúmero = SI, 0 = NO): "
        }
    }while (($opc -ne 0) -and ($Error.count -ne 0))
    
    if($opc -eq 0){
        Write-Host "`nVamos a guardar el reporte en la ruta C:\Users\Public\Documents\`n"
        $finaldir = "C:\Users\Public\Documents\$name.txt"
        Set-Content $finaldir $teamsinfo
    }
    Write-Host "`nReporte creado.`n"
}
