FROM nginx:stable-alpine

COPY ./default.conf /etc/nginx/conf.d/default.conf

RUN apk --no-cache add curl

WORKDIR /var/www
