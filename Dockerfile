FROM node:16-alpine as builder

WORKDIR /app

COPY . /app 

COPY package*.json ./

RUN npm install

RUN npm run build

FROM nginx:latest

COPY --from=builder /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]