#!/usr/bin/env bash

sudo apt-get update

sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/apache2
sudo add-apt-repository -y ppa:ondrej/php5

sudo apt-get update

sudo apt-get install -y wget php5 apache2

sudo apt-add-repository ppa:ondrej/mysql-5.6
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password rootpass'
sudo apt-get update
sudo apt-get -y install mysql-server-5.6 mysql-client-5.6 php5-mysql

sudo apt-get -y install php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-common php-pear php5-dev php5-xsl
# Apache stuff
sudo php5enmod mcrypt
sudo a2enmod rewrite

rm -rf /var/www/html
ln -fs /vagrant /var/www/html

sudo service apache2 restart

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

chown -R www-data /var/www/html
find /var/www/html -type d -exec chmod 700 {} \;
find /var/www/html -type f -exec chmod 600 {} \;
