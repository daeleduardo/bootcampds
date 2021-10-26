#!/bin/bash
echo -e "\e[104m\e[37m\e[1mDesligando containers ...\e[0m"
docker stop airflow minio mysqlbd1


