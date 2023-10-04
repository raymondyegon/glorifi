#!/bin/sh -eu

echo "RUNNING Flutter app with ENVIRONMENT_ID=${ENVIRONMENT_ID}"
flutter build web --release --dart-define=ENVIRONMENT=${ENVIRONMENT_ID}

chmod -R 755 /usr/share/nginx/html
cp -r /app/build/web/* /usr/share/nginx/html

nginx -g "daemon off;"
