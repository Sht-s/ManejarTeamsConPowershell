function Set-Image{
    [CmdletBinding()] param([Parameter(Mandatory)] [string] $userID)
    $opc = 1
    do{
        $Error.Clear()
        $name = Read-Host -Prompt "`nIngrese el nombre exacto del Team al que le desea cambiar su imagen: "
        $team = Get-Team -User $userID -DisplayName $name -ErrorAction SilentlyContinue
        if($Error.count -ne 0){
            $opc = Read-Host -Prompt "Nombre inválido. ¿Desea seguir intentando? (CualquierNúmero = SI, 0 = NO): "
        }
    }while (($opc -ne 0) -and ($Error.count -ne 0))
    
    if($opc -eq 0){
        Write-Host "`nNo se ha cambiado ninguna imagen. Regresamos al menú...`n"
        Break
    }
    $teamID = $team.GroupId
    $opc = 1
    do{
        $Error.Clear()
        $dir = Read-Host -Prompt "`nIngrese la dirección (con extensión) de la imagen que desea poner: "
        Set-TeamPicture -GroupId $teamID -ImagePath $dir -ErrorAction SilentlyContinue
        if($Error.count -ne 0){
            $opc = Read-Host -Prompt "Dirección o archivo inválidos. ¿Desea seguir intentando? (CualquierNúmero = SI, 0 = NO): "
        }
    }while (($opc -ne 0) -and ($Error.count -ne 0))
    
    if($opc -eq 0){
        Write-Host "`nNo se ha cambiado ninguna imagen. Regresamos al menú...`n"
        Break
    }
    Write-Host "`nSe ha actualizado la imagen del Team $name.`n"
}
