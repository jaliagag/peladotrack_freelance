# !bin/bash
# LEMP server - Linux (e)Nginx MySQL PHP

apt-get update -y
apt-get install nginx -y

# wait 400

# NGINX server up and running - try IP
# cd /etc/nginx
  # sites-available: creamos config para los distintos sitios - creamos los virtual hosts.
    # cd sites-avilable
    # cp default <siteName> ; could be domain name
    # vi <siteName> - look for "server_name: _" and replace the "_" for your domain name
    # root tells NGINX where would the default files be. "root /var/www/<name>"
    # these files need to be created
    # ONLY ONE SITE CAN HAVE OPTION listen 80 default_server - delete default_server
  # sites-enabled
    # links simbólicos - ln -s ../sites-avaiable/<name>

nginx -s reload

# /etc/hosts - checking locally: add to the file IP domain-name

# PHP - phpfpm

apt-get isntall php-fpm -y

# vi /etc/nginx/sites-enabled/<siteName>
# locate php section uncomment 
  # location ~ \.php$ {
    #include snippets/fastcgi-php.conf;
    #EITHER socket
    # MAKE SURE THE SOCK PATH IS THE SAME AS THE PHP VERSION 7.0? 7.2? WHEN STARTED THE SERVICE, CHECK NGINX ERROR LOG
	# fastcgi_pass unix:/var/run/php... .sock;
    # OR tcp connection
	# fastcgi_pass ... :9000
  # }
# uncomment Apache file lines
  # location ~/\.ht {
  # deny all;
  # }

nginx -t # check nginx conf files to see if there are syntax erros
systemctl reload nginx
# create a file on root folder 
#touch /var/www/<folder>/info.php
#vi /var/www/<folder>/info.php
# add 
#<?php
#phpinfo();
#?>
# check nginx log tail /var/log/nginx/error.log
# MySQL
apt-get install mysql-server php-mysql -y
# php-myadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.zip
apt-get install unzip -y
mv <phpmyadmindirname> <newnametoURL>
# en el archivo de configuración agregar index.php después del primer index
# input password: 
mysqladmin --user=root password "xxx"
# esto no nos va a permitir entrar a phpmyadmin como root - pero sí por consola
# ingresamos a mysql
mysql -u root -p # la password que creamos arriba
CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY 'pelado';
GRANT ALL PRIVILEGES ON *.* TO 'pelado'@'localhost' WITH GRANT OPTION;
# certbot
apt-get install certbot python3-certbot-nginx
certbot --nginx
# mail
# opciones
# generar cert
certbot renew --dry-run
