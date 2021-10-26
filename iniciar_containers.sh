#!/bin/bash
LINESTOTAL=$(wc -l < $0)
#Em http:localhost:8080


#Clique em Admin >> Variables

#Crie as seguintes variáveis:

#*data_lake_server = 172.17.0.4:9000 (usar docker container inspect para verificar IP do minio)* 
#*data_lake_login = minioadmin*
#*data_lake_password = minioadmin*

#*database_server = 172.17.0.3 ( Use o comando inspect para descobrir o ip do container: docker container inspect mysqlbd1 - localizar o atributo IPAddress)*
#*database_login = root*
#*database_password = bootcamp*
#*database_name = employees*

LINESTOTAL=$(wc -l < $0)

result=$( docker ps -a | grep mysqlbd1 )

if [[ -n "$result" ]]; then
  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Iniciando container mysqlbd1...\e[0m"
  docker start mysqlbd1
else
  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Criando container mysqlbd1...\e[0m"
  docker run --name mysqlbd1 -e MYSQL_ROOT_PASSWORD=bootcamp -p "3307:3306" -d mysql
fi

result=$( docker ps -a | grep minio )

if [[ -n "$result" ]]; then
  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Iniciando container minio...\e[0m"
  docker start minio
else
  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Criando container minio...\e[0m"
  docker run -d -e MINIO_ROOT_USER=minioadmin -e MINIO_ROOT_PASSWORD=minioadmin --name minio -p 9000:9000 -p 9001:9001 -v "$PWD/datalake:/data" minio/minio server /data --console-address ":9001"
fi


result=$( docker ps -a | grep airflow )

if [[ -n "$result" ]]; then
  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Iniciando container airflow...\e[0m"
  docker start airflow
else
  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Criando container airflow...\e[0m"
  docker run -d -p 8080:8080 -v "$PWD/airflow/dags:/opt/airflow/dags/" --entrypoint=/bin/bash --name airflow apache/airflow:2.1.1-python3.8 -c '(airflow db init && airflow users create --username admin --password bootcamp --firstname Felipe --lastname Lastname --role Admin --email admin@example.org); airflow webserver & airflow scheduler'

  sleep 5

  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Instalando pacotes pip no container airflow...\e[0m"
  docker exec  airflow pip install pymysql xlrd openpyxl minio

fi

#result=$( docker ps -a | grep streamlit )

#if [[ -n "$result" ]]; then
#  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Iniciando container streamlit...\e[0m"
#  docker start streamlit
#else
#  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Criando container streamlit...\e[0m"
#  docker run -d --name streamlit -p "8501:8501" -v "$PWD/app:/app" tomerlevi/streamlit-docker /app/app.py
#  echo -e "\e[104m\e[37m\e[1m$(((LINENO *100)/LINESTOTAL))% Instalando pacotes pip no container streamlit...\e[0m"
#  docker exec streamlit pip3 install minio pickle-mixin joblib matplotlib pycaret
#  docker exec streamlit apt install libgomp1 
#fi


