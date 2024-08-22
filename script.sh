#!/bin/bash

# Metadata labels
LABEL_KEY="value"
MAINTAINER="Doreen Onyango"
MAINTAINER="Khalid Hussein"
MAINTAINER="Tomlee Abila"
VERSION="1.0"
DESCRIPTION="This is a program that generates ASCII art based on a given string and banner style specified. The program uses a web interface that is appealing, intuitive and user friendly to displays the results.The application container built with Docker."

# Build the Docker image
docker build -t dockerize . \
  --label "key=$LABEL_KEY" \
  --label "maintainer=$MAINTAINER" \
  --label "version=$VERSION" \
  --label "description=$DESCRIPTION"

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker image built successfully."
else
  echo "Failed to build Docker image."
  exit 1
fi

# Run the Docker container
docker run -p 8080:8080 dockerize
