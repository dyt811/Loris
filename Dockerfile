FROM ubuntu:18.04

# Update APT-GET as root, install SUDO
RUN apt-get update && apt-get -y install sudo

# create LORISAdmin user, add to sudo list;
# Per https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container
RUN useradd -m lorisadmin && echo "lorisadmin:lorisadmin" | chpasswd && adduser lorisadmin sudo
# Creating user: This needs to be run with RUN useradd -ms
# RUN useradd -rm -d /home/lorisadmin -s /bin/bash -g root -G sudo -u 1000 lorisadmin

USER lorisadmin

# Assume Git is installed
RUN sudo apt-get install git

# Download entire Repo:
RUN git clone https://github.com/dyt811/Loris.git

# install dependencies:
RUN sudo apt-get update && sudo apt-get install -y mysql-client mysql-server
RUN sudo apt-get install -y zip curl wget software-properties-common
RUN sudo apt-add-repository ppa:ondrej/php
RUN sudo apt-get update && sudo apt-get install -y apache2
RUN sudo apt-get install -y php7.2 php7.2-mysql php7.2-xml php7.2-json php7.2-mbstring php7.2-gd, composer, libapache2-mod-php7.2, unzip, nodejs, npm
RUN sudo a2enmod php7.2
RUN sudo service apache2 restart

# apache, MySQL, PHP, Composer, NodeJS 8, NPM, make

USER lorisadmin

WORKDIR /var/www
RUN sudo wget https://github.com/aces/Loris/archive/v22.0.0.zip -O release.zip
RUN sudo unzip release.zip
RUN sudo mv Loris-22.0.0 LORIS
RUN sudo rm release.zip
RUN sudo chown -R lorisadmin.lorisadmin LORIS

RUN cd /var/www/LORIS/tools
# Must not run as root.
RUN ./install.sh
# Must run frm /var/www/LORIS/tools folder
# Must not exist: /var/www/LORIS/project/config.xml:
# Must be using Bash.
# Must not run as root.
# PHP must be installed.
# Make sure apache2 is not already configured for the $projectname
> project name
> lorisadmin password

RUN cd /var/www/LORIS/
RUN sudo make

RUN sudo a2enmod rewrite
RUN sudo a2dissite default
RUN sudo a2ensite $projectname
RUN sudo service apache2 reload
CMD /bin/bash
