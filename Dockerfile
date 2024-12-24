FROM apache/airflow

# Установка необходимых инструментов и системных пакетов
USER root
RUN apt-get update && apt-get install -y curl python3-venv && apt-get clean

# Переключаемся на airflow
USER airflow

# Устанавливаем Poetry через официальный скрипт
RUN curl -sSL https://install.python-poetry.org | python3 -

# Добавляем Poetry в PATH
ENV PATH="/home/airflow/.local/bin:$PATH"

# Копируем файлы для Poetry
COPY pyproject.toml poetry.lock /opt/airflow/

# Переключаемся в директорию проекта
WORKDIR /opt/airflow

# Устанавливаем зависимости через Poetry
RUN poetry config virtualenvs.create false && poetry install --no-dev

# Копируем папки DAGs, плагинов и логов
COPY --chown=airflow:airflow dags /opt/airflow/dags
COPY --chown=airflow:airflow plugins /opt/airflow/plugins
COPY --chown=airflow:airflow logs /opt/airflow/logs

# Копируем скрипт и задаем права на выполнение
COPY --chown=airflow:airflow init_airflow.sh /opt/airflow/init_airflow.sh
RUN chmod +x /opt/airflow/init_airflow.sh
