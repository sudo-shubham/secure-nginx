# Secure Nginx
Nginx Docker image configured for security and performance.

## Docker Hub
- Available on Docker Hub at https://hub.docker.com/r/shubhampatel812/secure-nginx.
- You can pull this docker image using `docker pull shubhampatel812/secure-nginx`.

## Build Instructions:
- Clone this repository using `git clone https://github.com/sudo-shubham/secure-nginx`
- Change the directory using `cd secure-nginx`
- Change "SERVER_NAME"(line no. 11) variable in configs/nginx.h to Change the Server Name. (Optional)
- Change "NGINX_VERSION"(line no. 14) variable in configs/nginx.h to Change the Server Version. (Optional)
- Run `docker build . -t <image_name>`.

## Notes:
- Currently alpine:3.10.2 is used as base image.
