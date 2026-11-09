Configuración recomendada de OBS Studio — Debian 13 + Rumble
Con tu Ryzen 5 3500X, RX 6400 y 16 GB de RAM, podemos conseguir un streaming a 864×486, 20 FPS bastante estable. No necesitas una PC de gama alta para ese objetivo.

Hay un detalle importante: la RX 6400 no dispone de codificador de vídeo por hardware H.264. Por tanto, la recomendación principal será utilizar x264 (CPU). Esto nos permite evitar depender de una aceleración de codificación que tu GPU no ofrece.
1. Evaluación del hardware
Componente	Evaluación
Ryzen 5 3500X	Adecuado
RX 6400 4 GB	Adecuada
RAM 16 GB	Suficiente
Ethernet	Recomendado
Subida 89.72 Mbps	Excelente

Clasificación: PC de gama media-baja para tareas generales, pero perfectamente capaz para el objetivo de streaming que planteas.

Tu conexión tampoco representa una limitación importante en condiciones normales. El verdadero factor que debemos controlar es la carga del procesador durante la codificación.
2. Configuración general de vídeo
En OBS, entra en Ajustes → Vídeo.
Parámetro	Valor
Resolución de lienzo	1920×1080
Resolución de salida	864×486
Filtro de escalado	Bicúbico
FPS	20
Formato de color	NV12
Espacio de color	Rec. 709
Rango de color	Parcial

¿Por qué bicúbico? Es un buen equilibrio entre calidad de escalado y carga de procesamiento. Lanczos también es válido, pero no considero necesario utilizarlo para esta resolución.

Mantendría el lienzo en 1920×1080 para que puedas trabajar con tus fuentes normalmente y dejar que OBS reduzca la imagen.
3. Streaming
Entra en Ajustes → Salida → Modo de salida: Avanzado → Emisión.

Los tres perfiles utilizarán x264.
Perfil 1. Equilibrado
Mi recomendación inicial
2,500 Kbps
Parámetro	Valor
Codificador	x264
Control de frecuencia	CBR
Bitrate	2500 Kbps
Intervalo de fotogramas clave	2 s
Preset CPU	superfast
Perfil	High
Tune	None
B-frames	0

Buen punto intermedio entre compresión, calidad y carga de CPU.

Perfil 2. Prioridad a calidad
Mayor calidad de imagen
4,000 Kbps
Parámetro	Valor
Codificador	x264
Control de frecuencia	CBR
Bitrate	4000 Kbps
Intervalo de fotogramas clave	2 s
Preset CPU	veryfast
Perfil	High
Tune	None
B-frames	0

Más información disponible por segundo para conservar detalles, especialmente en escenas con movimiento. Requiere más CPU que el perfil anterior.

Importante: no significa vídeo sin pérdidas. Es una configuración de mayor calidad para streaming.

Perfil 3. Prioridad a estabilidad
Menor carga de CPU
1,500 Kbps
Parámetro	Valor
Codificador	x264
Control de frecuencia	CBR
Bitrate	1500 Kbps
Intervalo de fotogramas clave	2 s
Preset CPU	ultrafast
Perfil	Main
Tune	None
B-frames	0

Reduce la carga de codificación, pero sacrifica calidad y eficiencia de compresión. Es el perfil de emergencia si tienes encoding lag.

Sobre los presets: x264 utiliza más recursos conforme avanzas hacia presets más lentos, pero consigue mayor eficiencia de compresión. Por eso ultrafast no significa mejor calidad ni menor bitrate para conseguir la misma calidad.

Los valores son perfiles iniciales propuestos para tu equipo, no resultados de pruebas de rendimiento realizadas en tu PC.
Audio para streaming
En Ajustes → Salida → Audio:
- Codificador: AAC.
- Bitrate: 128 Kbps.
- Frecuencia de muestreo: 44.1 kHz.
- Canales: Estéreo.
4. Grabación local
Aquí cambiaremos el planteamiento: no necesitamos mantener un bitrate constante. Utilizaremos CRF, que permite ajustar la calidad y adaptar el bitrate a la complejidad de cada escena.

En Ajustes → Salida → Grabación:
Parámetro	Valor
Tipo	Estándar
Formato	MKV
Codificador	x264
Control de frecuencia	CRF
Perfil	High

Perfil 1. Equilibrado
Recomendado
CRF 23
- Preset: veryfast
- Calidad: buena.
- Consumo: moderado.
- Tamaño: moderado.
Adecuado para grabaciones habituales, sin exigir demasiado al procesador.

Perfil 2. Prioridad a bajo uso de PC
CRF 23
- Preset: ultrafast
- Calidad: aceptable.
- Consumo: bajo.
- Tamaño: mayor.
Es la opción para grabar mientras ejecutas juegos o aplicaciones exigentes. Al comprimir menos eficientemente, los archivos pueden ocupar bastante más espacio.

Perfil 3. Prioridad a calidad
CRF 20
- Preset: faster
- Calidad: alta.
- Consumo: elevado.
- Tamaño: moderado a elevado.
Conserva más detalles y utiliza una compresión más eficiente que ultrafast. Es una buena opción cuando no estás limitado por el uso de CPU.

Importante sobre los archivos:
- Graba en MKV para proteger la grabación si OBS o el sistema se cierran inesperadamente.
- Después puedes utilizar Archivo → Remultiplexar grabaciones para convertir MKV a MP4 sin volver a codificar el vídeo.
- No recomiendo grabar en MP4 directamente.
Los valores CRF siguen la orientación de la documentación de OBS: valores menores ofrecen más calidad y archivos mayores. 

OBS+1

5. Cómo evitar cortes y freezes
Hay que distinguir dos problemas diferentes en OBS:
Problema	Causa habitual	Solución
Encoding lag	CPU insuficiente para codificar	Preset más rápido o bajar resolución/FPS
Network drops	Problemas de conexión hacia Rumble	Reducir bitrate o corregir conexión
Rendering lag	GPU saturada	Reducir carga gráfica y composición de escenas

Tu conexión Ethernet de 89.72 Mbps de subida es bastante superior a los bitrates que estamos proponiendo.

Por ejemplo, con 4 Mbps utilizarías menos del 5% de tu capacidad de subida medida. Sin embargo, eso no garantiza que no haya pérdidas de paquetes, congestión o problemas de ruta hacia Rumble.
Ajustes adicionales recomendados
En Ajustes → Avanzado:
- Prioridad del proceso: Normal.
- Renderizador: OpenGL.
- Formato de color: NV12.
- Espacio de color: Rec. 709.
- Rango: Parcial.
- Reconexión automática: Activada.
- Retraso de red: Desactivado inicialmente.
También recomiendo:
1. No ejecutar juegos con FPS ilimitados mientras transmites.
2. Evitar que el procesador permanezca al 100%.
3. Cerrar aplicaciones innecesarias.
4. No utilizar filtros de vídeo pesados.
5. Mantener OBS y sus fuentes lo más sencillos posible.
Cómo comprobar si funciona
Después de transmitir durante 20-30 minutos, abre Ver → Estadísticas.
Indicadores que debes vigilar
Frames perdidos por retraso de renderizado
0% ideal

Frames perdidos por retraso de codificación
0% ideal

Frames perdidos por problemas de red
0% ideal


Son objetivos de diagnóstico, no garantías. Un pequeño porcentaje ocasional también merece investigarse si produce cortes perceptibles.

Mi recomendación es comenzar con el perfil equilibrado. Si aparecen frames perdidos por codificación, prueba ultrafast. Si aparecen por red, prueba reducir el bitrate y revisar la conexión.

No confundas ambos problemas: bajar el bitrate no soluciona necesariamente el encoding lag.
6. Consideraciones específicas para Rumble
Hay un detalle importante: Rumble tiene distintas modalidades de recepción de streaming.
- Rumble Live tradicional: permite utilizar software compatible con RTMP, incluido OBS. Obtienes la URL y clave de transmisión al configurar tu directo. 
  
  Rumble FAQ
- Rumble Studio Direct RTMP: tiene una tabla de recomendaciones propia. Para resoluciones de 240p a 720p recomienda 4 Mbps a 30 FPS y 6 Mbps a 60 FPS. 
  
  Rumble FAQ
Tu objetivo de 864×486 está dentro del rango de resolución de 240p a 720p.

Sin embargo, Rumble recomienda 30 FPS para ese rango, mientras que tú quieres 20 FPS. Mantendría tus 20 FPS inicialmente, pero comprobaría que la modalidad de transmisión que utilizas los acepta correctamente.

En cuanto al códec, H.264 es la elección adecuada. También recomiendo conservar el intervalo de fotogramas clave de 2 segundos.

Documentación:
- Rumble – How to Setup a Livestream.
- Rumble – Direct RTMP Recommended Stream Settings.
- OBS – Advanced Recording Settings.

7. Mi recomendación final
Configuración que utilizaría inicialmente
Objetivo equilibrado
Streaming
- 864×486.
- 20 FPS.
- x264.
- CBR: 2500 Kbps.
- Preset: superfast.
- Keyframe: 2 segundos.

Grabación local
- 864×486.
- 20 FPS.
- x264.
- CRF: 23.
- Preset: veryfast.
- Formato: MKV.
  
  Rendimiento esperado
Tu PC debería poder manejar estas configuraciones sin demasiadas complicaciones, siempre que la aplicación o juego que estés transmitiendo no consuma excesivos recursos.

Una última observación: si grabas simultáneamente mientras transmites, utilizarás dos procesos de codificación x264 si configuras codificadores independientes. Eso puede aumentar considerablemente la carga del Ryzen 3500X. Para comenzar, probaría únicamente streaming y después añadiría la grabación.

Mi consejo: no intentes conseguir la máxima calidad desde el primer momento. Primero consigue 30-60 minutos de transmisión sin frames perdidos y después aumenta la calidad progresivamente.

Con tu RX 6400, una futura actualización a una GPU con codificador H.264 por hardware también podría ser interesante. No porque necesites más potencia gráfica, sino porque liberarías al Ryzen de buena parte del trabajo de codificación. 

AMD+1