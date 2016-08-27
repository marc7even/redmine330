CREATE DATABASE redmine CHARACTER SET UTF8;
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
