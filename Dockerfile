# 
## Setups node from node's official image
#
FROM node:alpine
EXPOSE 9902

WORKDIR /app

# Install the application
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY main.js main.js
#COPY config.yml config.yml
RUN npm install
CMD ["sh", "-c", "CONFIG_PATH=/app/config.yml node main.js"]
