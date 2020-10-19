#!/usr/bin/env bash

set -e

flutter clean
flutter pub get
flutter build apk --release -t lib/main/main.dart