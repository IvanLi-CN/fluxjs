FROM node:16-alpine as base
WORKDIR /app
COPY package.json ./
RUN npm i --no-audit
COPY . .

FROM node:16-alpine as release
WORKDIR /app
COPY --from=base /app ./
RUN npm run build &&\
  npm prune --omit dev
EXPOSE 80
CMD npm run start -- --port 80