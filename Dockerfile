FROM node:26-alpine AS build

WORKDIR /app

COPY package*.json ./ 

RUN npm install

COPY . . 

RUN npm run build 

FROM nginx:alpine 

RUN adduser -D -u 1010 lokesh

COPY --chown=lokesh:lokesh nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html 
 
USER lokesh

EXPOSE 8080

CMD ["nginx", "-g", "daemon-off;"]
