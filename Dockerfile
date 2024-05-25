# FROM node:18 as build

# WORKDIR /app
# COPY . .

# # Install Angular CLI globally
# RUN npm install -g @angular/cli@17.2.3

# RUN npm install --legacy-peer-deps
# RUN npm run build --prod

# FROM nginx:alpine
# COPY --from=build app/dist/browser /usr/share/nginx/html



#####################
# Stage 1: Build the Angular application
FROM node:18 as build

WORKDIR /app
COPY . .

# Install Angular CLI globally
RUN npm install -g @angular/cli@17.2.3

# Install dependencies with legacy-peer-deps
RUN npm install --legacy-peer-deps

# Build the Angular application
RUN npm run build --prod

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the build output to the Nginx html directory
COPY --from=build /app/dist/browser /usr/share/nginx/html

