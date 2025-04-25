FROM ubuntu:20.04

# Install MySQL
RUN apt-get update && apt-get install -y mysql-server

# Install phpMyAdmin
RUN apt-get install -y apache2 php libapache2-mod-php php-mysql
RUN apt-get install -y phpmyadmin

# Configure phpMyAdmin
RUN (echo "mysql admin mysql root localhost" | debconf-set-selections) && \
    (echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections) && \
    (echo "phpmyadmin phpmyadmin/app-password-confirm password password" | debconf-set-selections) && \
    (echo "phpmyadmin phpmyadmin/mysql/admin-pass password password" | debconf-set-selections) && \
    (echo "phpmyadmin phpmyadmin/mysql/app-pass password password" | debconf-set-selections) && \
    (echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections)

# Expose ports
EXPOSE 3306 80

# Start services
CMD ["bash", "-c", "service mysql start && service apache2 start && tail -f /dev/null"]