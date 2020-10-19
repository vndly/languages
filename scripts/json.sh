#!/usr/bin/env bash

set -e

flutter pub run build_runner build --delete-conflicting-outputs
flutter format lib