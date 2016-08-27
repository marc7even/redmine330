cat $1 | mysql -u root -proot redmine
rsync -a /var/www/backup/files /var/www/html/redmine-3.3.0
