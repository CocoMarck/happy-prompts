**Correcto.** Tienes razón.

La **RX 6400** (Navi 24) **no tiene encoder de hardware** (VCN solo decode). No puede usar AMF ni VAAPI para codificar. Todo el encoding lo tiene que hacer el **CPU** con **x264**.

### Evaluación del hardware
- CPU: Ryzen 5 3500X (6 núcleos / 6 hilos) → **aceptable** para 1344×756 @ 15 FPS, pero no sobrado.
- Al ser solo software encoding, el uso de CPU será notablemente más alto que con un encoder por hardware.
- Con 15 FPS y resolución baja, sigue siendo viable y estable si configuras bien.

### Configuración común (igual que antes)

**Settings → Video**
- Base (Canvas): `1920x1080`
- Output (Scaled): `1344x756`
- Downscale Filter: **Lanczos** (o Bicubic si quieres menos carga de CPU)
- FPS: **15**

**Settings → Output** → **Output Mode: Advanced**

---

## Streaming (x264)

Encoder: **x264**  
Rate Control: **CBR**  
Keyframe Interval: **2**  
Profile: **High**  
Tune: **(none)** o **zerolatency** (solo si notas mucha latencia)

### 1. Intermedia (estable + buena calidad) — Recomendada
- CPU Usage Preset: **veryfast**
- Bitrate: **2500–3000 kbps**
- x264 Options (opcional): `bframes=2 ref=3`

### 2. Máxima calidad
- CPU Usage Preset: **faster** o **medium** (prueba primero faster)
- Bitrate: **3500–4500 kbps**
- x264 Options: `bframes=3 ref=4`

### 3. Prioridad a no trabarse (máxima estabilidad)
- CPU Usage Preset: **superfast** o **ultrafast**
- Bitrate: **1800–2200 kbps**
- x264 Options: `bframes=0` o `bframes=1`

---

## Grabación local (x264)

Formato: **MKV**

### 1. Equilibrada
- Encoder: x264
- Rate Control: **CRF**
- CRF: **20–22**
- CPU Usage Preset: **veryfast**
- Keyframe Interval: **2**

### 2. Prioridad bajo uso de PC
- Rate Control: **CRF**
- CRF: **23–25**
- CPU Usage Preset: **superfast** o **ultrafast**
- Keyframe Interval: **2**

### 3. Prioridad calidad
- Rate Control: **CRF**
- CRF: **18–19**
- CPU Usage Preset: **faster** o **medium**
- Keyframe Interval: **2**

---

### Consejos importantes con tu CPU

1. **Monitoriza siempre** View → Stats. Si ves *Encoding lag* o frames skipped, baja el preset (de veryfast → superfast) o el bitrate.
2. Cierra todo lo que no uses mientras streameas/grabas.
3. En KDE Plasma (Wayland) usa captura **PipeWire**.
4. Con 15 FPS y 1344×756 el 3500X debería aguantar **veryfast** sin problemas en la mayoría de juegos/contenido liviano.
5. Si el juego es muy pesado en CPU, usa la configuración 3 (superfast/ultrafast).

¿Quieres que te dé también los valores exactos de **x264 Options** más optimizados para tu caso, o prefieres una configuración lista según la plataforma que más uses (Twitch, YouTube, Rumble, etc.)?