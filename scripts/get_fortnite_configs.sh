#!/bin/bash
# Script para generar un prompt para obtener configuraciones para fortnite.

set -euo pipefail

# Constantes
source "$(dirname -- "${BASH_SOURCE[0]}")/../helpers/paths.sh"

# Módulos
source "$HELPERS_DIR/network.sh" # Internet
source "$HELPERS_DIR/prompt.sh"  # Renderizar plantilla
source "$HELPERS_DIR/pc_info.sh" # Obtener información de hw o sw

# Variables necesarias
export hw_sw_info=""
export internet_upload_speed=""
export internet_download_speed=""
template_fortnite_configs="$TEMPLATES_DIR/template_fortnite_configs.md"
output=""

usage() {
    cat <<'USAGE'
Uso: get_fortnite_configs.sh [opciones]
    -o ARCHIVO  Escribe el archivo
    -h          Esta ayuda

Ejemplos:
    ./get_fortnite_configs.sh -o ./salida.md

USAGE
}


# ------------ args
while getopts o:h flag
do
    case "$flag" in
        o) output=${OPTARG};;
        h) usage; exit 0;;
        ?) usage >&2; exit 1;;
    esac
done

# Obtener
echo "Obtener output de fastfetch"
hw_sw_info=$(run_fastfetch_non_permissive)

echo "Obtener velocidad de subida"
bs_upload=$(measure_upload)
internet_upload_speed=$(bytes_to_mbps $bs_upload)

echo "Obtener velocidad de descarga"
internet_download_speed=$(bytes_to_mbps $(measure_download))

# Emit prompt
emit_prompt "$template_fortnite_configs" "$output"