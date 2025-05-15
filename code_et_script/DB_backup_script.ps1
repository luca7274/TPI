# Parametres
$serverName = "win-srv-express\SQLEXPRESS"  # nom du server\instance
$sourceDatabaseName = "DB_magasin"  #nom de la base de données source
$backupFolder = "C:\Backups"  #dossier de backup
$date = Get-Date -Format "yyyyMMdd_HHmmss"  #timestamp du fichier backup
$backupFile = "$backupFolder\$sourceDatabaseName" + "_$date.bak"

# S'assure que le dossier existe
if (-not (Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder
}

# Commande de backup sql
$sql = "BACKUP DATABASE [$sourceDatabaseName] TO DISK = N'$backupFile' WITH NOFORMAT, INIT, NAME = '$databaseName-Full Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10"

# Execution de la commande avec sqlcmd
sqlcmd -S $serverName -Q $sql

Write-Host "Sauvegarde terminée : $backupFile"