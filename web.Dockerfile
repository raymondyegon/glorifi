FROM nginx:stable

ARG ENVIRONMENT_ID=DEV
ENV ENVIRONMENT_ID=${ENVIRONMENT_ID}

WORKDIR /app

RUN apt-get update -y
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH "${PATH}:/usr/local/flutter/bin"

# Configure Flutter
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter doctor -v

# Install app
COPY . .

RUN flutter pub get

# TODO: Move this back to entrypoint.sh so we can
# build a generic image without ENV baked in
RUN echo "Building in ${ENVIRONMENT_ID} environment"
RUN flutter build web --release --dart-define=ENVIRONMENT=${ENVIRONMENT_ID}
RUN chmod -R 755 /usr/share/nginx/html
RUN cp -r /app/build/web/* /usr/share/nginx/html

# Nginx configs
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
# RUN chmod +x /app/entrypoint.sh

EXPOSE 80
# ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
