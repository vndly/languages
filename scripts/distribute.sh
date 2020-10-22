#!/usr/bin/env bash

set -e

DIR=`dirname $0`

${DIR}/incrementer.sh

. ${DIR}/secret.sh
export FIREBASE_TOKEN=${FIREBASE_TOKEN}

flutter clean
flutter pub get
flutter build apk --release -t lib/main/main.dart

cd ${DIR}/../android
./gradlew appDistributionUploadRelease