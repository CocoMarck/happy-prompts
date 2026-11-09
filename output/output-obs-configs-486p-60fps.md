Tu PC es **mid-spec para tu objetivo.** Para `864x486 @ 60fps` vas sobrado, incluso con x264 por CPU. El cuello de botella es que tu RX 6400 no tiene encoder de hardware en Linux, entonces todo recae en el Ryzen 5 3500X. Ese CPU sí puede con 486p60 sin problemas.

Objetivo equilibrado que te recomiendo: Mantén tu `864x486 60fps`. Es perfecto para Rumble y tu CPU. No subas a 1080p60 con x264 porque ahí sí vas a sufrir freezes. Si quieres subir un poco, tu tope equilibrado sería `1280x720 60fps` con preset `veryfast`.

### Configuración Base en OBS (para todo)

Haz esto antes de aplicar los perfiles de abajo:

**Video >:**
- Resolución Base: `1920x1080`
- Resolución de Salida: `864x486`
- Filtro de Escalado: `Lanczos 36 muestras`
- FPS: `60`

**Salida > Audio:**
- Bitrate: `160`, Sample Rate 48kHz, Canales Estereo

**Avanzado:**
- Estás en Wayland + KDE: Usa fuente `Screen Capture (PipeWire)` no Display Capture. Te pedirá permiso la primera vez.
- Proceso de OBS en prioridad alta: `nice -n -10 obs` desde terminal

**Salida > Encoder:** Siempre `x264`. No selecciones AMF / VAAPI / QSV, tu GPU no tiene encoding real en OBS Linux.

---

### Para STREAMING a Rumble - Unilateral

Tu subida de 88 Mbps es excelente. Rumble recomienda CBR. Todos con `Keyframe 2s`.

#### 1. Equilibrada - La que deberías usar
Punto medio entre calidad y que no se trabe.

- Rate Control: `CBR`
- Bitrate: `3500 Kbps`
- Preset CPU: `faster`
- Profile: `high`
- Tune: `zerolatency` (vacío si vas a jugar algo con mucho movimiento, déjalo en none)
- x264 Options: `bframes=2`
- Keyframe: `2s`

> CPU ~35-50%. No se traba y se ve nítido en 486p.

#### 2. Prioridad Calidad de Imagen Estable - Máxima calidad
Para charlas, just chatting, sin juego pesado.

- Rate Control: `CBR`
- Bitrate: `5000 Kbps` - Rumble aguanta hasta 8000, con tu internet no hay problema
- Preset CPU: `medium` - si ves `encoding lag` en stats, bájalo a `fast`
- Profile: `high`
- Keyframe: `2s`
- Activa: `Psycho-visual Tuning`

> Se verá casi sin compresión para 486p. Uso de CPU 60-80%. Si juegas algo demandante, va a empezar a dropear frames de encoding.

#### 3. Prioridad Que No Se Trabe Nunca
Para juegos pesados donde no quieres ni un freeze.

- Rate Control: `CBR`
- Bitrate: `2800 Kbps`
- Preset CPU: `veryfast` o `superfast` si sigue trabándose
- Profile: `high`
- Keyframe: `2s`
- Filtro de Escalado: Cambia a `Bilinear` - menos carga CPU

> CPU ~20-35%. Pierdes un poco de nitidez en movimiento, pero 0 freezes garantizados.

### Para GRABACIÓN LOCAL

Aquí usamos CRF/VBR para no generar archivos gigantes.

#### 1. Equilibrada - Calidad aceptable / Poco peso / Poco uso PC
- Tipo: `Grabación Estándar`
- Encoder: `x264`
- Rate Control: `CRF`
- CRF: `23`
- Preset CPU: `veryfast`
- Profile: `high`
- Formato: `mkv` y luego remux a mp4 en OBS. Nunca grabes directo a mp4, si se crashea pierdes archivo.

Peso: ~1.2GB por hora en 486p60.

#### 2. Prioridad Bajo Uso de PC - Sacrifica espacio
Para grabar mientras juegas sin perder FPS.

- Encoder: `x264`
- Rate Control: `CQP` o `CRF` con CRF bajo
- CQP: `20` / CRF `20`
- Preset CPU: `ultrafast` o `superfast`
- Profile: `high`

Peso: ~2.5-3.5GB por hora. Pero CPU <15%.

#### 3. Prioridad Calidad - Sin sacrificar mucho peso
Para archivo final que vas a resubir.

- Encoder: `x264`
- Rate Control: `CRF`
- CRF: `18`
- Preset CPU: `slow` - si te da lag, bájalo a `medium`
- Profile: `high`
- x264 Options: `bframes=4 b-adapt=2`

Peso: ~1.8GB por hora pero calidad mucho mayor que la equilibrada. No es tan pesado como CQP.

### Notas finales para tu setup Debian + Rumble

1.  **Wayland:** En `Ajustes > Avanzado` deja Color Format en `NV12` y Color Space `709`. Si el color se ve lavado, cambia a `sRGB`.
2.  **Rumble:** Es unilateral, usa RTMPS. Servidor: `rtmps://rumble.com` o el que te de tu panel. Usa CBR y keyframe 2s obligatorio, si no Rumble te baja la calidad. Bitrate máximo recomendado por ellos es 8000, pero para 864x486 no necesitas pasar de 5000.
3.  **Si ves Encoding Lag:** Abre `Ver > Estadísticas`. Si sube, baja el preset un escalón. No bajes el bitrate, baja el preset.

¿Quieres que te pase un perfil ya exportado de OBS con la opción 1 para que solo lo importes?