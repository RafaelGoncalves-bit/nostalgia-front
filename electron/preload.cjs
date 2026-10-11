const {contextBridge,ipcRenderer}=require('electron');
const invoke=(name,payload)=>ipcRenderer.invoke(name,payload);
contextBridge.exposeInMainWorld('gameserver',Object.freeze({
  settings:()=>invoke('settings:get'), saveSettings:(v)=>invoke('settings:save',v),
  games:()=>invoke('games:list'), status:()=>invoke('system:status'),
  play:(id)=>invoke('game:play',id), importBios:()=>invoke('bios:import'),
  choosePcsx2:()=>invoke('binary:pcsx2'), chooseRclone:()=>invoke('binary:rclone'),
  openData:()=>invoke('data:open'),
  onStatus:(fn)=>{const listener=(_e,v)=>fn(v);ipcRenderer.on('operation:status',listener);return ()=>ipcRenderer.removeListener('operation:status',listener)}
}));
