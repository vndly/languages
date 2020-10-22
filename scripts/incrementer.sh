#!/usr/bin/env bash

set -e

DIR=`dirname $0`

flutter pub run daincrementer:daincrementer.dart $DIR/../pubspec.yaml