# Game Server PS2 Desktop v1.2 — WinFsp integrado

## Gerar Setup.exe

1. Coloque PCSX2 portatil completo em `vendor/pcsx2/` e `rclone.exe` em `vendor/rclone/`.
2. No Windows, execute `npm install` e `npm run dist:win`.
3. O script baixa **no computador de build** o MSI oficial do WinFsp e valida sua assinatura digital. Caso falhe, baixe manualmente o MSI oficial de https://winfsp.dev/rel/ para `build/winfsp.msi` e execute novamente.
4. O instalador NSIS gerado em `release/` inclui os executaveis portateis e instala WinFsp com elevacao UAC, sem exigir que o usuario baixe WinFsp manualmente.

O PCSX2 e rclone sao empacotados apenas se colocados em `vendor`. A versao nao inclui binarios proprietarios, ISOs ou BIOS.

## BIOS

Ainda nao foi fornecida. O app mantem a opcao para importar a BIOS do proprio PS2; para considerar distribuicao de uma BIOS no Setup, verifique previamente autorizacao legal para redistribuicao.

## Verificacao

`npm run check` valida a sintaxe do Electron. O comportamento do NSIS/WinFsp requer teste em Windows, de preferencia numa maquina limpa ou VM.
