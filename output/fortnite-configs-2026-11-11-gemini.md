### 1. Diagnóstico de Hardware y Software

Tu equipo **sí está capacitado** para jugar *Fortnite*, pero tiene una limitación técnica clave: la **AMD Radeon RX 6400**.

* **El problema de la GPU:** Solo usa **4 líneas PCIe (x4)**. Si tu tarjeta madre no es PCIe 4.0 (tu procesador Ryzen 5 3500X solo soporta PCIe 3.0), la GPU pierde entre un 15% y 25% de rendimiento por el cuello de botella del bus. Además, solo tiene **4 GB de VRAM**, lo que causa tirones (*stuttering*) si subes mucho la calidad de las texturas.
* **CPU y RAM:** El Ryzen 5 3500X (6 núcleos / 6 hilos) y los 16 GB de RAM cumplen bien para un *Casual Shooter*, pero la falta de *multithreading* (SMT) hará que el procesador sufra si juegas sin límite de FPS.

---

### 2. Recomendación de Upgrade (HW y SW)

* **Perfil Máxima Calidad (1080p 60 FPS estables en Alto/Épico):**
* **GPU:** AMD Radeon RX 6600 8GB / RX 7600 (evitas el cuello de botella del bus x4 y ganas 8GB VRAM).
* **CPU:** AMD Ryzen 5 5600 (te da SMT/12 hilos, eliminando tirones de CPU).


* **Perfil Equilibrado (1080p 90-120 FPS sólidos):**
* **HW Actual:** Mantener tu Ryzen 3500X + RX 6400 corriendo obligatoriamente en **DirectX 12**.


* **Perfil Competitivo (1080p 144+ FPS consistentes):**
* **GPU:** NVIDIA RTX 3060 12GB o RTX 4060 (NVIDIA gestiona mejor los FPS en bajas resoluciones y Renderizado por Rendimiento/DirectX 11).
* **CPU:** AMD Ryzen 7 5700X3D (la caché L3 extra elimina por completo la fluctuación de FPS).



---

### 3. Archivos de Configuración (`GameUserSettings.ini`)

#### ¿Dónde encontrar y guardar el archivo?

Presiona `Win + R`, pega la siguiente ruta y presiona Enter:
`%LOCALAPPDATA%\FortniteGame\Saved\Config\WindowsClient\`

Ahí verás el archivo `GameUserSettings.ini`. Reemplaza su contenido por el del perfil que quieras usar. **Nota:** Antes de editarlo, da clic derecho al archivo > *Propiedades* y asegúrate de que **NO** esté marcado como "Solo lectura". Una vez guardado, puedes marcarlo como "Solo lectura" si no quieres que el juego te cambie los ajustes al entrar.

---

#### Perfil 1: Máxima Calidad (30-60 FPS)

*API: DirectX 12 (Mejor gestión de hilos en AMD). Se limita a 60 FPS para no saturar la GPU.*

```ini
[/Script/FortniteGame.FortniteGameUserSettings]
bUseVSync=False
bUseDynamicResolution=True
ResolutionSizeX=1920
ResolutionSizeY=1080
FrameRateLimit=60.000000
GraphicsQuality=0
gssResolutionQuality=85.000000
gssViewDistanceQuality=2
gssAntiAliasingQuality=2
gssShadowQuality=2
gssGlobalIlluminationQuality=1
gssReflectionQuality=1
gssPostProcessQuality=2
gssTextureQuality=2
gssEffectsQuality=1
gssFoliageQuality=2
gssShadingQuality=1
PreferredGraphicsAPI=DX12
bShowFPS=True

```

---

#### Perfil 2: Equilibrado (60-90 FPS Estables)

*API: DirectX 12 (Evita los picos de uso de CPU que da DX11 en tarjetas AMD). Gráficos medios, distancia alta.*

```ini
[/Script/FortniteGame.FortniteGameUserSettings]
bUseVSync=False
bUseDynamicResolution=False
ResolutionSizeX=1920
ResolutionSizeY=1080
FrameRateLimit=90.000000
GraphicsQuality=0
gssResolutionQuality=100.000000
gssViewDistanceQuality=2
gssAntiAliasingQuality=1
gssShadowQuality=0
gssGlobalIlluminationQuality=0
gssReflectionQuality=0
gssPostProcessQuality=1
gssTextureQuality=1
gssEffectsQuality=1
gssFoliageQuality=0
gssShadingQuality=0
PreferredGraphicsAPI=DX12
bShowFPS=True

```

---

#### Perfil 3: Competitivo (Máxima Fluidez y Visibilidad)

*API: Performance Mode / Rendimiento (Alfa). Todo al mínimo para maximizar FPS y reducir input lag.*

```ini
[/Script/FortniteGame.FortniteGameUserSettings]
bUseVSync=False
bUseDynamicResolution=False
ResolutionSizeX=1920
ResolutionSizeY=1080
FrameRateLimit=144.000000
GraphicsQuality=0
gssResolutionQuality=100.000000
gssViewDistanceQuality=2
gssAntiAliasingQuality=0
gssShadowQuality=0
gssGlobalIlluminationQuality=0
gssReflectionQuality=0
gssPostProcessQuality=0
gssTextureQuality=0
gssEffectsQuality=0
gssFoliageQuality=0
gssShadingQuality=0
PreferredGraphicsAPI=RenderingModePerformance
bShowFPS=True

```

---

### 4. Parámetros de Inicio y Accesos Directos

#### ¿Cómo poner los parámetros en el Epic Games Launcher?

1. Abre el **Epic Games Launcher**.
2. Da clic en el ícono de tu **Perfil** (arriba a la derecha) > **Ajustes**.
3. Baja hasta la sección de **Fortnite**, despliega el menú y marca la casilla **Argumentos adicionales de la línea de comandos**.

#### Comandos recomendados según Perfil:

* **Para Perfil 1 (Máxima Calidad):**
`-d3d12 -USEALLAVAILABLECORES -limitframerate 60`
* **Para Perfil 2 (Equilibrado):**
`-d3d12 -USEALLAVAILABLECORES -high -NOTEXTURESTREAMING`
* **Para Perfil 3 (Competitivo):**
`-featureleveles31 -USEALLAVAILABLECORES -high -preferredprocessor 6 -nosplash`

---

#### Crear accesos directos para cada Perfil

Si quieres lanzar un perfil específico directamente sin editar el archivo `.ini` manualmente cada vez:

1. Ve al directorio del ejecutable de Fortnite:
`C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\`
2. Busca el archivo `FortniteClient-Win64-Shipping.exe`.
3. Da clic derecho sobre él > **Mostrar más opciones** > **Crear acceso directo** (guárdalo en el Escritorio).
4. Renombra el acceso directo (ej. `Fortnite - Competitivo`).
5. Da clic derecho en el acceso directo > **Propiedades**.
6. En la pestaña **Acceso directo**, ve al campo **Destino** y añade al final de las comillas un espacio y los comandos deseados.

**Ejemplo de campo Destino para el modo Competitivo:**

```text
"C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe" -featureleveles31 -USEALLAVAILABLECORES -high

```

> **Tip para la RX 6400:** En el software *AMD Software: Adrenalin Edition*, asegúrate de tener activado **Radeon Anti-Lag** y desactivar cualquier tipo de *Super Resolution* (RSR) para que la latencia se mantenga lo más baja posible.