#!/bin/bash
# Script para escribir un prompt para un agente AI. Que servirá para obtener configuraciones adecuadas para HW y SW del usuario.
# Dependencias: fastfetch, curl.
set -euo pipefail

# Constantes
source "$(dirname -- "${BASH_SOURCE[0]}")/../helpers/paths.sh"
template_obs_configs="$TEMPLATES_DIR/template_obs_configs.md"

# Módulos
source "$HELPERS_DIR/network.sh" # Internet
source "$HELPERS_DIR/prompt.sh"  # Renderizar plantilla
source "$HELPERS_DIR/pc_info.sh" # Obtener información de hw o sw

# Variables necesarias
export hw_sw_info=""
export internet_upload=""
export internet_download=""
export internet_receptor="Ethernet"
export resolution="720p"
export fps="20"
export multimedia_servicies="PeerTube"
export stream_type="Unilateral"
export audio_indications="Sin especificar. Por defecto esta bien."
output=""

# Funciones
usage() {
    cat <<'USAGE'
Uso: get_obs_configs.sh [opciones]
    
    -u MB       Subida en Mbps          (default: mide con curl)
    -d MB       Bajada en Mbps          (default: mide con curl)
    -r TEXTO    Medio de conexión       (default: Ethernet)
    -f TEXTO    Resolución de salida    (default: 720p)
    -n NUM      FPS                     (default: 20)
    -c TEXTO    Plataformas/contenido   (default: PeerTube)
    -s TEXTO    Tipo de stream          (default: Unilateral)
    -a TEXTO    Indicaciones para audio
    -o ARCHIVO  Escribe el archivo      
                (default: stdout, y escribe "generated_get_obs_configs_prompt.md")
    -h          Esta ayuda

Ejemplos:
    ./get_obs_configs.sh
    ./get_obs_configs.sh -u 90 -d 90 -r "Wifi" -s Multistream -c "PeerTube" -f "1080p" -n "20" -a "Stream musical"

USAGE
}

# ------------ args
while getopts u:d:r:f:n:c:s:a:o:h flag
do
    case "$flag" in
        u) internet_upload=${OPTARG};;
        d) internet_download=${OPTARG};;
        r) internet_receptor=${OPTARG};;
        s) stream_type=${OPTARG};;
        f) resolution=${OPTARG};;
        n) fps=${OPTARG};;
        a) audio_indications=${OPTARG};;
        c) multimedia_servicies=${OPTARG};;
        o) output=${OPTARG};;
        h) usage; exit 0;;
        ?) usage >&2; exit 1;;
    esac
done

# Obtener o no default
if [ -z "$hw_sw_info" ]; then
    echo "Obtener output de fastfetch"
    hw_sw_info=$(run_fastfetch_non_permissive)
fi

if [ -z "$internet_upload" ]; then
    echo "Obtener velocidad de subida"
    bs_upload=$(measure_upload)
    internet_upload=$(bytes_to_mbps $bs_upload)
fi
if [ -z "$internet_download" ]; then
    echo "Obtener velocidad de descarga"
    internet_download=$(bytes_to_mbps $(measure_download))
fi

if [ -z "$output" ]; then
    echo "Sin output, no se generara nada..."
   #output="$SCRIPTS_DIR/generated_get_obs_configs_prompt.md"
fi

# Remplazar texto de template y guardar texto (si es que esta especificado el output).
emit_prompt "$template_obs_configs" "$output"
