# Docker XAMPP

Este projeto contém um Dockerfile para criar uma imagem Docker com o XAMPP instalado. O XAMPP é uma distribuição Apache fácil de instalar que contém MariaDB, PHP e Perl.

## Pré-requisitos

Antes de começar, você precisará ter o Docker instalado em sua máquina. Para instalar o Docker, siga as instruções no [site oficial do Docker](https://docs.docker.com/get-docker/).

## Construção da Imagem

Para construir a imagem Docker com o XAMPP, clone este repositório e execute o seguinte comando no diretório raiz:

```bash
docker build -t xampp_docker .
```

Este comando construirá uma imagem Docker chamada xampp_docker com base no Dockerfile presente no repositório.

## Executando o Container
Após a construção da imagem, você pode iniciar um container usando:

```bash
docker run -d -p 80:80 -p 443:443 -p 3306:3306 xampp_docker
```

Isso iniciará um container Docker com o XAMPP e mapeará as portas 80, 443 e 3306 para as mesmas portas na sua máquina host.

## Acessando os Serviços
Após iniciar o container, você pode acessar os serviços do XAMPP através do seu navegador:

Apache: http://localhost/
phpMyAdmin: http://localhost/phpmyadmin/
Configurações Personalizadas
O Dockerfile inclui configurações para permitir o acesso aos serviços do XAMPP de qualquer IP. Isso é feito modificando as configurações de segurança no arquivo httpd-xampp.conf.

## Contribuições
Contribuições para o projeto são bem-vindas. Sinta-se à vontade para criar um fork e enviar um pull request com suas melhorias.

## Licença
Este projeto está sob a licença [MIT](https://chat.openai.com/c/LICENSE).
