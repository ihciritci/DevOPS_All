FROM node:15.5.1-alpine as app-build
WORKDIR /fe/app
COPY . ./
RUN yarn install --network-timeout 1000000
RUN yarn build

FROM nginx:alpine
RUN apk update && apk add curl jq
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=app-build /fe/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
