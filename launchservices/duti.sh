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


APP  'com.sublimetext.3'
ROLE 'all'

    TYPE 'public.plain-text'
    TYPE 'public.source-code'
    TYPE 'public.script'
    TYPE 'public.shell-script'
    TYPE 'public.unix-executable'

    TYPE 'public.python-script'
    TYPE 'public.bash-script'
    TYPE 'com.netscape.javascript-source'
    TYPE '.fish'


APP  'com.ridiculousfish.HexFiend'
ROLE 'all'

    TYPE 'public.data'
