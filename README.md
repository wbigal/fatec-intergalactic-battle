# Engenharia de Software III - FATEC-SP

## Setup

### Pré-requisitos

Para executar o projeto no seu ambiente de desenvolvemento você precisará atender os seguintes requisitos:

* Ter o RVM configurado e a versão 2.5.0 do Ruby já instalada
* Ter o bando de dados Postgres instalado

Será necessário ter o ambiente preparado para o Paperclip. Siga a instruções de pré-requisitos em https://github.com/thoughtbot/paperclip

### Configurar ambiente

Para configurar seu ambiente de desenvolvimento execute as seguintes instruções:

```bash
cp .env.sample .env
rake db:setup
```

Edite o arquivo `.env` com os valores correspondentes ao seu ambiente de desenvolvimento.

## Contribuindo

Utilize *FeatureBranch*. Crie um `branch` a partir do *branch* `master` para sua atividade, e ao final envie um `Pull Request` com as modificações.

### O que fazer para o código ser ceito

* Siga os padões de implementação do Ruby e do Ruby on Rails
* Utilize o Rspec para testar, o mínimo de cobertura é 97%
* Sempre execute o rubocop. Se tiver problemas o build falha
* Sempre execute o breakman. Se tiver problemas o build falha
* Sempre faça testes de interface em resolução de celular
* Se for criar uma relação entre duas tabelas, crie chave estrangeira
* Utilize constraint no banco de dados, não deixe tudo para o Rails
