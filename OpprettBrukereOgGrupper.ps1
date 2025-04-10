
# Opprett grupper i AD under OU=Jovian
$groups = @("Europa", "Callisto", "Metis", "Adrasten")
 
foreach ($group in $groups) {
    try {
        # Sjekk om gruppen allerede eksisterer i AD
        $existingGroup = Get-ADGroup -Filter {Name -eq $group} -ErrorAction SilentlyContinue
        if (-Not $existingGroup) {
            # Opprett gruppe i riktig OU
            New-ADGroup -Name $group -GroupScope Global -GroupCategory Security -Path "OU=Jovian,DC=jovian,DC=lokal" -Description "$group Group"
            Write-Output "Gruppe '$group' opprettet i OU=Jovian."
        } else {
            Write-Output "Gruppe '$group' eksisterer allerede."
        }
    } catch {
        Write-Output "Feil ved opprettelse av gruppe '$group': $_"
    }
}
 
# Legg til brukere fra CSV
$csvFile = "C:\Users\Administrator\Documents\Ansatte\brukere.csv"
if (Test-Path $csvFile) {
    $users = Import-Csv -Path $csvFile -Delimiter ','  # Bruker riktig skilletegn
 
    foreach ($user in $users) {
        $username = $user.Brukernavn
        $groups = $user.Avdeling -split '/'  # Håndter flere grupper
 
        # Feilsøk: Skriv ut brukernavnet og avdelingen
        Write-Output "Behandler bruker: $username, gruppe(r): $($user.Avdeling)"
        if (-Not $username) {
            Write-Output "Feil: Brukernavn er tomt i CSV-filen."
            continue
        }
 
        try {
            # Sjekk om brukeren allerede eksisterer
            $existingUser = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue
            if (-Not $existingUser) {
                # Opprett bruker i AD med passord "Admin:123"
                New-ADUser -SamAccountName $username -UserPrincipalName "$username@jovian.lokal" `
                    -Name $username -GivenName $username -Surname "Lastname" `
                    -Path "OU=Jovian,DC=jovian,DC=lokal" `
                    -AccountPassword (ConvertTo-SecureString "Admin:123" -AsPlainText -Force) `
                    -Enabled $true
                Write-Output "Bruker '$username' opprettet i AD."
            } else {
                Write-Output "Bruker '$username' eksisterer allerede."
            }
 
            # Legg brukeren til i alle spesifiserte grupper
            foreach ($group in $groups) {
                if (Get-ADGroup -Filter {Name -eq $group}) {
                    Add-ADGroupMember -Identity $group -Members $username
                    Write-Output "Bruker '$username' lagt til i gruppe '$group'."
                } else {
                    Write-Output "Feil: Gruppe '$group' finnes ikke i AD. Sjekk om den ble opprettet riktig."
                }
            }
        } catch {
            Write-Output "Feil ved behandling av bruker '$username': $_"
        }
    }
} else {
    Write-Output "CSV-filen '$csvFile' ble ikke funnet."
}
