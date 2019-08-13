FROM node:8 as build-stage

MAINTAINER chihwan "clghks@gmail.com"

# 라이브러리 업데이트
RUN apt-get update

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
RUN npm run webpack:prod

# production stage
FROM nginx:1.14.2 as production-stage
COPY --from=build-stage /usr/src/app/chainity-web/build/www /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
