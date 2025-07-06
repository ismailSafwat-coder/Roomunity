FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl git unzip xz-utils zip libglu1-mesa openjdk-17-jdk

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Accept Android licenses (optional if using Android SDK)
RUN flutter doctor

# Pre-warm Flutter (optional but speeds up startup)
RUN flutter precache
