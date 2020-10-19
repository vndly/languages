#!/usr/bin/env bash

set -e

DIR=`dirname $0`

$DIR/assets.sh
$DIR/icons.sh
$DIR/json.sh
$DIR/localization.sh
$DIR/packages.sh
$DIR/format.sh

flutter format lib/