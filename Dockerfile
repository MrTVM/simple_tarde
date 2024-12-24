FROM apache/airflow:2.7.3

# Установка Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Добавляем Poetry в PATH
ENV PATH="$PATH:/root/.local/bin"

# Копируем файлы для Poetry
COPY pyproject.toml poetry.lock /opt/airflow/

# Устанавливаем зависимости через Poetry
RUN poetry config virtualenvs.create false && poetry install --no-dev

# Копируем DAGs, плагины и логи
COPY dags /opt/airflow/dags
COPY plugins /opt/airflow/plugins
COPY logs /opt/airflow/logs

# Копируем скрипт и задаем права на выполнение
COPY init_airflow.sh /opt/airflow/init_airflow.sh
RUN chmod +x /opt/airflow/init_airflow.sh
