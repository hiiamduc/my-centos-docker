#!/bin/sh

source /app/setup/.env

if [ -e "/app/setup/.env-prod" ]; then
  source /app/setup/.env-prod
fi

echo ">> Compile file docker-compose.yml"
# Replace placeholders
sed -e "s/{{ HOST }}/$HOST/g" \
    -e "s/{{ MYSQL_ROOT_PASSWORD }}/$MYSQL_ROOT_PASSWORD/g" \
    -e "s/{{ MYSQL_DATABASE }}/$MYSQL_DATABASE/g" \
    -e "s/{{ MYSQL_USER }}/$MYSQL_USER/g" \
    -e "s/{{ MYSQL_PASSWORD }}/$MYSQL_PASSWORD/g" \
    -e "s/{{ MYSQL_PORT }}/$MYSQL_PORT/g" \
    -e "s/{{ HTTP_PORT }}/$HTTP_PORT/g" \
    -e "s/{{ REDIS_PORT }}/$REDIS_PORT/g" \
    < /app/setup/docker-compose.yml.dist \
    > /app/setup/docker-compose.yml

echo ">> Run docker-compose"
cd /app/setup && /usr/local/bin/docker-compose -p r up -d
