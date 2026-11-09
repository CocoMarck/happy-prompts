# Obtener configuraciones para OBS

Hola, necesito recomendaciones de configuración para **OBS Studio** basadas en este hardware y OS:

### Internet
- Subida: `86.97 Mbps`
- Bajada: `88.99 Mbps`

### HW Info
- Receptor de internet: Ethernet

Fastfetch command:
```bash
fastfetch -s os:kernel:de:wm:cpu:gpu:memory:disk:display --logo none
```

Fastfetch Output:
```
OS: Debian GNU/Linux 13 (trixie) x86_64
Kernel: Linux 6.12.113+deb13-amd64
DE: KDE Plasma 6.3.6
WM: KWin (Wayland)
CPU: AMD Ryzen 5 3500X (6) @ 4.12 GHz
GPU: AMD Radeon RX 6400 [Discrete]
Memory: 6.08 GiB / 15.55 GiB (39%)
Disk (/): 214.89 GiB / 271.53 GiB (79%) - ext4
Disk (/media/public/500gb-games-ext4): 306.48 GiB / 445.68 GiB (69%) - ext4
Disk (/media/public/500gb-games-ntfs): 248.23 GiB / 500.00 GiB (50%) - ntfs3
Disk (/media/public/SSD-256): 186.60 GiB / 238.46 GiB (78%) - exfat
Display (MSI MP223): 1920x1080 @ 100 Hz in 21" [External]
```

### Por favor ayúdame a configurar OBS
#### Solicitud
- Recomendación para configuraciones de streaming.
- Recomendación para configuraciones de video local.

#### Objetivo del video/stream
- Resolución de salida: `1344x756`
- FPS: `15 FPS`
- Audio: Sin especificar. Por defecto esta bien.
- Contenido para: Rumble, Youtube, Twitch, Facebook, Peertube

#### Configuraciones
- Tipo de stream: Unilateral.

**Para Streaming**
1. Configuración para imagen estable, y sin que se trabe el streaming. Punto intermedio entre configuraciones dos y tres.
2. Configuración en prioridad de imagen estable, sin perdida de calidad, máxima calidad sin importar compresión.
3. Configuración en prioridad de streaming sin trabarse.

**Para grabación de video local**
1. Equilibrada -> calidad de imagen aceptable, no mucho uso de PC, no mucho peso de video.
2. Prioridad a bajo uso de PC -> Calidad de imagen aceptable. Sacrificando espacio.
3. Prioridad calidad -> Sacrificando poder, pero no peso, ese debe ser aceptable.

#### Detalles
- Si crees que el PC es low-spec o hight-spec para el objetivo del video/stream, mencionado de manera breve. Y recomienda un objetivo equilibrado entre calidad, y rendimiento, también de manera breve.
- Cuando digo "trabarse" me refiero a cortes o freezes en el stream (encoding lag o network drops)
- Menciona lo relacionado a plataformas especificas al final.
