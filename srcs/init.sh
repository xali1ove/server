service nginx start
service mysql start
service php7.3-fpm start

# Configure a wordpress database
mysql -u root -e "CREATE DATABASE gondor"
mysql -u root -e "CREATE USER 'sonofaratorn'@'localhost' IDENTIFIED BY 'pass'"
mysql -u root -e "GRANT ALL PRIVILEGES ON gondor.* TO 'aragon'@'localhost' IDENTIFIED BY 'pass'"
mysql -u root -e "FLUSH PRIVILEGES"

bash