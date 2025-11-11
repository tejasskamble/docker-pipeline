# --- Stage 1: The Builder ---
# Use a full Node.js image to install dependencies
FROM node:18 AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the source code
COPY . .

# --- Stage 2: The Final Image ---
# Use a slim, alpine-based image for the smallest size
FROM node:18-alpine

WORKDIR /app

# --- Build Arguments ---
# These ARGs are passed in from the 'docker build' command
ARG BUILD_ID=unknown
ARG GIT_COMMIT=unknown

# --- Environment Variables ---
# Set ARGs as ENV so the running app can access them (optional)
ENV BUILD_ID=$BUILD_ID
ENV GIT_COMMIT=$GIT_COMMIT

# Copy the installed modules from the 'builder' stage
COPY --from=builder /app/node_modules ./node_modules

# Copy the application code
COPY server.js .

# Expose the port the app runs on
EXPOSE 3000

# Run the app
CMD [ "node", "server.js" ]
