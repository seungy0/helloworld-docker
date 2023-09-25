FROM node:20-alpine AS base

WORKDIR /build

COPY package.json .
RUN npm install
COPY . .

FROM node:20-alpine
WORKDIR /app
COPY --from=base /build/node_modules ./node_modules
COPY --from=base /build/app.js ./app.js
COPY --from=base /build/package.json ./package.json
EXPOSE 3000

CMD ["npm", "start"]