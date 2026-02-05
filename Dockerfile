# 1. Base image: we don’t want to install nginx ourselves
FROM nginx:alpine
COPY . /usr/share/nginx/html

# 2. Copy our app into nginx’s web directory
COPY index.html /usr/share/nginx/html/index.html

# 3. Tell Docker this container listens on port 80
EXPOSE 80

