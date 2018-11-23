# Stage 1
# FROM node:10
# WORKDIR /app
# COPY . ./
# RUN npm install
# RUN npm run build

# Stage 2
FROM nginx:alpine
COPY /dist /usr/share/nginx/html/
EXPOSE 8080
CMD [“nginx”, “-g”, “daemon off;”]