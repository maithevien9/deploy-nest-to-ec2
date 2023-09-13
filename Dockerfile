# Build stage

FROM node:18-alpine AS Build

WORKDIR /urs/src/app

COPY package*.json ./

RUN yarn install

COPY . .

RUN yarn Build

# prod stage

WORKDIR /urs/src/app

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

COPY --from=Build /urs/src/app/dist ./dist

COPY package*.json ./

RUN yarn install --only=production

RUN rm package*.json

EXPOSE 3000

CMD ['node', 'dist/main.js']