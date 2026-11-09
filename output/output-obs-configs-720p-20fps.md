**Conclusión: Tu configuración es de gama baja para 720p/20FPS, el cuello de botella principal está en el codificador de hardware AMF de la GPU RX 6400 (calidad de imagen deficiente) y la ausencia de codificación de hardware en la CPU.**

Aunque la velocidad de subida de 71 Mbps es muy suficiente, si se persigue calidad de imagen, **se recomienda encarecidamente usar codificación por software x264 y asumir la carga de CPU**. Sin embargo, dado que el objetivo es 20FPS, la presión sobre el codificador es mucho menor que a 60FPS, por lo que x264 es completamente viable.

### 📊 Conclusión breve

| Elemento | Evaluación |
|------|------|
| **Nivel del equipo** | Gama media-baja, la CPU (6 núcleos) aún tiene algo de capacidad, la GPU tiene codificador débil |
| **Factor limitante principal** | El codificador AMF de la RX 6400 tiene calidad deficiente a bajo bitrate; **no tiene codificación de hardware en CPU** |
| **Estrategia central** | **Priorizar x264 por software**, reducir la resolución a 720p, 20FPS es la clave para aliviar la carga |
| **Objetivo recomendado** | 720p / 20FPS / x264 / preset veryfast, equilibrando calidad y estabilidad |

### 📡 Configuración para Streaming (PeerTube)

**Parámetros comunes (Configuración → Salida → Salida avanzada)**

| Parámetro | Valor |
|------|-----|
| Codificador | x264 |
| Control de tasa | CBR |
| Bitrate | **3000 Kbps** (el bitrate oficial recomendado para 720p es 2500–4000 Kbps)  |
| Intervalo de fotogramas clave | 2 s |
| Perfil | high |
| Preset de CPU | **veryfast** o **superfast** |
| Audio | AAC 128–160 Kbps, 48 kHz |

#### 1. Configuración de imagen estable (equilibrada)
- **Bitrate**: `3500 Kbps`
- **Preset de CPU**: `veryfast`
- **Tasa de fotogramas clave**: 2 s
- **Filtro de escalado**: Lanczos (más nítido, pero ligeramente más carga)

> A 20FPS, x264 veryfast puede mantener un mejor equilibrio entre calidad de imagen y carga.

#### 2. Configuración con prioridad absoluta a la imagen
- **Bitrate**: `4000 Kbps` (cerca del límite superior de 720p)
- **Preset de CPU**: `faster` o `fast` (mejor compresión)
- **Perfil**: `high`
- **Intervalo de fotogramas clave**: 2 s

> Cuanto más lento es el preset, mejor es la calidad de imagen, pero a 20FPS el margen de CPU sigue siendo suficiente. Si CPU se acerca al 80%, baja a veryfast.

#### 3. Configuración con prioridad a la fluidez del streaming
- **Bitrate**: `2500 Kbps`
- **Preset de CPU**: `superfast` o `ultrafast`
- **Reducir resolución de salida a 640×360** (alivia la carga de GPU y CPU simultáneamente)

> Al reducir el bitrate y aumentar la velocidad del preset se asegura la estabilidad, pero la calidad de imagen se degrada notablemente. **No se recomienda usar AMF en streaming**, ya que la calidad de imagen no es buena y empeora la situación.

### 💾 Grabación de video local

**Configuración → Salida → Salida avanzada → Grabación**

| Parámetro | Valor |
|------|-----|
| Formato de grabación | **MKV** (evita corrupción por bloqueo, luego remuxear a MP4)  |
| Codificador | x264 |
| Control de tasa | **CRF** |
| Valor CRF | **18–20** (menor número = mejor calidad)  |
| Intervalo de fotogramas clave | 2 s |
| Preset de CPU | **veryfast** (equilibrado) o **faster** (prioridad a calidad) |
| Audio | AAC 256–320 Kbps |

#### 1. Equilibrada
- **CRF**: `20`
- **Preset**: `veryfast`
- **Ubicación de grabación**: Disco `D:` o `E:` con mayor espacio

> CRF 20 ya tiene calidad de imagen aceptable, el tamaño del archivo es controlable. Recuerda guardar en MKV.

#### 2. Prioridad a bajo uso del PC
- **CRF**: `23`
- **Preset**: `superfast`
- **Tasa de fotogramas**: mantener 20 FPS (no bajar más)

> Al aumentar CRF y acelerar el preset se reduce la carga de CPU, a costa de perder algo de calidad de imagen y aumentar ligeramente el tamaño del archivo (compresión menos eficiente).

#### 3. Prioridad a calidad (tamaño de archivo aceptable)
- **CRF**: `18`
- **Preset**: `fast` o `faster`
- **Resolución de salida**: 720p
- **Tasa de fotogramas**: 20 FPS

> No uses `medium` o más lento, la CPU de 6 núcleos a 20FPS podría empezar a tener dificultades. CRF 18 es calidad visualmente casi sin pérdidas, con tamaño de archivo aceptable.

### 📌 Consideraciones específicas para la plataforma PeerTube

1. **PeerTube no impone límites estrictos de bitrate**, pero se recomienda mantenerlo por debajo de 4000 Kbps para 720p, ya que el transcodificado del lado del servidor podría consumir más recursos.
2. **PeerTube soporta RTMP**, puedes ingresar directamente la URL del servidor y la clave de streaming en OBS.
3. Si PeerTube tiene transcodificación habilitada en el servidor, **no necesitas subir bitrate demasiado alto**, la calidad de imagen final está limitada por el bitrate de la versión transcodificada en el servidor.
4. **Codificación de audio**: PeerTube típicamente acepta AAC, 128 Kbps es suficiente.

### ⚠️ Recordatorios clave

- **La velocidad de subida de 71 Mbps no es un cuello de botella**, elegir 3000–4000 Kbps es completamente estable.
- **La debilidad del AMF de la RX 6400 se refleja en baja calidad de imagen a bajo bitrate**; a 20FPS, x264 por software es más confiable.
- **Los 20FPS en sí mismo reducen enormemente la carga del codificador**, esa es tu mayor ventaja.
- Si sientes que los ventiladores de la CPU son ruidosos o la temperatura alta, prioriza bajar el preset a superfast, no bajes la tasa de fotogramas.