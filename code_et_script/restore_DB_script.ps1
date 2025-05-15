# Parametres
$serverName = "win-srv-express\SQLEXPRESS"
$sourceDatabaseName = "DB_magasin"
$targetDatabaseName = "DB_RESTORED"
$backupFolder = "C:\Backups"

# Trouver le dernier fichier de backup
$backupFile = Get-ChildItem -Path $backupFolder -Filter "$sourceDatabaseName*.bak" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# Verifie si le fichier est trouve
if (-not $backupFile) {
    Write-Error "Aucun fichier de sauvegarde trouvé pour $sourceDatabaseName dans $backupFolder"
    exit
}

# Requete pour lire le contenu de la sauvegarde
$dbFilesQuery = @"
RESTORE FILELISTONLY
FROM DISK = N'$($backupFile.FullName)'
"@

# Requete sqlcmd
$dbFiles = sqlcmd -S $serverName -Q $dbFilesQuery -h -1

# Verifie si le contenu est lisible
if (-not $dbFiles) {
    Write-Error "Impossible de lire le contenu du fichier de sauvegarde."
    exit
}


# Extraire les noms logiques (Date et Log)
$fileLines = $dbFiles -split "`r`n"
$logicalDataName = ($fileLines[0] -split "\s+")[0]
$logicalLogName = ($fileLines[1] -split "\s+")[0]

# Dossiers pour les fichiers a restaures
$restorePath = "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA"  # dossier dans le quel on veux restaure les fichiers
$dataFile = "$restorePath\$targetDatabaseName.mdf"
$logFile = "$restorePath\$targetDatabaseName.ldf"

# Requete pour restaure la base de données
$restoreQuery = @"
RESTORE DATABASE [$targetDatabaseName]
FROM DISK = N'$($backupFile.FullName)'
WITH MOVE N'$logicalDataName' TO N'$dataFile',
     MOVE N'$logicalLogName' TO N'$logFile',
     REPLACE,
     STATS = 10;
"@

# Execution de la requete
sqlcmd -S $serverName -Q $restoreQuery

Write-Host "Base restaurée : $targetDatabaseName à partir de $($backupFile.Name)"
