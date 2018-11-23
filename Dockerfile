# Stage 1
# FROM node:10
# WORKDIR /app
# COPY . ./
# RUN npm install
# RUN npm run build

# Stage 2
FROM nginx
COPY dist /usr/share/nginx/html/
COPY start.sh  /usr/share/nginx/html/
RUN chmod -R 755 /usr/share/nginx/html/
ENTRYPOINT "/usr/share/nginx/html/start.sh" && /bin/bash
