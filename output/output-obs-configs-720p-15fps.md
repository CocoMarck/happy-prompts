Tu PC es **high-spec para este objetivo.** `720p @ 15 FPS` es extremadamente ligero, incluso con x264 por CPU. Tu cuello sigue siendo que la RX 6400 no tiene encoder de hardware usable en OBS Linux, así que todo lo hace el Ryzen 5 3500X, pero a 15 FPS ni se va a enterar.

Objetivo equilibrado que te recomiendo: Mantén tu `720p 15 FPS` si es para algo estático como charla / podcast / gameplay lento. Si hay movimiento, sube a `720p 30 FPS` sin cambiar nada más, tu PC lo aguanta sobrado y se verá mucho más fluido. No necesitas subir a 1080p.

### Configuración Base en OBS (para todo)

**Video >:**
- Resolución Base: `1920x1080`
- Resolución de Salida: `1280x720`
- Filtro de Escalado: `Lanczos 36 muestras`
- FPS: `15`

**Salida > Audio:**
- Bitrate: `160`, Sample Rate 48kHz, Canales Estereo

**Avanzado:**
- Estás en Wayland + KDE: Usa fuente `Screen Capture (PipeWire)` no Display Capture.
- Proceso de OBS en prioridad alta: `nice -n -10 obs` desde terminal

**Salida > Encoder:** Siempre `x264`. No selecciones AMF / VAAPI, tu GPU no tiene encoding real en OBS Linux.

---

### Para STREAMING a Rumble - Unilateral

Tu subida de 76.52 Mbps sobra. Rumble quiere CBR. Todos con `Keyframe 2s`. Como son solo 15 FPS, los bitrates son mucho más bajos que un 60 FPS.

#### 1. Equilibrada - La que deberías usar
Punto medio entre calidad y que no se trabe.

- Rate Control: `CBR`
- Bitrate: `2200 Kbps`
- Preset CPU: `fast`
- Profile: `high`
- Tune: `zerolatency`
- x264 Options: `bframes=2`
- Keyframe: `2s`

> CPU ~15-25%. Imagen muy estable, sin freezes.

#### 2. Prioridad Calidad de Imagen Estable - Máxima calidad
Sin pérdida visible, sin importar compresión.

- Rate Control: `CBR`
- Bitrate: `3500 Kbps`
- Preset CPU: `medium` - si ves `encoding lag` en stats, bájalo a `fast`
- Profile: `high`
- Keyframe: `2s`
- Activa: `Psycho-visual Tuning`

> A 15 FPS, 3500 Kbps es casi lossless para 720p. Uso de CPU 30-45%. No se traba a menos que juegues algo muy pesado al mismo tiempo.

#### 3. Prioridad Que No Se Trabe Nunca
Para que nunca haya cortes, aunque juegues algo pesado.

- Rate Control: `CBR`
- Bitrate: `1600 Kbps`
- Preset CPU: `veryfast`
- Profile: `high`
- Keyframe: `2s`
- Filtro de Escalado: Cambia a `Bilinear`

> CPU ~8-15%. A 15 FPS casi no vas a notar la pérdida de calidad, pero garantizas 0 freezes.

### Para GRABACIÓN LOCAL

Aquí usamos CRF para no generar archivos gigantes.

#### 1. Equilibrada - Calidad aceptable / Poco peso / Poco uso PC
- Encoder: `x264`
- Rate Control: `CRF`
- CRF: `23`
- Preset CPU: `veryfast`
- Profile: `high`
- Formato: `mkv` y luego remux a mp4 en OBS. Nunca grabes directo a mp4.

Peso: ~700 MB - 900 MB por hora en 720p15.

#### 2. Prioridad Bajo Uso de PC - Sacrifica espacio
Para grabar mientras juegas sin perder FPS.

- Encoder: `x264`
- Rate Control: `CQP`
- CQP: `20`
- Preset CPU: `ultrafast`
- Profile: `high`

Peso: ~1.5 - 2 GB por hora. Pero CPU <10%.

#### 3. Prioridad Calidad - Sacrifica poder, pero no peso
Para archivo final que vas a resubir.

- Encoder: `x264`
- Rate Control: `CRF`
- CRF: `18`
- Preset CPU: `medium` - si te da lag, bájalo a `fast`
- Profile: `high`
- x264 Options: `bframes=4 b-adapt=2`

Peso: ~1.1 - 1.4 GB por hora pero calidad mucho mayor que la equilibrada. A 15 FPS el preset `medium` es muy manejable.

### Notas finales para tu setup Debian + Rumble

1.  **Wayland:** En `Ajustes > Avanzado` deja Color Format en `NV12` y Color Space `709`. Si el color se ve lavado, cambia a `sRGB`.
2.  **Rumble:** Es unilateral, usa RTMPS. Servidor: el que te de tu panel de Rumble. Usa CBR y keyframe 2s obligatorio, si no Rumble te baja la calidad. Bitrate máximo recomendado por ellos es 8000, pero para 720p15 no necesitas pasar de 3500.
3.  **Si ves Encoding Lag:** Abre `Ver > Estadísticas`. Si sube, baja el preset un escalón. No bajes el bitrate, baja el preset.

¿Quieres que te lo deje ya como perfil importable de OBS con la opción 1 de streaming?