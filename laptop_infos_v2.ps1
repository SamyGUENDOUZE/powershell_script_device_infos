# [FR]

# Pour trouver les propriétes de chaque fonction, on peut aller sur https://learn.microsoft.com/fr-fr/windows/win32/cimwin32prov/[nom de l'objet]
# Par exemple, si on veut voir les propriétés de Win32_DiskPartition, on va sur https://learn.microsoft.com/fr-fr/windows/win32/cimwin32prov/Win32_DiskPartition

# [US]

# More informations about each functions's propertie at https://learn.microsoft.com/fr-fr/windows/win32/cimwin32prov/[Object name]
# By example, if one wants to see the properties of Win32_DiskPartition, go to :  https://learn.microsoft.com/fr-fr/windows/win32/cimwin32prov/Win32_DiskPartition


$file_destination = "C:\Replace\With\The\Correct\Path\$env:COMPUTERNAME-$env:USERNAME.log" # It doesn't have to start with the letter C

$deb = (Get-Date).ToString("yyyy-MM-dd - HH:mm:ss") | Out-File -FilePath $file_destination -Encoding default
"##########################################################################################################"  | Out-File -FilePath $file_destination -Encoding default -Append

function GetRAMDetails {
    
    $ramInfos = Get-WmiObject -Class Win32_PhysicalMemory

    # [FR] Création d'un dictionnaire pour traduire les codes MemoryType
    # [US] Creating a dictionary to translate MemoryType codes

    $memoryTypeDictionary = @{
        0  = "Autre"
        1  = "Inconnu"
        2  = "DRAM"
        3  = "Synchronous DRAM"
        4  = "Cache DRAM"
        5  = "EDO"
        6  = "EDRAM"
        7  = "VRAM"
        8  = "SRAM"
        9  = "RAM"
        10 = "ROM"
        11 = "Flash"
        12 = "EEPROM"
        13 = "FEPROM"
        14 = "EPROM"
        15 = "CDRAM"
        16 = "3DRAM"
        17 = "SDRAM"
        18 = "SGRAM"
        19 = "RDRAM"
        20 = "DDR"
        21 = "DDR2"
        22 = "DDR2 FB-DIMM"
        24 = "DDR3"
        25 = "FBD2"
        26 = "DDR4"
        27 = "LPDDR"
        28 = "LPDDR2"
        29 = "LPDDR3"
        30 = "LPDDR4"
    }

    $slotCount = $ramInfos.Count
    $totalCapacity = 0
    $usedSlots = 0

    " "  | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    foreach ($ram in $ramInfos) {
        $totalCapacity += $ram.Capacity
        if ($ram.Capacity -gt 0) {
            $usedSlots++
        }

        "Slot: $($ram.DeviceLocator)"  | Out-File -FilePath $file_destination -Encoding default -Append
        "Type: $($memoryTypeDictionary[[int]$ram.SMBIOSMemoryType])" | Out-File -FilePath $file_destination -Encoding default -Append
        "Fréquence: $([math]::Round($ram.Speed)) MHz" | Out-File -FilePath $file_destination -Encoding default -Append
        "Capacité: $(($ram.Capacity/1GB)) GB"  | Out-File -FilePath $file_destination -Encoding default -Append
        "-----------------------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }

    "Capacité totale de RAM: $(($totalCapacity/1GB)) GB" | Out-File -FilePath $file_destination -Encoding default -Append
    "Nombre total de slots: $slotCount" | Out-File -FilePath $file_destination -Encoding default -Append
    "Nombre de slots utilisés: $usedSlots" | Out-File -FilePath $file_destination -Encoding default -Append
    "Nombre de slots libres: $($slotCount - $usedSlots)" | Out-File -FilePath $file_destination -Encoding default -Append
}

function GetOSDetails {
    
    $osInfo = Get-WmiObject -Class Win32_OperatingSystem

    " "  | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "OS: $($osInfo.Caption)"  | Out-File -FilePath $file_destination -Encoding default -Append
    "Version: $($osInfo.Version)"  | Out-File -FilePath $file_destination -Encoding default -Append
}

function GetComputerDetails {
    
    $computerInfo = Get-WmiObject -Class Win32_ComputerSystem

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Nom de l'ordinateur: $($computerInfo.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Fabricant: $($computerInfo.Manufacturer)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Modèle: $($computerInfo.Model)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Type: $($computerInfo.SystemType)" | Out-File -FilePath $file_destination -Encoding default -Append
}

function GetProcessorDetails {
    
    $processorInfo = Get-WmiObject -Class Win32_Processor

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Processeur: $($processorInfo.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Description: $($processorInfo.Description)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Fabricant: $($processorInfo.Manufacturer)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Vitesse d'horloge: $($processorInfo.MaxClockSpeed) MHz" | Out-File -FilePath $file_destination -Encoding default -Append
    "Nombre de coeurs: $($processorInfo.NumberOfCores)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Nombre de threads: $($processorInfo.NumberOfLogicalProcessors)" | Out-File -FilePath $file_destination -Encoding default -Append
}

function GetBIOSDetails {
    
    $biosInfo = Get-WmiObject -Class Win32_BIOS

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails du BIOS~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Fabricant: $($biosInfo.Manufacturer)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Version: $($biosInfo.Version)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Date de sortie: $($biosInfo.ReleaseDate)" | Out-File -FilePath $file_destination -Encoding default -Append
    "Numéro de série: $($biosInfo.SerialNumber)" | Out-File -FilePath $file_destination -Encoding default -Append
}

function GetDiskPartitionDetails {

    $partitionsInfo = Get-WmiObject -Class Win32_DiskPartition

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails des partitions de disque~" | Out-File -FilePath $file_destination -Encoding default -Append

    # [FR] La boucle foreach est utile dans le cas où il y a plusieurs partitions
    # [US] The foreach loop is useful when there are several partitions

    foreach ($partitionInfo in $partitionsInfo) {
        "Nom: $($partitionInfo.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Type: $($partitionInfo.Type)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Taille: $($partitionInfo.Size / 1GB) GB"  | Out-File -FilePath $file_destination -Encoding default -Append
        "Bootable: $($partitionInfo.BootPartition)" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetLogicalDiskDetails {
    
    $logicalDisks = Get-WmiObject -Class Win32_LogicalDisk
    
    $driveTypeDictionary = @{
        0 = "Type inconnu"
        1 = "Pas de média"
        2 = "Lecteur de disquette"
        3 = "Disque dur"
        4 = "Lecteur réseau"
        5 = "Lecteur CD-ROM"
        6 = "Lecteur RAM"
    }

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails des disques logiques~" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($disk in $logicalDisks) {
        "Nom du disque: $($disk.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Type: $($driveTypeDictionary[[int]$disk.DriveType])" | Out-File -FilePath $file_destination -Encoding default -Append
        "Système de fichiers: $($disk.FileSystem)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Taille totale: $($disk.Size / 1GB) GB" | Out-File -FilePath $file_destination -Encoding default -Append
        "Espace libre: $($disk.FreeSpace / 1GB) GB" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetNetworkAdapterConfigurationDetails {

    $networkAdapters = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails des configurations d'adaptateur réseau~" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($adapter in $networkAdapters) {
        "Description: $($adapter.Description)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Adresse IP: $($adapter.IPAddress -join ', ')" | Out-File -FilePath $file_destination -Encoding default -Append
        "Passerelle par défaut: $($adapter.DefaultIPGateway -join ', ')" | Out-File -FilePath $file_destination -Encoding default -Append
        "Serveur DNS: $($adapter.DNSServerSearchOrder -join ', ')" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetUserAccountDetails {
    
    $userAccounts = Get-WmiObject -Class Win32_UserAccount

    $accountTypeDictionary = @{
        256 = "Compte utilisateur local"
        512 = "Compte utilisateur global"
        2048 = "Compte système local"
        4096 = "Compte de domaine"
        8192 = "Compte de service du compte ordinateur"
        16384 = "Compte de service du compte utilisateur"
    }

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails des comptes utilisateurs~" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($account in $userAccounts) {
        "Nom: $($account.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Nom complet: $($account.FullName)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Domaine: $($account.Domain)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Type: $($accountTypeDictionary[[int]$account.AccountType])" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetGroupDetails {
    
    $groups = Get-WmiObject -Class Win32_Group

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Détails des groupes:" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($group in $groups) {
        "Nom: $($group.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Domaine: $($group.Domain)" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetProductDetails {
    
    $products = Get-WmiObject -Class Win32_Product

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Logiciels installés~" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($product in $products) {
        "Nom: $($product.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Version: $($product.Version)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Fabricant: $($product.Vendor)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Date d'installation: $($product.InstallDate)" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetVideoControllerDetails {
    
    $videoControllers = Get-WmiObject -Class Win32_VideoController

    
    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails du contrôleur vidéo~" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($controller in $videoControllers) {
        "Nom: $($controller.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Description: $($controller.DeviceID)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Fabricant: $($controller.VideoProcessor)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Résolution: $($controller.CurrentHorizontalResolution)x$($controller.CurrentVerticalResolution)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Mémoire vidéo: $($controller.AdapterRAM / 1MB) MB" | Out-File -FilePath $file_destination -Encoding default -Append
        "FPS: $($controller.CurrentRefreshRate) " | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetPrinterDetails {
    
    $printers = Get-WmiObject -Class Win32_Printer

    $printerStatusDictionary = @{
        1 = "Autre"
        2 = "Inconnu"
        3 = "Idle"
        4 = "Imprimer"
        5 = "Chauffage"
        6 = "Stop Printing"
        7 = "Offline"
        8 = "Hors papier"
        9 = "Erreur de page"
        10 = "En attente"
        11 = "Traitement"
        12 = "Initialisation"
        13 = "Power Save"
        14 = "Hors ligne"
        15 = "Hors service"
        16 = "Erreur"
        17 = "Intervention requise"
        18 = "En attente d'impression"
    }

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Détails des imprimantes:" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($printer in $printers) {
        "Nom: $($printer.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Driver: $($printer.DriverName)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Port: $($printer.PortName)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Statut: $($printerStatusDictionary[[int]$printer.PrinterStatus])" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetUSBHubDetails {
    
    $usbHubs = Get-WmiObject -Class Win32_USBHub

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Détails des hubs USB:" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($hub in $usbHubs) {
        "Nom: $($hub.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Description: $($hub.Description)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Statut: $($hub.Status)" | Out-File -FilePath $file_destination -Encoding default -Append
        "DeviceID: $($hub.DeviceID)" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

function GetTimeZoneDetails {
    
    $timeZone = Get-WmiObject -Class Win32_TimeZone

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "Timezone : $($timeZone.Description)" | Out-File -FilePath $file_destination -Encoding default -Append
}

function GetMappedLogicalDiskDetails {
    
    $mappedDisks = Get-WmiObject -Class Win32_MappedLogicalDisk

    " " | Out-File -FilePath $file_destination -Encoding default -Append
    "~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~<>~" | Out-File -FilePath $file_destination -Encoding default -Append
    "~Détails des disques logiques mappés~" | Out-File -FilePath $file_destination -Encoding default -Append

    foreach ($disk in $mappedDisks) {
        "Nom du disque: $($disk.Name)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Description: $($disk.Description)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Système de fichiers: $($disk.FileSystem)" | Out-File -FilePath $file_destination -Encoding default -Append
        "Taille totale: $($disk.Size / 1GB) GB" | Out-File -FilePath $file_destination -Encoding default -Append
        "--------------------------------------" | Out-File -FilePath $file_destination -Encoding default -Append
    }
}

# [FR] C'est ici que chaque fonction est appelée ↙
# [US] Finally, this is the part of the script where each function is called ↙

GetRAMDetails
GetOSDetails
GetComputerDetails
GetProcessorDetails
GetBIOSDetails
GetDiskPartitionDetails
GetLogicalDiskDetails
GetNetworkAdapterConfigurationDetails
GetUserAccountDetails
GetGroupDetails
GetProductDetails
GetVideoControllerDetails
GetPrinterDetails
GetUSBHubDetails
GetTimeZoneDetails
GetMappedLogicalDiskDetails