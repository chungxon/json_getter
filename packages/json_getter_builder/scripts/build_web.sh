#!/bin/bash
set -e

# Build
flutter pub get
flutter build web --release --base-href '/json_getter/'

# Zip build web folder
cd build/web
zip -r build.zip .

# Move to root folder
cd ../..
mv build/web/build.zip ../..

echo "Build Web Done !!!"