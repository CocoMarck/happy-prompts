# Configuración de OBS para tu equipo

## Evaluación del hardware

Para **1440x810 a 15 FPS**, tu PC es **más que suficiente**. Ese objetivo equivale a un ~28% de la carga de 1080p30, así que el Ryzen 5 3500X lo maneja bien. Tu internet (86 Mbps de subida por Ethernet) también sobra.

**Detalle importante:** la **RX 6400 no tiene encoder por hardware** (ni H.264, ni HEVC, ni AV1). Todo el video se codifica por CPU con **x264**. No uses AMF ni VAAPI, no hay nada que usar.

**Objetivo equilibrado recomendado:** mantén 1440x810 a 15 FPS si ese es tu estilo. Si en algún momento quieres más fluidez, 1440x810 a **30 FPS** con preset `veryfast` también es viable. Hoy tu objetivo está muy holgado.

---

## Ajustes comunes (stream y grabación)

**Ajustes → Video**
| Opción | Valor |
|---|---|
| Resolución base | 1920x1080 |
| Resolución de salida | 1440x810 |
| Filtro de escala | Lanczos (o Bicúbico si quieres menos CPU) |
| FPS | 15 |

**Ajustes → Audio:** 48 kHz, estéreo. Los valores por defecto están bien.

**Captura en Wayland:** usa **"Captura de pantalla (PipeWire)"** o captura de ventana por PipeWire. No existe "Game Capture" en Linux.

**Ajustes → Salida (modo Avanzado):** usa siempre el modo **Avanzado**, no el Simple.

---

## Streaming

Para todos los casos: **Encoder x264**, **Control de tasa CBR**, **Intervalo de keyframes 2 s**, **Perfil High**, audio **AAC 160 kbps**.

| | **1. Equilibrada** | **2. Máxima calidad** | **3. Prioridad sin trabas** |
|---|---|---|---|
| Bitrate de video | 4000 kbps | 6000 kbps | 2500 kbps |
| Preset de CPU | `faster` | `medium` | `veryfast` |
| Tune | (ninguno) | (ninguno) | `zerolatency` |
| Bitrate dinámico (Red) | No | No | **Sí** |

**Notas:**
- Al ser transmisión unilateral, la latencia no importa. Puedes dejar el buffer de red por defecto.
- Si en la opción 2 notas "encoding overloaded" mientras juegas, baja a `fast`.
- En la opción 3, "bitrate dinámico" reduce el bitrate si la red se satura, en lugar de cortarse.
- A 15 FPS estos bitrates son bastante generosos. 4000 kbps a 15 FPS se ve parecido a ~8000 kbps a 30 FPS.

---

## Grabación local

Formato: **MKV** (más seguro ante cierres inesperados). Luego puedes remuxar a MP4 desde *Archivo → Remux de grabaciones*. Encoder **x264**, **Control de tasa CRF**, **keyframes 2 s**, perfil High, audio AAC 160 kbps.

| | **1. Equilibrada** | **2. Bajo uso de PC** | **3. Máxima calidad** |
|---|---|---|---|
| CRF | 23 | 22 | 18 |
| Preset de CPU | `veryfast` | `ultrafast` | `slow` (o `medium` si el juego es pesado) |
| Peso aproximado | ~1 GB/hora | ~2-3 GB/hora | ~2-3 GB/hora |

**Notas:**
- Los pesos son estimaciones y varían con el contenido.
- Para grabar usa el disco **ext4** (`500gb-games-ext4`, ~139 GB libres). Evita el disco raíz (79% lleno) y los discos exFAT/NTFS, que son menos fiables para escrituras continuas.

---

## Notas por plataforma

- **Twitch:** exige CBR y keyframe de 2 s. El tope práctico es **6000 kbps** (cuentas sin Partner), así que la config 2 está justo en el límite. Acepta 15 FPS.
- **YouTube:** acepta bitrates altos y keyframe de hasta 4 s (2 s es lo ideal). Recomienda 30+ FPS, así que con 15 FPS puede mostrar avisos de "calidad de stream" o transcodificar peor.
- **Facebook:** exige keyframe de **2 s como máximo**, H.264 + AAC, y su límite ronda los **8 Mbps**. Su soporte de FPS bajos puede ser irregular. Compruébalo con una prueba corta.
- **Rumble:** transmite por RTMP. Revisa sus bitrates recomendados en su panel de stream, ya que pueden cambiar.
- **PeerTube:** depende del administrador de **cada instancia** (límites de bitrate, transcodificación y si tiene el streaming en vivo habilitado). Con 2500-4000 kbps tendrás menos problemas.

**Si transmites a varias plataformas a la vez:** usa el plugin **obs-multi-rtmp** para codificar una sola vez y enviar a todas. El bitrate se multiplica por destino. Con 5 plataformas a 6000 kbps serían 30 Mbps, aún cómodo con tus 86 Mbps. Aun así, usa el bitrate del límite más bajo de todas las plataformas.

Te recomiendo hacer una transmisión de prueba privada o no listada en cada plataforma antes de salir en vivo, porque sus requisitos cambian con frecuencia.