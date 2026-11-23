# **Configuración recomendada de OBS — Debian 13**

Con tu Ryzen 5 3500X, RX 6400 y 16 GB de RAM, puedes trabajar con 1080p a 15 FPS, pero hay una consideración importante: **tu RX 6400 no dispone de codificación de vídeo H.264 por hardware**. Por tanto, la codificación recaerá principalmente en el procesador mediante x264.

Tu equipo no es de gama alta para codificación por software, pero tampoco es insuficiente para este objetivo. 1080p a 15 FPS es una carga bastante más moderada que 1080p a 60 FPS.

Mi recomendación inicial es usar x264, mantener una frecuencia constante de 15 FPS y evitar presets demasiado exigentes. Tu conexión Ethernet tiene subida suficiente para trabajar con bitrates altos; el límite práctico será la plataforma y la estabilidad de la codificación.

## Lo que me jala
De hecho, **1080p / 15 FPS / x264 superfast / 6000 Kbps** me parece una configuración bastante sensata para tu Ryzen 5 3500X.

Y hay algo interesante: si visualmente ya te convence, no necesitas complicarte buscando más calidad por buscarla.

Yo conservaría ese perfil como tu configuración conocida y probaría solamente estos cambios:

- `superfast` → `veryfast`: comparar si mejora la compresión sin provocar encoding lag.
- Mantener los 6000 Kbps.
- Mantener 1080p y 15 FPS.
- Vigilar los tres indicadores de OBS durante sesiones de juego.

Si `veryfast` no aporta una mejora visual apreciable o provoca retrasos, vuelve a `superfast` sin pensarlo.

## **1. Configuración general de vídeo**

En **Ajustes → Vídeo**:

| Parámetro            | Configuración |
| -------------------- | ------------- |
| Resolución base      | 1920×1080     |
| Resolución de salida | 1920×1080     |
| Filtro de escalado   | Bicúbico      |
| FPS                  | 15            |

Como no necesitas cambiar de resolución, no hay necesidad de escalar. Si tu contenido se captura a 1080p, conserva esa resolución.

## **2. Streaming**

En **Ajustes → Salida → Modo avanzado → Emisión**:

Configuración común para los tres perfiles:

| Parámetro                     | Valor         |
| ----------------------------- | ------------- |
| Codificador                   | x264          |
| Control de frecuencia         | CBR           |
| Intervalo de fotogramas clave | 2 s           |
| Perfil                        | High          |
| Formato de color              | NV12          |
| Espacio de color              | Rec. 709      |
| Rango de color                | Parcial       |
| Audio                         | AAC, 160 Kbps |

Los siguientes perfiles están pensados para que puedas intercambiarlos según las condiciones de uso.

### **Perfiles de streaming**

**1. Equilibrado**

Recomendado

# **6,000 Kbps**

- Preset x264: `veryfast`
- CBR: `6000`
- Keyframe: `2`
- Profile: `high`
- Tune: ninguno

Buen punto intermedio entre calidad, compresión y consumo de CPU.

**2. Prioridad a calidad**

# **8,000 Kbps**

- Preset x264: `faster`
- CBR: `8000`
- Keyframe: `2`
- Profile: `high`
- Tune: ninguno

Mayor bitrate y mejor compresión por software. Consume más CPU. Si tienes margen suficiente, puedes probar `fast`, pero vigila el uso del procesador.

**3. Prioridad a estabilidad**

# **4,500 Kbps**

- Preset x264: `ultrafast`
- CBR: `4500`
- Keyframe: `2`
- Profile: `high`
- Tune: ninguno

Menor carga de CPU y menor exigencia de red. Sacrificas eficiencia de compresión y calidad visual.

**Importante:** los presets más lentos mejoran la eficiencia de compresión, pero no son una mejora gratuita. En tu Ryzen 5 3500X, `faster` puede ser perfectamente viable para 1080p15, pero depende de cuánto trabajo esté haciendo el juego simultáneamente.

No utilizaría opciones personalizadas de x264 como `bframes=3 ref=4` inicialmente. Dejaría que OBS use sus valores predeterminados.

### **3. Grabación de vídeo local**

En **Ajustes → Salida → Grabación**:

- Tipo: estándar.
- Formato: MKV.
- Codificador: x264.
- Control de frecuencia: CRF.
- Intervalo de fotogramas clave: 2.
- Perfil: High.
- Tune: ninguno.

**1. Equilibrada**

Recomendada

# **CRF 23**

- Preset: `veryfast`
- Calidad aceptable.
- Tamaño de archivo moderado.
- Carga de CPU razonable.

**2. Prioridad a bajo uso de PC**

# **CRF 23**

- Preset: `ultrafast`
- Menor exigencia de CPU.
- Menor eficiencia de compresión.
- Archivos potencialmente más grandes.

Es útil mientras juegas y grabas simultáneamente.

**3. Prioridad a calidad**

# **CRF 20**

- Preset: `faster`
- Mejor calidad visual.
- Mayor carga de CPU.
- Tamaño de archivo todavía razonable en comparación con configuraciones de calidad casi sin pérdidas.

Si quieres más calidad, puedes probar CRF 18, aunque aumentará el tamaño de los archivos.

Recuerda que CRF controla la calidad objetivo, no el tamaño exacto. El tamaño final depende del contenido: un juego con mucho movimiento puede ocupar bastante más que una escena estática.

**Consejo:** utiliza MKV para evitar perder toda la grabación si OBS o el sistema se cierran inesperadamente. Después puedes utilizar la opción *Remux Recordings* de OBS para convertirlo a MP4 sin volver a codificar el vídeo.

## **4. Audio**

Como no especificaste necesidades especiales:

| Parámetro              | Valor    |
| ---------------------- | -------- |
| Frecuencia de muestreo | 48 kHz   |
| Canales                | Estéreo  |
| Códec                  | AAC      |
| Bitrate de streaming   | 160 Kbps |
| Bitrate de grabación   | 192 Kbps |

## **5. Supervisión de estabilidad**

En OBS abre **Ver → Estadísticas**.

Estos son los indicadores que debes vigilar:

| Indicador                          | Qué significa                                   |
| ---------------------------------- | ----------------------------------------------- |
| Frames perdidos por red            | Problemas de conexión o envío                   |
| Frames retrasados por codificación | x264 no consigue codificar a tiempo             |
| Frames omitidos por renderizado    | OBS no consigue renderizar las escenas a tiempo |

Tu subida de 134 Mbps es suficiente para cualquiera de estos perfiles. Incluso a 8 Mbps utilizarías aproximadamente el 6 % de tu capacidad de subida medida.

Eso sí, una prueba de velocidad no garantiza estabilidad constante. Conviene probar durante sesiones largas y con el juego funcionando.

## **6. Consideraciones por plataforma**

[Rumble y empresa de Trump piden una medida cautelar - 24/02/2025 - Mundo - Folha](https://images.openai.com/static-rsc-4/SRutWgBXju-lG25saW8sNJ1BbDtlz-O8uaw_Cj75Q37tfQZTMFnJEZyOnJnanuNAq6nHzvDvjS2kXK341KxunE1oM34LtDgUAPbjhaNjK1sF7oeGdM0nE_Upejtq_pvqNbW0Zkf-CH7HuKyujCFNwH7Vjxcbh9hIM5mzICKsFMo?purpose=inline)

**Rumble**

Su documentación recomienda 8 Mbps para 1080p30 y 4 Mbps para 240p–720p30 mediante Direct RTMP. Tu objetivo de 1080p15 no aparece específicamente en esa tabla. El perfil equilibrado de 6 Mbps es un buen punto de partida.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://rumble.support\&sz=32)

Rumble FAQ+1



[La plateforme vidéo PeerTube | Jeunes en Nouvelle-Aquitaine](https://images.openai.com/static-rsc-4/qJAUO9_psvAQOOHdvj155PHjko7yDvA3BAZZu_B7mbaUsaAnzui9TFC0xIoA2kSMUFeHFoHw-wOOG2DNCBgmYg0XLjnRe9qNTZy4SIR1CKfOk4AS3vUwZzaX_vLxQaZG6vTxW9EnMJ9Iu14f-xmgeHoqr20yJwAl_MgcbHR4Gjs?purpose=inline)

**PeerTube**

Depende de la instancia a la que transmitas. El administrador puede establecer límites de transmisión y activar transcodificación en directo. Consulta las restricciones de tu instancia.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.joinpeertube.org\&sz=32)

PeerTube documentation



[Complex Pop Culture (@ComplexPop) on X](https://images.openai.com/static-rsc-4/SPAjYXP8SxP1KIu2gmzQrk1-4aSem5MrqdK6RCHdBqtaSVyqzrHi5elnNIBX9RP2wdKP-dYglOBwJeGDxvVrDvC4GlzLIKEMaUNP2tP06Z6iq6NzYuadp7Bwexf17GbZcoh4irK_HVKJXktwOlBj7unOzD8gO6DYHtuJkt1nu-4?purpose=inline)

**Kick**

Admite CBR, H.264, hasta 8,000 Kbps y keyframes de 2 segundos. Tu perfil de calidad llega justo al máximo de bitrate permitido. Ten en cuenta que actualmente algunos canales pueden no tener disponible la resolución 1080p para sus espectadores.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://help.kick.com\&sz=32)

Kick.com Help Center+2



[YouTube Community](https://images.openai.com/static-rsc-4/rybakriLKaMLYuECXogtfv9ooRMDqi8BezXbDc7MG23nyiNm2JoTBlxDSxyVgWq7RZjBocYdEeqWmAfjUyoR_wy5M91CpbNKX2VrqwRtveWG46-rx_NMrDkXLqjcm7ffJoLupOVbdaEsSUbdlQl227nQSFMfFJtpTnNc0exHaII?purpose=inline)

**YouTube**

Admite H.264, CBR y keyframes de 2 segundos. Su tabla oficial recomienda 10 Mbps para 1080p30 H.264. No publica un valor específico para 1080p15, por lo que tus 6–8 Mbps son un punto de partida razonable, no una garantía de calidad óptima.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://support.google.com\&sz=32)

Ayuda de YouTube



**Una observación sobre retransmitir desde Rumble:** si utilizas Rumble como punto de distribución hacia otras plataformas, la calidad que reciban dependerá también de cómo Rumble y cada plataforma procesen la señal. Un bitrate alto en OBS no garantiza que todas conserven exactamente la misma calidad.

## **Mi recomendación final**

Para tu hardware y objetivo, comenzaría con esta combinación:

**Streaming**

Configuración inicial

# **1080p · 15 FPS**

**x264 · veryfast · CBR 6000 Kbps**

**Grabación local**

**x264 · veryfast · CRF 23**

No considero que necesites cambiar de hardware para este objetivo. Tu principal limitación será la carga de CPU cuando juegues y transmitas simultáneamente.

Y algo que ya has comprobado con tus pruebas anteriores: no confundas los FPS del juego con los FPS de salida de OBS. Puedes jugar a 100 FPS y transmitir a 15 FPS perfectamente, siempre que la captura, el renderizado y la codificación mantengan sus tiempos.

**Yo priorizaría conservar esos 15 FPS estables antes que aumentar el bitrate o utilizar presets más lentos.** Una transmisión estable con buena imagen es mucho mejor que una de mayor calidad teórica con congelamientos.