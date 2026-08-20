FROM nginx:alpine

COPY . /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.d/40-render-env.sh
RUN chmod +x /docker-entrypoint.d/40-render-env.sh

EXPOSE 80
