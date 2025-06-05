param (
    [string]$RootCAPath
)

if (-not $RootCAPath) {
    Write-Host "Usage: .	rust_root_ca_windows.ps1 -RootCAPath <path_to_rootCA.pem>"
    exit
}

# Import the root CA certificate into the Trusted Root Certification Authorities store
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import($RootCAPath)
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")
$store.Open("MaxAllowed")
$store.Add($cert)
$store.Close()

Write-Host "Root CA certificate has been trusted on this machine."
