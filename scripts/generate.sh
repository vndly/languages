#!/usr/bin/env bash

set -e

flutter pub upgrade
flutter pub run build_runner build --delete-conflicting-outputs
dart format lib