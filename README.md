# polybar-ps4-battery-module
![Polybar-Ps4](.example.png)
### Dependencias
+ upower (Para ver el estado de bateria del dispositivo)
### Instalación
1. Descargar ps4_battery.sh y guardar en ".config/polybar/"
2. Darle permisos de ejecución "chmod +x .config/polybar/ps4_battery.sh"
3. Agregar modulo en ".config/polybar/config.ini"

[module/ps4-battery]  
type = custom/script  
exec = ~/.config/polybar/ps4_battery.sh  
interval = 1  
label = "%output%"  
label-background = #222330 
format = <label>
