#!/usr/bin/env bash
mkdir /etc/systemd/system/apt-daily.timer.d
cp /vagrant/apt-daily.timer.conf /etc/systemd/system/apt-daily.timer.d/apt-daily.timer.conf
apt-get update
apt-get install -y apache2 ruby mysql-client libapache2-mod-passenger ruby-dev libmysqlclient-dev libmagickcore-dev libmagickwand-dev imagemagick
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
echo mysql-server mysql-server/root_password password root | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password root | sudo debconf-set-selections
apt-get install -y mysql-server
cat /var/www/redmineDb.sql | mysql -u root -proot
wget -P /var/www/html http://www.redmine.org/releases/redmine-3.3.0.tar.gz
tar -xvzf /var/www/html/redmine-3.3.0.tar.gz --directory /var/www/html
gem install bundler
cp /var/www/database.yml /var/www/html/redmine-3.3.0/config
bundle install --gemfile=/var/www/html/redmine-3.3.0/Gemfile --without development test postgresql sqlite
rake --rakefile /var/www/html/redmine-3.3.0/Rakefile generate_secret_token
rake --rakefile /var/www/html/redmine-3.3.0/Rakefile db:migrate RAILS_ENV=production
cp /var/www/apache2.conf /etc/apache2
a2dissite 000-default
cp -R /var/www/circle /var/www/html/redmine-3.3.0/public/themes
cp -R /var/www/redmine_custom_help_url /var/www/html/redmine-3.3.0/plugins
service apache2 reload
