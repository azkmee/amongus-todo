FROM node

WORKDIR /home

COPY package* ./
RUN npm install

COPY index.js server.js db.json
EXPOSE 8080
CMD ["npm",  "start"]