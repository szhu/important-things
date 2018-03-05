#!/bin/bash
set -eou pipefail
IFS=$'\n\t'

APP() {
    _APP="${1}"
}

ROLE() {
    _ROLE="${1}"
}

TYPE() {
    local _TYPE="${1}"
    echo duti -s "${_APP}" "${_TYPE}" "${_ROLE}"
    duti -s "${_APP}" "${_TYPE}" "${_ROLE}"
}


APP  'com.github.atom'
ROLE 'all'

    TYPE 'public.plain-text'
    TYPE 'public.source-code'
    TYPE 'public.script'
    TYPE 'public.shell-script'
    TYPE 'public.unix-executable'

    TYPE '.fish'
    TYPE '.ts'
    TYPE 'com.netscape.javascript-source'
    TYPE 'public.bash-script'
    TYPE 'public.json'
    TYPE 'public.python-script'
    TYPE 'public.ruby-script'


APP  'com.ridiculousfish.HexFiend'
ROLE 'all'

    TYPE 'public.data'
