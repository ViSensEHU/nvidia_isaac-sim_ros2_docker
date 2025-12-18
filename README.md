# VNC to a server running nvidia_isaac-sim_ros2_docker

ACTIVAR SSH EN EL SERVIDOR PRIMERO PARA PODER ACCEDER AL DISCO PASE LO QUE PASE Y NO NECESITAR USB LIVE

# Configuración de x11vnc con Xorg Dummy en Ubuntu

## 1. Instalar paquetes necesarios
```bash
sudo apt update
sudo apt install x11vnc xserver-xorg-video-dummy
```
## 2. Crear configuración de Xorg dummy
```bash 
sudo nano /etc/X11/xorg.conf.d/10-headless.conf
```
Contenido del fichero de configuración:
```
Section "Device"
    Identifier  "Configured Video Device"
    Driver      "dummy"
    VideoRam    256000
EndSection

Section "Monitor"
    Identifier  "Configured Monitor"
    HorizSync   5.0 - 1000.0
    VertRefresh 5.0 - 200.0
    ModeLine "1920x1080" 148.50 1920 2448 2492 2640 1080 1084 1089 1125 +Hsync +Vsync
EndSection

Section "Screen"
    Identifier  "Default Screen"
    Monitor     "Configured Monitor"
    Device      "Configured Video Device"
    DefaultDepth 24
    SubSection "Display"
        Depth 24
        Modes "1920x1080" "1440x900" "1280x800" "1024x768"
    EndSubSection
EndSection
```

## 3. Configurar contraseña para VNC
```bash
mkdir -p ~/.vnc
x11vnc -storepasswd
```
Esto generará el archivo ``~/.vnc/passwd``.


## 4. Crear servicio systemd para x11vnc
```bash
sudo nano /etc/systemd/system/x11vnc.service
```
Contenido del servicio:
```
[Unit]
Description=Start x11vnc at startup
After=multi-user.target

[Service]
Type=simple
User=isaac_sim_1
Environment=DISPLAY=:0
ExecStart=/usr/bin/x11vnc -display :0 -forever -loop -noxdamage -repeat \
  -rfbauth /home/isaac_sim_1/.vnc/passwd -rfbport 5900 -shared
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

## 5. Recargar systemd y habilitar servicio
```bash
sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service
```

## 6. Verificar estado
```bash
sudo systemctl status x11vnc.service
``` 
Si necesitas comprobar qué display está activo:
```bash
echo $DISPLAY
ps aux | grep Xorg
```

## 7. (Opcional) Reiniciar Xorg dummy manualmente
En caso de problemas:
```bash
sudo pkill Xorg 2>/dev/null || true
DISPLAY=:0 startx -- -config /etc/X11/xorg.conf.d/10-headless.conf &
sudo systemctl restart x11vnc.service
```

Control Alt F3 entramos en tty del servidor con el monitor físico conectado,
borramos el ficheros de configuración dle dummy (comentamos) y reiniciamos y 
ya funciona en el monitor.
```bash 
sudo nano /etc/X11/xorg.conf.d/10-headless.conf
```
```bash
sudo systemctl restart gdm 
```