# Game Server PS2 — Desktop (Electron + React)

Aplicativo nativo para Windows. Navegador integrado pelo Electron, biblioteca React, PCSX2 nativo para emulação, rclone + WinFsp para montar ISOs do servidor como `P:` sem salvar a ISO integralmente.

## Desenvolvimento

```powershell
npm install
npm run dev
```

## Distribuir `.exe` com PCSX2 + rclone incluídos

1. Baixe PCSX2 portátil oficial e extraia a distribuição COMPLETA em `vendor/pcsx2/` (deve existir `vendor/pcsx2/pcsx2-qt.exe`).
2. Coloque `rclone.exe` oficial em `vendor/rclone/rclone.exe`.
3. Consulte licenças dos softwares redistribuídos, inclua avisos apropriados.
4. Instale o **WinFsp** no computador cliente; ele é necessário para a unidade `P:`. A implementação atual detecta problemas na montagem mas **não instala WinFsp automaticamente**.
5. `npm install` e `npm run dist:win` em Windows. O instalador NSIS será salvo em `release/`.

Não é necessário Inno Setup: `electron-builder` baixa as ferramentas necessárias no computador de compilação. Para automatizar builds sem configurar ambiente local, use o workflow de GitHub Actions incluído (ao publicar o repositório no GitHub); o workflow gera um artefato EXE.

## Primeira execução

1. Informe URLs do backend e WebDAV (`http://IP:8080`, `http://IP:8081/` para LAN/VPN).
2. Informe usuário e senha WebDAV; salve.
3. Importe a BIOS obtida do **seu próprio PS2** e faça a seleção da BIOS no PCSX2 quando ele solicitar.
4. Clique em **Jogar**. O app monta a unidade configurada e abre `PCSX2.exe` com a ISO.

**Não incluímos BIOS**, nem jogos/ISOs. O WinFsp continua sendo um pré-requisito instalado separadamente. O empacotamento é configurado mas ainda não foi executado/testado em Windows nesta entrega.

## Segurança e limites

- Somente IPC explicitamente exposto via preload. Node está desabilitado no renderer.
- Senha armazenada com `safeStorage` do Electron quando disponível; não versionar arquivos de configuração.
- HTTP Basic sem TLS não é seguro para redes públicas; use HTTPS ou VPN.
- `--vfs-cache-mode off` reduz cache em disco; dependendo do jogo e rede, pode ter engasgos.
- O PCSX2 abre em janela nativa própria, não na janela Electron.

## Versão 1.1 — fluxo simplificado

- Corrigida a inicialização do PCSX2 para `-fullscreen` (um hífen).
- Montagem automática da unidade de rede quando o app abre (habilitada por padrão depois que usuário salvar configurações).
- Montagem read-only em `--network-mode` para reduzir problemas com o Explorador de Arquivos.
- Instalador NSIS em modo de um clique, com atalho e inicialização ao final.
- A ISO **não** é baixada integralmente.

### Pré-requisitos do instalador

Copie os arquivos oficiais de PCSX2 portátil e rclone para `vendor/pcsx2` e `vendor/rclone`, respectivamente, antes de compilar. **WinFsp ainda precisa ser instalado** no PC cliente; confira https://winfsp.dev/rel/. Não distribua BIOS de PS2.

Rode `npm install`, `npm run check`, `npm run dist:win` no Windows. O resultado fica em `release/`.

### Limites atuais

Não inclui atualizações automáticas: exigem feed de atualização confiável, publicação de versões e idealmente assinatura de código. Para evitar interromper jogos, não feche o aplicativo enquanto o PCSX2 estiver usando a unidade P:.
