FROM node:latest AS build
ARG TASK=dev
ADD sample-react /hemanth
WORKDIR /hemanth
RUN npm install && \
    npm run build

FROM nginx AS run
ENV workspace=dev
COPY --from=build /hemanth/build /usr/share/nginx/html
RUN useradd -m test
#USER test
EXPOSE 80
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]