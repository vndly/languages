#!/usr/bin/env bash

set -e

DIR=`dirname $0`

FORMAT="json"
TOKEN="c35738b2-b4af-4100-8d25-4f86a54df4b4"
URL="https://script.google.com/macros/s/AKfycbxWmtdSanzjmdQXEJnrp2b9U1cl41aOvqsnn0WGEgRlv-0VxKQ_/exec"

wget -O "${DIR}/../assets/i18n/en.json" "${URL}?locale=en&format=${FORMAT}&token=${TOKEN}"
wget -O "${DIR}/../assets/i18n/es.json" "${URL}?locale=es&format=${FORMAT}&token=${TOKEN}"
wget -O "${DIR}/../assets/i18n/el.json" "${URL}?locale=el&format=${FORMAT}&token=${TOKEN}"

flutter pub run dalocale:dalocale.dart $DIR/../assets/i18n/ $DIR/../lib/resources/localizations.dart en $DIR/../lib
flutter format lib