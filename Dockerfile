# Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# The "build" folder is created at the root of the project: /app/build

# Run Phase
# Everything from the previous phase is discarded
FROM nginx
# Copy destination comes from nginx docs
COPY --from=builder /app/build /usr/share/nginx/html
# Default startup command starts nginx, so we do not need to do it ourselves
