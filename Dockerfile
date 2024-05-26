# Use Node.js version 18 with the Alpine Linux distribution
FROM node:18-alpine

ARG N8N_VERSION=1.42.1

# Install necessary packages
RUN apk add --update graphicsmagick tzdata

# Switch to root user
USER root

# Install build dependencies, n8n, and then clean up
RUN apk --update add --virtual build-dependencies python3 build-base && \
    npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
    apk del build-dependencies

# Set the working directory
WORKDIR /data

# Expose the port
EXPOSE $PORT

# Set environment variables
ENV N8N_USER_ID=root

# Command to run n8n
CMD export N8N_PORT=$PORT && n8n start
