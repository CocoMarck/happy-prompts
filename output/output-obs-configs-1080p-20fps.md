**Resumen del hardware:**  
Tu PC es **aceptable / mid-low** para 1080p a 20 FPS. El Ryzen 5 3500X puede manejarlo, pero al no tener encoder de hardware en la RX 6400 (todo va por x264 en CPU) y con el juego fluctuando de FPS, es fácil que aparezcan encoding lags si aprietas mucho la calidad.  

**Objetivo equilibrado recomendado:**  
Quédate en **1080p 20 FPS** solo si limitas el juego a 60 FPS y usas presets rápidos. Si ves muchos frames perdidos, baja a 900p o 720p.

---

### Configuración base (aplica a todo)

**Video**
- Base (Canvas): `1920x1080`
- Output (Scaled): `1920x1080`
- Downscale Filter: **Lanczos**
- FPS: `20`
- Color Format: NV12 | Color Space: 709 | Range: Limited

**Advanced**
- Process Priority: **High**
- Captura: **PipeWire** (Game Capture o Window Capture)

---

### Streaming (x264 + CBR) – 1080p 20 FPS

| Opción | Preset | Bitrate | Keyframe | Recomendado para | Comentario |
|--------|--------|---------|----------|------------------|----------|
| **1. Equilibrada** (punto intermedio) | `veryfast` | **4500 kbps** | 2 s | Uso diario | Mejor balance calidad/estabilidad |
| **2. Máxima calidad** | `fast` | **6000–7000 kbps** | 2 s | Cuando quieras la mejor imagen posible | Puede generar encoding lag en picos del juego |
| **3. Máxima estabilidad** | `ultrafast` | **3500–4000 kbps** | 2 s | Cero trabes | La más segura con tu CPU |

**Ajustes comunes de Streaming:**
- Rate Control: **CBR**
- Profile: **high**
- Tune: `none`
- x264 Options: dejar vacío o `threads=4`

Con tu subida de ~90 Mbps no tienes problema de red. El límite real es el CPU.

---

### Grabación local (x264)

| Opción | Rate Control | Preset | CRF | Calidad / Peso | Uso de PC |
|--------|--------------|--------|-----|----------------|---------|
| **1. Equilibrada** | CRF | `veryfast` | **20** | Buena calidad, peso razonable | Bajo-Medio |
| **2. Bajo uso de PC** | CRF | `ultrafast` | **23** | Calidad aceptable, archivos más pesados | Muy bajo |
| **3. Prioridad calidad** | CRF | `fast` | **18** | Muy buena calidad, peso aún aceptable | Medio |

- Contenedor recomendado: **MKV** (luego puedes remuxear a MP4)
- Audio: AAC 160–192 kbps

---

### Recomendación práctica según tu experiencia anterior

Como ya viste que a 3500 kbps en 720p perdías frames puntuales:

- Empieza con la **Opción 1 de Streaming** (`veryfast` + 4500 kbps).
- Si ves más de 1-2% de frames perdidos → baja a 4000 kbps o cambia a `ultrafast`.
- Limita el juego a **60 FPS** (muy importante).

---

### Notas por plataforma (al final)

| Plataforma | Bitrate máximo recomendado | Notas |
|------------|---------------------------|-------|
| **YouTube** | Hasta 8-12 Mbps | Acepta bien 6000-7000 kbps. Puedes usar la opción 2. |
| **Kick** | ~6-8 Mbps | Similar a Twitch. 4500-6000 kbps está bien. |
| **Facebook** | 4-6 Mbps | Mejor no pasar de 5000-6000 kbps. |
| **TikTok** | 2.5-4 Mbps (vertical) | 1080p20 no es ideal. Mejor 720p o 1080x1920 vertical. |
| **BiliBili** | 4-8 Mbps | Similar a YouTube. |
| **PeerTube** | Depende del servidor | Usa 4000-6000 kbps para compatibilidad. |

**Consejo extra:**  
Si vas a streamear a varias plataformas a la vez (multistream), baja el bitrate a **4000 kbps** y usa `ultrafast` o `veryfast` para no sobrecargar el CPU.

¿Quieres que te pase los valores exactos listos para copiar pestaña por pestaña de OBS?**Resumen del hardware:**  
Tu PC es **aceptable / mid-low** para 1080p a 20 FPS. El Ryzen 5 3500X puede manejarlo, pero al no tener encoder de hardware en la RX 6400 (todo va por x264 en CPU) y con el juego fluctuando de FPS, es fácil que aparezcan encoding lags si aprietas mucho la calidad.  

**Objetivo equilibrado recomendado:**  
Quédate en **1080p 20 FPS** solo si limitas el juego a 60 FPS y usas presets rápidos. Si ves muchos frames perdidos, baja a 900p o 720p.

---

### Configuración base (aplica a todo)

**Video**
- Base (Canvas): `1920x1080`
- Output (Scaled): `1920x1080`
- Downscale Filter: **Lanczos**
- FPS: `20`
- Color Format: NV12 | Color Space: 709 | Range: Limited

**Advanced**
- Process Priority: **High**
- Captura: **PipeWire** (Game Capture o Window Capture)

---

### Streaming (x264 + CBR) – 1080p 20 FPS

| Opción | Preset | Bitrate | Keyframe | Recomendado para | Comentario |
|--------|--------|---------|----------|------------------|----------|
| **1. Equilibrada** (punto intermedio) | `veryfast` | **4500 kbps** | 2 s | Uso diario | Mejor balance calidad/estabilidad |
| **2. Máxima calidad** | `fast` | **6000–7000 kbps** | 2 s | Cuando quieras la mejor imagen posible | Puede generar encoding lag en picos del juego |
| **3. Máxima estabilidad** | `ultrafast` | **3500–4000 kbps** | 2 s | Cero trabes | La más segura con tu CPU |

**Ajustes comunes de Streaming:**
- Rate Control: **CBR**
- Profile: **high**
- Tune: `none`
- x264 Options: dejar vacío o `threads=4`

Con tu subida de ~90 Mbps no tienes problema de red. El límite real es el CPU.

---

### Grabación local (x264)

| Opción | Rate Control | Preset | CRF | Calidad / Peso | Uso de PC |
|--------|--------------|--------|-----|----------------|---------|
| **1. Equilibrada** | CRF | `veryfast` | **20** | Buena calidad, peso razonable | Bajo-Medio |
| **2. Bajo uso de PC** | CRF | `ultrafast` | **23** | Calidad aceptable, archivos más pesados | Muy bajo |
| **3. Prioridad calidad** | CRF | `fast` | **18** | Muy buena calidad, peso aún aceptable | Medio |

- Contenedor recomendado: **MKV** (luego puedes remuxear a MP4)
- Audio: AAC 160–192 kbps

---

### Recomendación práctica según tu experiencia anterior

Como ya viste que a 3500 kbps en 720p perdías frames puntuales:

- Empieza con la **Opción 1 de Streaming** (`veryfast` + 4500 kbps).
- Si ves más de 1-2% de frames perdidos → baja a 4000 kbps o cambia a `ultrafast`.
- Limita el juego a **60 FPS** (muy importante).

---

### Notas por plataforma (al final)

| Plataforma | Bitrate máximo recomendado | Notas |
|------------|---------------------------|-------|
| **YouTube** | Hasta 8-12 Mbps | Acepta bien 6000-7000 kbps. Puedes usar la opción 2. |
| **Kick** | ~6-8 Mbps | Similar a Twitch. 4500-6000 kbps está bien. |
| **Facebook** | 4-6 Mbps | Mejor no pasar de 5000-6000 kbps. |
| **TikTok** | 2.5-4 Mbps (vertical) | 1080p20 no es ideal. Mejor 720p o 1080x1920 vertical. |
| **BiliBili** | 4-8 Mbps | Similar a YouTube. |
| **PeerTube** | Depende del servidor | Usa 4000-6000 kbps para compatibilidad. |

**Consejo extra:**  
Si vas a streamear a varias plataformas a la vez (multistream), baja el bitrate a **4000 kbps** y usa `ultrafast` o `veryfast` para no sobrecargar el CPU.

¿Quieres que te pase los valores exactos listos para copiar pestaña por pestaña de OBS?