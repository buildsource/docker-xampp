# Use uma imagem base do Ubuntu
FROM ubuntu:latest

# Defina variáveis de ambiente
ENV XAMPP_HOME /opt/lampp
ENV PATH $PATH:$XAMPP_HOME/bin

# Atualize os pacotes e instale utilitários necessários
RUN apt-get update && apt-get install -y wget net-tools openssl

# Baixe e instale o XAMPP
RUN wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.12/xampp-linux-x64-8.2.12-0-installer.run \
    && chmod +x xampp-linux-x64-8.2.12-0-installer.run \
    && ./xampp-linux-x64-8.2.12-0-installer.run --mode unattended

# Crie um certificado SSL autoassinado
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout $XAMPP_HOME/etc/ssl.key/server.key \
    -out $XAMPP_HOME/etc/ssl.crt/server.crt \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

# Atualize a configuração do Apache para usar SSL
RUN sed -i 's|#Include etc/extra/httpd-ssl.conf|Include etc/extra/httpd-ssl.conf|' $XAMPP_HOME/etc/httpd.conf \
    && sed -i 's|SSLCertificateFile ".*"|SSLCertificateFile "'$XAMPP_HOME'/etc/ssl.crt/server.crt"|' $XAMPP_HOME/etc/extra/httpd-ssl.conf \
    && sed -i 's|SSLCertificateKeyFile ".*"|SSLCertificateKeyFile "'$XAMPP_HOME'/etc/ssl.key/server.key"|' $XAMPP_HOME/etc/extra/httpd-ssl.conf

# Modificar as configurações de segurança no httpd-xampp.conf
RUN sed -i '/<Directory "\/opt\/lampp\/phpmyadmin">/,/<\/Directory>/ s/Require local/Require all granted/' $XAMPP_HOME/etc/extra/httpd-xampp.conf \
    && sed -i '/<Directory "\/opt\/lampp\/htdocs\/xampp">/,/<\/Directory>/ s/Require local/Require all granted/' $XAMPP_HOME/etc/extra/httpd-xampp.conf

# Exponha as portas (Apache, MySQL)
EXPOSE 80 443 3306

# Copie o script de inicialização personalizado
COPY start-xampp.sh /usr/local/bin/start-xampp.sh
RUN chmod +x /usr/local/bin/start-xampp.sh

# Inicie o XAMPP usando o script personalizado
CMD ["/usr/local/bin/start-xampp.sh"]
