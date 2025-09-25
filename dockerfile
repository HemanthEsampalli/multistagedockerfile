FROM node:latest AS build
ADD TASK=prod
COPY sample-react/ /hemanth/
WORKDIR /hemanth
RUN npm install && \
    npm run build

FROM nginx  
ENV PORT=8080
COPY --from=build /hemanth/build /usr/share/nginx/html
RUN useradd -m test
#USER test
EXPOSE $PORT/tcp
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]