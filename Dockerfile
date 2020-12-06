FROM node:12-alpine

# Set default directory
WORKDIR cart_api/

# Copy package*.json files into WORKDIR directory and install dependencies
COPY package*.json ./
RUN npm install && npm cache clean --force

# Copy everything from host to docker and build app
COPY . .
RUN npm run build

# Set port to 7000
USER node
EXPOSE 6000
ENV PORT=6000

# Run builded app
CMD ["node", "dist/main.js"]
