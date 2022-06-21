#!/bin/sh

TERMINFO_FILE=$1
TERMINFO_PATH="${HOME}/.terminfo"

mkdir -p "${TERMINFO_PATH}"
tic -o "${TERMINFO_PATH}" "${TERMINFO_FILE}"
