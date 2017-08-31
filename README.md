
# Sprinklr Aplicação Teste

Repositório Nodejs Oficial: https://github.com/nodejs/nodejs.org 

URL da Aplicação: http://nodejs.yros.com.br


### Usando com Docker

Requisitos: docker, docker-compose

Then open up a terminal on your machine and enter the following commands:

Build

```bash
docker build -t yros/sprinklr-application .
```

Running Application with Docker (NodeJS App)

```bash
docker -p 80:8080 yros/sprinklr-application
```

Running Application with Docker-compose (Nginx and Nodejs App)

```bash
docker-compose up
```

Open address http://localhost/en and enjoy !


### Cloud Architecture and Deployment

Toda a infraestrutura é codificada, todo o ambiente fica  no mesmo repositório da aplicação, qualquer alteração de ambiente é feita via deploy seguindo os processos agile/scrum, o versionamento da aplicação versiona o ambiente como um todo.

Arquitetura

![Cloud Architecture](https://github.com/yrosaguiar/sprinklr-application-beanstalk/blob/master/docs/cloud.png)


Serviços Utilizados:

- AWS (Cloud) - https://aws.amazon.com
- Github (Code Repository) - https://github.com
- Dockerhub (Container Register and Automated Build) - https://hub.docker.com
- CircleCI (Build, Test and Deploy) - https://circleci.com

Requisitos: 

- AWS Access Key e Secret Key com acesso completo ao Route53, Beanstalk, IAM, S3.

- Acesso Read/Write Repositório git da aplicação.

- Repositório Docker.

- Repostório adicionado ao Circle CI e configuração de variáveis de  ambiente no CircleCI.

O ambientes estão hospedado na AWS, ENDPOINT URL: http://nodejs.yros.com.br, toda a infraestrutura Cloud foi criada com o terraform.

### Terraform 

https://www.terraform.io/

Templates para criação dos ambientes. 

## Como utilizar?

O CI em que aplica estes templates

Os templates estão com um bucket S3 configurado para que o estado da infraestrutura seja salvo. Se o terraform for executado sem buscar esse estado ele cria um novo ambiente em vez de atualizar o existente. Isso provavelmente falhará pois o nome da aplicação está fixo e ele já existirá. 

As chaves da Amazon (access_key e secret_access_key) devem ser configuradas no arquivo `~/.aws/credentials`, utilize o comando `aws configure` para facilitar essa configuração.

Para executar basta iniciar o backend do terraform, é nesse passo que o terraform checa como está o ambiente verificando o arquivo de estado salvo do S3:

```shell
bash$ terraform init
```
É possível solicitar ao terraform montar o planejamento de suas mudanças com `terraform plan`.

Após analisar (ou se não planejar, pode-se executar diretamente) deve-se iniciar a construção/modificação do ambiente com `terraform apply`.

Arquivos do Terraform:

- terraform/production/backend.tf (Terraform State Bucket).

- terraform/production/main.tf (Default AWS Region and Terraform Variables).

- terraform/production/vpc.tf (VPC, Private Subnet, Public Subnet, route tables, nat gateways, internet gateways).

- terraform/production/beanstalk.tf (Instances, Autoscaling, ELB, Application Environemnt).

- terraform/production/route53.tf (Dns Register).

- terraform/production/sg.tf (Security Groups).

- terraform/production/iam.tf (IAM Roles and Policies).

Com o terraform podemos configurar diversas aplicações/serviços, exemplo: Newrelic, Logentries, Grafana,Azure,GCE,etc.

## Deployment 

Fluxo de Deploy

![Deploy Flow](https://github.com/yrosaguiar/sprinklr-application-beanstalk/blob/master/docs/deploy-flow.jpeg)

- O deploy em produção será feito sempre que houver alteração na branch master.

- O deploy em stage é feito sempre que houver alteração na branch stage.

- O CircleCI faz testes unitários, sobe a aplicação e faz um GET, pode ser integrado com ferramentas de teste automatizados (Selenium, Ghost Inspector, Postman para testar APIs).

- Após os testes é feito push da imagem do docker para o registry, e feito uma chamada para a API do Beanstalk solicitando o deploy da nova versão.

- O CircleCI é testa as alterações de infraestrutura com o terraform plan.

- O processo de deploy segue o procedimento rolling updates, na qual é feito deploy em metade das instâncias e testado o health da aplicação, caso seja bem sucedido é feito no restante das instâncias, em caso de falhas é feito o rollback para a versão anterior.


## AutoScaling

- Configuração de Scaling por uso de CPU, pode ser feita também com base em requisições na aplicação, uso de memória, mensagens na fila,etc. 



