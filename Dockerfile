FROM nginx:1.17.2-alpine
COPY configs/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80