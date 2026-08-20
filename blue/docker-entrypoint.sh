#!/bin/sh
set -eu

: "${HOSTNAME:=No definido}"
: "${KUBERNETES_SERVICE_HOST:=No definido}"
: "${BLUE_GREEN_APP_SVC_SERVICE_HOST:=No definido}"
export HOSTNAME KUBERNETES_SERVICE_HOST BLUE_GREEN_APP_SVC_SERVICE_HOST

envsubst '${HOSTNAME} ${KUBERNETES_SERVICE_HOST} ${BLUE_GREEN_APP_SVC_SERVICE_HOST}' \
    < /usr/share/nginx/html/index.html \
    > /usr/share/nginx/html/index.rendered.html
mv /usr/share/nginx/html/index.rendered.html /usr/share/nginx/html/index.html