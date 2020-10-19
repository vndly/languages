#!/usr/bin/env bash

set -e

DIR=`dirname $0`

if [ "$(uname)" == "Darwin" ]; then
    . "${DIR}/run_ios.sh"
else
    . "${DIR}/run_android.sh"
fi