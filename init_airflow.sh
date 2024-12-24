#!/bin/bash
set -e

# Настройка переменных окружения
: "${AIRFLOW_ADMIN_USERNAME:=admin}"
: "${AIRFLOW_ADMIN_PASSWORD:=admin}"
: "${AIRFLOW_ADMIN_FIRSTNAME:=Admin}"
: "${AIRFLOW_ADMIN_LASTNAME:=User}"
: "${AIRFLOW_ADMIN_EMAIL:=admin@example.com}"
: "${CLICKHOUSE_HOST:=clickhouse}"
: "${CLICKHOUSE_PORT:=8123}"
: "${CLICKHOUSE_USER:=default}"
: "${CLICKHOUSE_PASSWORD:=}"
: "${CLICKHOUSE_SCHEMA:=default}"

# Инициализация базы данных Airflow
airflow db init

# Создание пользователя Airflow
airflow users create \
    --username "$AIRFLOW_ADMIN_USERNAME" \
    --password "$AIRFLOW_ADMIN_PASSWORD" \
    --firstname "$AIRFLOW_ADMIN_FIRSTNAME" \
    --lastname "$AIRFLOW_ADMIN_LASTNAME" \
    --role Admin \
    --email "$AIRFLOW_ADMIN_EMAIL"

# Добавление подключения к ClickHouse
airflow connections add 'clickhouse_default' \
    --conn-type 'clickhouse' \
    --conn-host "$CLICKHOUSE_HOST" \
    --conn-port "$CLICKHOUSE_PORT" \
    --conn-login "$CLICKHOUSE_USER" \
    --conn-password "$CLICKHOUSE_PASSWORD" \
    --conn-schema "$CLICKHOUSE_SCHEMA"

echo "Airflow инициализирован. Пользователь $AIRFLOW_ADMIN_USERNAME создан."
echo "Подключение ClickHouse настроено на $CLICKHOUSE_HOST:$CLICKHOUSE_PORT."
