#!/bin/bash
# Dependencias: `curl`
measure_download() {
    curl -o /dev/null -sS -w '%{speed_download}' --max-time 60 --retry 2 \
        'https://speed.cloudflare.com/__down?bytes=30000000'
}
measure_upload() {
    set +o pipefail
    head -c 40000000 /dev/zero \
        | curl -o /dev/null -sS -w '%{speed_upload}' --max-time 60 \
            -X POST --data-binary @- 'https://speed.cloudflare.com/__up'
    local st=$?
    set -o pipefail
    return $st
}
bytes_to_mbps(){
    # Es que curl obtiene en B/s.
    awk -v b="$1" 'BEGIN { m=(b*8)/1000000; if (m>0) printf "%.2f", m; else printf "0"}'
}