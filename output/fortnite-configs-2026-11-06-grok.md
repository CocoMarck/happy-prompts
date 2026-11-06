**✅ Evaluación rápida de tu hardware/software**

Tu PC **sí puede jugar Fortnite** de forma jugable en 1080p, pero con limitaciones claras:

- **RX 6400 (4 GB VRAM)** es entrada de gama. Rinde bien en **Performance Mode** o settings bajos/medios, pero se queda corta en gráficos altos + efectos pesados o cuando hay mucha construcción/partículas.
- **Ryzen 5 3500X** + 16 GB RAM es suficiente.
- **Debian 13 + Wayland**: A noviembre 2026 Fortnite **todavía no está disponible** en Linux. Epic anunció en octubre 2026 que está reconstruyendo Easy Anti-Cheat (EAC Linux v2) y que Fortnite llegará a través del Epic Games Launcher nativo, pero **no hay fecha de lanzamiento**. Proton/Wine sigue bloqueado por el anti-cheat.  
  Mientras tanto solo puedes jugar dual-booteando Windows o esperando el lanzamiento oficial (Debian está en la lista de distros con claves reconocidas).

Internet (~89 Mbps) es excelente.

---

### 1. Máxima calidad (gráficos bonitos, 30-60 FPS estables)

**Objetivo**: Que se vea lo mejor posible sin matar el PC.

**Configuración recomendada (Video)**:
- Window Mode: **Fullscreen**
- Resolution: **1920x1080**
- VSync: **Off**
- Frame Rate Limit: **60**
- Rendering Mode: **DirectX 12** (suele verse mejor y en AMD a veces es más estable que Performance)
- 3D Resolution: **100%**
- View Distance: **Epic** o **Far**
- Shadows: **Medium**
- Global Illumination: **Ambient Occlusion** o **Medium**
- Reflections: **Screen Space**
- Textures: **High** o **Epic**
- Effects: **Medium**
- Post Processing: **Medium**
- Nanite / Lumen / Ray Tracing: **Off**
- Anti-Aliasing: **TSR Medium** o **High** (si está disponible)
- Motion Blur: **Off**
- Show FPS: **On**

**Parámetros de inicio recomendados** (Epic Launcher o acceso directo):
```bash
-USEALLAVAILABLECORES -NOTEXTURESTREAMING -d3d12
```

**Cómo crear acceso directo**:
1. Crea un acceso directo al ejecutable de Fortnite (o al launcher).
2. Propiedades → Destino → añade al final los parámetros de arriba.
3. Nómbralo “Fortnite - Calidad”.

---

### 2. Equilibrado (máxima estabilidad)

**Objetivo**: FPS lo más estables posible, sin tirones, API más confiable.

**Configuración recomendada**:
- Window Mode: **Fullscreen**
- Resolution: **1920x1080**
- VSync: **Off**
- Frame Rate Limit: **100** (o 90 si quieres más margen)
- Rendering Mode: **Performance Mode** (la más estable y con menos stutter en la mayoría de AMD)
- 3D Resolution: **100%**
- View Distance: **Far**
- Shadows: **Low** o **Off**
- Textures: **Medium**
- Effects: **Low**
- Post Processing: **Low**
- Meshes: **Low**
- Nanite / Lumen / RT: **Off**
- Anti-Aliasing: **Off** o **Low**
- Motion Blur: **Off**

**Parámetros de inicio**:
```bash
-USEALLAVAILABLECORES -NOTEXTURESTREAMING -d3d11
```
(o `-d3d12` si Performance Mode te da problemas)

**Acceso directo**: “Fortnite - Equilibrado”

---

### 3. Competitivo (visibilidad + 100 FPS estables o más)

**Objetivo**: Máxima fluidez, mínima fluctuación, buena visibilidad de enemigos.

**Configuración recomendada** (la más importante):
- Window Mode: **Fullscreen**
- Resolution: **1920x1080**
- VSync: **Off**
- Frame Rate Limit: **100** o **Unlimited** (y limítalo con tools externas si es necesario)
- Rendering Mode: **Performance Mode**
- 3D Resolution: **100%** (o 90-95% si necesitas más estabilidad)
- View Distance: **Near** o **Medium** (Near da más FPS y muchos competitivos lo usan)
- Shadows: **Off**
- Textures: **Low**
- Effects: **Low**
- Post Processing: **Off** o **Low**
- Meshes: **Low**
- Nanite / Lumen / RT: **Off**
- Anti-Aliasing: **Off**
- Motion Blur: **Off**
- Show FPS: **On**

**Parámetros de inicio**:
```bash
-USEALLAVAILABLECORES -NOTEXTURESTREAMING -d3d11 -HIGH
```

**Acceso directo**: “Fortnite - Competitivo”

---

### Recomendaciones de HW/SW según perfil

| Perfil              | ¿Tu HW actual es suficiente? | Recomendación mínima para buen gameplay                  | Ideal (2026)                              |
|---------------------|------------------------------|----------------------------------------------------------|-------------------------------------------|
| **Máxima calidad**  | Justo / ajustado             | RX 6600 / RX 7600 o RTX 3060 + 16-32 GB RAM             | RX 7700 XT / RTX 4060 Ti o superior      |
| **Equilibrado**     | Sí                           | Mantener actual + SSD NVMe si no lo tienes              | RX 6600 / RTX 3060                       |
| **Competitivo**     | Sí (en Performance Mode)     | Mantener actual (100 FPS estables es realista)          | RX 7600 / RTX 4060 + 32 GB RAM + monitor 144+ Hz |

**Consejos extras para tu setup actual**:
- Usa **gamemode** (`gamemoderun`) si juegas vía Proton cuando salga.
- En AMD: activa **Anti-Lag** y actualiza drivers Mesa/RADV al máximo.
- Cierra todo lo que no necesites (navegador, Discord en segundo plano pesado, etc.).
- Si dual-boteas Windows, ahí tendrás el rendimiento más predecible hoy mismo.

¿Quieres que te arme también los archivos `.desktop` completos para KDE (con icono, parámetros, etc.) o que te detalle cómo forzar Performance Mode / DX12 desde el launcher cuando salga en Linux? Dime y te los dejo listos.