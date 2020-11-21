#!/usr/bin/env bash

set -e

DIR=`dirname $0`

flutter pub upgrade
flutter pub run dapackages:dapackages.dart $DIR/../pubspec.yaml
flutter pub outdated