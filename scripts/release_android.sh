#!/usr/bin/env bash

set -e

FLAVOR="dev"
#FLAVOR="prod"

flutter clean
flutter pub get
#flutter build appbundle --release -t lib/main/main_${FLAVOR}.dart --flavor ${FLAVOR}
flutter build apk --release -t lib/main/main_${FLAVOR}.dart --flavor ${FLAVOR}