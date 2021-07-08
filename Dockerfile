FROM node:12 AS builder
# RUN sudo apt-get install -y sqlite3 libsqlite3-dev
WORKDIR /app
COPY package*.json ./
RUN yarn install

FROM node:12
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY . .
# RUN /usr/bin/sqlite3 /VILLSHIP.sqlite
RUN yarn global add pm2
CMD ["pm2-runtime", "server.js"]
