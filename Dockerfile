FROM node:16.11.1-bullseye-slim

WORKDIR /home

COPY package* ./
RUN npm install

COPY index.js server.js db.json ./
EXPOSE 8080
CMD ["npm",  "start"]
