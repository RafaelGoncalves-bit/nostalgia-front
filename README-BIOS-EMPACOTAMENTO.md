# BIOS no instalador — Game Server PS2 v1.5

1. Coloque os arquivos de BIOS que você tem autorização para redistribuir em `vendor/pcsx2/bios/` (extraídos de ZIP/RAR). Exemplos de extensões: `.bin`, `.nvm`, `.mec`, `.rom1`, `.rom2`, `.erom`.
2. Mantenha a distribuição portátil **completa** do PCSX2 em `vendor/pcsx2/` e `rclone.exe` em `vendor/rclone/`. Mantenha WinFsp em `build/`, como na versão anterior.
3. Execute `npm install` e `npm run dist:win` no Windows. O instalador será colocado em `release/`.
4. Na primeira execução, o aplicativo copia os arquivos de `resources/vendor/pcsx2/bios/` para o diretório `pcsx2-data/bios/` dentro dos dados do usuário Electron. Esse é o mesmo diretório de dados enviado ao PCSX2 pelo argumento `-datapath`.
5. BIOS já existentes no destino **não são sobrescritas**. O PCSX2 pode solicitar a seleção de uma BIOS válida nas próprias configurações se ainda não houver preferência definida.

**Atenção:** não basta que um arquivo seja uma BIOS oficial para que sua distribuição seja autorizada; confira os direitos/licenças aplicáveis. Este ZIP não inclui BIOS nem jogos.

**Teste recomendado:** instalar em um usuário Windows novo, abrir o PCSX2 e confirmar em Configurações > BIOS que a BIOS foi reconhecida. A cópia automática foi implementada, mas esse teste de integração ainda precisa ser realizado no Windows.
