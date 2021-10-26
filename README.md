### Bootcamp Data Science
#### Resumo
Projeto do [Bootcamp de Data Science](https://bootcampdatascience.com/inscricao/) da [Stack Tecnologias](https://www.linkedin.com/company/stack-tecnologias/?originalSubdomain=br) que possui as seguintes etapas:

- Coletar registros de um banco de dados MySQL e arquivos JSON e CSV (dentro de um bucket do Min.IO) usando o Apache Airflow
- Através das DAG's do Apache Airflow, mesclar os dados e disponibiliza-los através de um arquivo Joblib.
- Consultar o arquivo Joblib através do Jupyer notebook e testar modelos usando Pycaret e o Scikit-learn.
- Criar um modelo e disponibiza-lo através de uma aplicação usando o streamlit.
- Todos os serviços com exceção da aplicação executados dentro de containers.



#### Diretório dos arquivos

- ***/airflow*** : DAG's do Apache Airflow.
- ***/app*** : Código da aplicação
- ***/datalake*** : Localização dos arquivos armazenados no Min.IO
- ***/material*** : Arquivos para serem usados no bootcamp.


#### Executar a aplicação (Ambiente Linux):

- Executar o arquivo iniciar_containers.sh (cria os container ou os inicia caso já existam).
- Editar nas variáveis do Airflow os IP's do Min.IO e do Mysql caso tenha mudado.
- Instalar localmente na máquina o streamlit através do seguinte comando: `pip3 install minio pickle-mixin joblib matplotlib pycaret`
- Executar a aplicação via streamlit através da instrução: `streamlit run app/app.py`