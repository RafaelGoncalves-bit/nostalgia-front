# Game Server PS2 — Perfil de desempenho 1.4

## Instalação e execução

1. Inclua o PCSX2 completo em `vendor/pcsx2` e o rclone em `vendor/rclone`.
2. WinFsp continua em `build/winfsp.msi` (preparado por `scripts/prepare-winfsp.ps1`).
3. Execute `npm install` e `npm run dist:win` no Windows.
4. No primeiro uso, importe sua própria BIOS pelo menu Configurações. **O pacote não contém BIOS proprietária.**

## Perfil inicial

O aplicativo usa `-datapath` para manter os dados do PCSX2 dentro do diretório do usuário do Game Server (fora de Program Files). Cria apenas na primeira inicialização `inis/PCSX2.ini`, com `EmuCore/GS`: `UpscaleMultiplier = 1`, `Renderer = -1` (seleção automática de renderizador), `FXAA = false`, `ShadeBoost = false`. **Não sobrescreve configurações posteriormente alteradas pelo usuário**.

Configurações de primeira execução podem variar conforme a versão do PCSX2. Confira em Configurações > Gráficos que a resolução interna está em 1x e a GPU de hardware foi selecionada. Se necessário, teste Vulkan e Direct3D11 na RX 550. Não usar hacks agressivos nem limitar a 30 FPS como padrão; a velocidade de emulação deve permanecer em 100%.

## BIOS e direitos

O aplicativo importa os arquivos da BIOS para `pcsx2-data/bios` no diretório de dados do usuário. A BIOS do PS2 é software proprietário: o instalador público não inclui as BIOS enviadas. O jogador deve importar uma BIOS obtida legalmente de seu console e confirmar a seleção no PCSX2. Não inclui ROMs, ISOs nem jogos.

## Observações

O perfil foi criado para a primeira execução e não foi testado no PCSX2 executando em Windows neste ambiente. A melhoria de desempenho depende do jogo, CPU e GPU, não é garantida. Se já existir configuração anterior do PCSX2, ela é preservada.
