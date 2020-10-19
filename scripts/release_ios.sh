#!/usr/bin/env bash

set -e

FLAVOR="dev"
#FLAVOR="prod"

flutter clean
flutter pub get
flutter build ios --release --no-codesign -t lib/main/main_${FLAVOR}.dart

cd ios
fastlane prod