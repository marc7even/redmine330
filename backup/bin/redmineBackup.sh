/usr/bin/mysqldump -u redmine -ppassword redmine > /var/www/backup/db/redmine_`date +%y_%m_%d`.sql
rsync -a /var/www/html/redmine-3.3.0/files /var/www/backup
