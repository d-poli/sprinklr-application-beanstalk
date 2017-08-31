# Terraform templates

Templates para criação dos ambientes do beanstalk. 

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