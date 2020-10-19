#!/usr/bin/env bash

set -e

flutter clean
flutter pub get
flutter build ios --release --no-codesign -t lib/main/main.dart