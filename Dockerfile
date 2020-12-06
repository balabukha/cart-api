FROM node:12 AS base

# Set default directory
WORKDIR /app

# Dependencies
FROM base AS dependecies
COPY package*.json ./
RUN npm install && npm cache clean --force

# Build
FROM dependecies as build
WORKDIR /app
COPY /src ./src
RUN npm run build

# Application
FROM node:12-alpine
WORKDIR /app
COPY --from=dependecies /app/package*.json ./
RUN npm ci --production && npm cache clean --force
COPY --from=build /app/dist ./dist

# Set port to 6000
EXPOSE 6000
ENV PORT=6000

# Run builded app
CMD ["node", "dist/main.js"]
