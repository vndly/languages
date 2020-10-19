#!/usr/bin/env bash

set -e

DIR=`dirname $0`

flutter clean
flutter pub get
flutter pub run daassets:daassets.dart $DIR/../pubspec.yaml $DIR/../lib/resources/assets.dart
flutter format lib