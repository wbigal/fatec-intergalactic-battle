
# Engenharia de Software III - FATEC-SP

[![Build Status](https://semaphoreci.com/api/v1/wbigal/fatec-intergalactic-battle/branches/master/badge.svg)](https://semaphoreci.com/wbigal/fatec-intergalactic-battle)

Jogo: https://fatec-intergalactic-battle.herokuapp.com

Backoffice: https://fatec-intergalactic-battle.herokuapp.com/admin

## Setup

Tanto com Docker quanto sem, no final um usuário administrador será criando no ambiente de desenvolvimento:

* Email: admin@fatecib.com.br
* Senha: 123@Mudar

A aplicação web subirá na porta `3000`, ficando então acessível através da url http://locahost:3000.

### Com Docker

Faça o setup do Docker: https://docs.docker.com/get-started/
Para facilitar, utilize o compose: https://docs.docker.com/compose/gettingstarted/

### Sem Docker

Para executar o projeto no seu ambiente de desenvolvimento você precisará atender os seguintes requisitos:

* Ter o RVM configurado e a versão 2.5.1 do Ruby já instalada
* Ter o bando de dados Postgres instalado
* Ter configurado o ImageMagic (https://www.imagemagick.org/script/download.php)

#### Configurar ambiente

Primeiro crie o arquivo com as variáveis de ambiente: `cp .env.sample .env`

Depois edit o arquivo `.env` com os dados do seu ambiente local.

Em seguida faça o setup do banco de dados: `rake db:setup`

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
