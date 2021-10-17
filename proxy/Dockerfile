FROM nginx:latest
WORKDIR /etc/nginx
COPY ./cert.crt ./
COPY ./cert.key ./
COPY ./test_config.conf ./conf.d/default.conf
COPY ./index.html /www/data/
EXPOSE 443
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]