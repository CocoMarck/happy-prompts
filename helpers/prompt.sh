#!/bin/bash
render() {
    envsubst <"$1"
}
emit_prompt() {
    text=$(render "$1")
    echo -e "$text"
    if [ "$2" != "" ]; then
        echo -e "-----------------"; echo -e ""
        echo -e "Escribiendo prompt..."
        echo -e "$text" >"$2"
        echo -e "¡Prompt escrito!"
    fi
}
