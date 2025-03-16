# Edgar Ruiz Diaz

# Instalamos el modulo MicrosoftTeams que usaremos para trabajar
Write-Host "Instalando módulo necesario para funcionar..."
Start-Sleep -Seconds 5
Install-Module MicrosoftTeams

# La bienvenida al usuario
Write-Host "`nBienvenid@ al Teams Manager, programa que le permitirá ver, crear o modificar su Microsoft Teams. `n"
Start-Sleep -Seconds 2

# Le pedimos sus credenciales hasta que sean correctas o hasta que el usuario quiera dejar de intentar
$opc = 1
do{
    $Error.Clear()
    Write-Host "`nIngrese su correo y contraseña de Teams para comenzar: `n"
    Start-Sleep -Seconds 3
    $credential = Get-Credential -ErrorAction SilentlyContinue
    # Intentamos conectarnos a Microsoft Teams con el usuario y contraseña proporcionados.
    Connect-MicrosoftTeams -Credential $credential -ErrorAction SilentlyContinue
    if ($Error.count -ne 0){
        $opc = Read-Host -Prompt "Credenciales inválidas. ¿Desea seguir intentando? (CualquierNúmero = SI, 0 = NO): "
    }
}while (($opc -ne 0) -and ($Error.count -ne 0))

# Cerramos el programa si el usuario no ha querido seguir intentando.
if($opc -eq 0){
    Write-Host "`nGracias por haber utilizado el programa. ¡Hasta pronto!"
    Break
}
$ID = $credential.UserName

# Comenzamos el Menú
do{
    $do = Read-Host -Prompt "MENU:`n  1)Mostrar la información de mis Teams`n  2)Crear un nuevo Team`n  3)Eliminar un Team propio`n  4)Agregar un integrante a un Team propio`n  5)Cambiar la imagen de un Team propio`n  6)Generar reporte (.txt) con la informacion de mis Teams`n  0)SALIR`n`n¿Qué desea realizar?"
    Write-Host ""
    Switch ($do){
        0 {Write-Host "Gracias por haber utilizado el programa. ¡Hasta pronto!"}
        1 {Get-MSTeams -userID $ID}
        2 {New-MSTeams}
        3 {Remove-MSTeams -userID $ID}
        4 {Add-Users -userID $ID}
        5 {Set-Image -userID $ID}
        6 {Read-MSTeams -userID $ID}
        default {Write-Host "ERROR. Ingrese una opción válida."}
    }
    Write-Host ""
}while ($do -ne 0)
