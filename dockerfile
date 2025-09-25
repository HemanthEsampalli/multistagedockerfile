FROM node:latest AS build
ARG TASK=dev
COPY sample-react/ /hemanth/
WORKDIR /hemanth
RUN npm install && \
    npm run build

FROM nginx  
ENV PORT=8080
COPY --from=build /hemanth/build /usr/share/nginx/html
RUN useradd -m test
#USER test
EXPOSE 80
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]