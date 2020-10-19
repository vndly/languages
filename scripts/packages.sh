#!/usr/bin/env bash

set -e

DIR=`dirname $0`

flutter pub run dapackages:dapackages.dart $DIR/../pubspec.yaml