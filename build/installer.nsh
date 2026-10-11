!macro customInstall
  ; installer MSI bundled at build time; never fetch/exe arbitrary URL on client.
  File "/oname=$PLUGINSDIR\winfsp.msi" "${BUILD_RESOURCES_DIR}\winfsp.msi"
  DetailPrint "Instalando WinFsp..."
  ExecWait '"$SYSDIR\msiexec.exe" /i "$PLUGINSDIR\winfsp.msi" /qn /norestart' $0
  IntCmp $0 0 winfsp_ready
  IntCmp $0 3010 winfsp_reboot
  MessageBox MB_ICONSTOP "Falha ao instalar WinFsp (codigo $0). Instale manualmente e tente novamente."
  Abort
winfsp_reboot:
  DetailPrint "WinFsp instalado; reinicio do Windows pode ser necessario."
winfsp_ready:
!macroend
