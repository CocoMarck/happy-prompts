# shellcheck shell=bash
readonly HELPERS_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
readonly ROOT_DIR="$(cd -- "$HELPERS_DIR/.." && pwd -P)"
readonly SCRIPTS_DIR="$ROOT_DIR/scripts"
readonly TEMPLATES_DIR="$ROOT_DIR/templates"
readonly PROMPTS_DIR="$ROOT_DIR/prompts"