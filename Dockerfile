FROM nginx-1.17.2-alpine
RUN openssl dhparam -out dhparams.pem 4096
COPY configs/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80