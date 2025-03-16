function Add-Users{
    [CmdletBinding()] param([Parameter(Mandatory)] [string] $userID)
    $opc = 1
    do{
        $Error.Clear()
        $name = Read-Host -Prompt "`nIngrese el nombre exacto del Team al que le desea agregar un integrante: "
        $team = Get-Team -User $userID -DisplayName $name -ErrorAction SilentlyContinue
        if($Error.count -ne 0){
            $opc = Read-Host -Prompt "Nombre inv�lido. �Desea seguir intentando? (CualquierN�mero = SI, 0 = NO): "
        }
    }while (($opc -ne 0) -and ($Error.count -ne 0))
    
    if($opc -eq 0){
        Write-Host "`nNo se ha agregago integrante a ning�n Team. Regresamos al men�...`n"
        Break
    }
    $teamID = $team.GroupId
    $opc = 1
    do{
        $Error.Clear()
        $newuser = Read-Host -Prompt "`nIngrese el correo electr�nico del integrante que desea agregar: "
        Add-TeamUser -GroupId $teamID -User $newuser -ErrorAction SilentlyContinue
        if($Error.count -ne 0){
            $opc = Read-Host -Prompt "Correo inv�lido. �Desea seguir intentando? (CualquierN�mero = SI, 0 = NO): "
        }
    }while (($opc -ne 0) -and ($Error.count -ne 0))
    
    if($opc -eq 0){
        Write-Host "`nNo se ha agregago integrante a ning�n Team. Regresamos al men�...`n"
        Break
    }
    Write-Host "`nSe ha agregado a un integrante nuevo.`n"
}
