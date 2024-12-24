#!/bin/bash
set -e

# Настройка переменных окружения
: "${AIRFLOW_ADMIN_USERNAME:=admin}"
: "${AIRFLOW_ADMIN_PASSWORD:=admin}"
: "${AIRFLOW_ADMIN_FIRSTNAME:=Admin}"
: "${AIRFLOW_ADMIN_LASTNAME:=User}"
: "${AIRFLOW_ADMIN_EMAIL:=admin@example.com}"

# Инициализация базы данных Airflow
airflow db migrate

# Создание пользователя Airflow
airflow users create \
    --username "$AIRFLOW_ADMIN_USERNAME" \
    --password "$AIRFLOW_ADMIN_PASSWORD" \
    --firstname "$AIRFLOW_ADMIN_FIRSTNAME" \
    --lastname "$AIRFLOW_ADMIN_LASTNAME" \
    --role Admin \
    --email "$AIRFLOW_ADMIN_EMAIL"
