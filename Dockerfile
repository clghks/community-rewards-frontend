FROM node:8 as build-stage

MAINTAINER chihwan "clghks@gmail.com"

# 라이브러리 업데이트
RUN apt-get update

WORKDIR /usr/src/app

# git 설치
RUN apt-get install -y git

RUN apt-get install build-essential

# Community-rewards 코드 받기
RUN git clone https://github.com/JAVACAFE-STUDY/chainity-web.git
WORKDIR /usr/src/app/chainity-web

RUN npm install
RUN npm run webpack:prod

# production stage
FROM nginx:1.14.2 as production-stage
COPY --from=build-stage /usr/src/app/chainity-web/build/www /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]