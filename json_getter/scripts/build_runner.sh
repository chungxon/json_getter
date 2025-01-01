#!/bin/bash
set -e

flutter pub get
dart run build_runner build --delete-conflicting-outputs

echo "Build Data Done !!!"