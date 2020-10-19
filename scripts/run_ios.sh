#!/usr/bin/env bash

set -e

FLAVOR="dev"
#FLAVOR="prod"

flutter run -t lib/main/main_${FLAVOR}.dart