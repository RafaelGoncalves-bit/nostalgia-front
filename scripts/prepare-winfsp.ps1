$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$target = Join-Path $root 'build\winfsp.msi'
if (Test-Path $target) {
  Write-Host 'Usando WinFsp MSI existente em build/winfsp.msi'
  exit 0
}
# Only official upstream release metadata; download is a BUILD operation, not a client operation.
$api = 'https://api.github.com/repos/winfsp/winfsp/releases/latest'
Write-Host 'Consultando versao oficial do WinFsp...'
$release = Invoke-RestMethod -Uri $api -Headers @{ 'User-Agent'='GameServerPS2-Build' }
$assets = @($release.assets | Where-Object { $_.name -match '(?i)^winfsp.*\.msi$' })
if ($assets.Count -ne 1) { throw 'Nao foi possivel identificar um unico MSI WinFsp oficial. Baixe manualmente de https://winfsp.dev/rel/ e salve em build/winfsp.msi' }
$url = $assets[0].browser_download_url
if ($url -notmatch '^https://github\.com/winfsp/winfsp/releases/download/') { throw 'Origem inesperada para WinFsp MSI.' }
Write-Host "Baixando $($assets[0].name) ($($release.tag_name))..."
Invoke-WebRequest -Uri $url -OutFile $target
if ((Get-Item $target).Length -lt 100000) { Remove-Item $target; throw 'Arquivo WinFsp MSI incompleto.' }
$signature=Get-AuthenticodeSignature -FilePath $target
if ($signature.Status -ne 'Valid') { Remove-Item $target; throw "Assinatura digital WinFsp invalida: $($signature.Status). Baixe do site oficial." }
Write-Host 'WinFsp pronto para incluir no instalador.'
