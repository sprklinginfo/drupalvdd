#!/bin/bash

VDD_IP=$(echo "$1")

echo "============================================================="
echo "Install finished! Visit http://$VDD_IP in your browser." 
echo "============================================================="

# installing drupal 7
vagrantpath="/home/vagrant/sites"
d7path="/var/www/drupal7"
d8path="/var/www/drupal8"
version="drupal7"
echo "Installing $version ..."
pushd $vagrantpath
sudo rm -rf drupal7
drush dl drupal-7 --drupal-project-rename="drupal7"
#git clone --branch 8.0.x http://git.drupal.org/project/drupal.git .
drush @drupal7 si standard -y
pushd $vagrantpath/$version
drush dl ctools views devel admin_menu module_filter jquery_update backup_migrate -y
drush dis toolbar overlay -y
drush en ctools views devel admin_menu module_filter jquery_update backup_migrate -y
drush cc all
drush cron

echo "============================================================="
echo "Install finished! Visit http://$VDD_IP in your browser." 
echo "MySQL (also applies to PhpMyAdmin) user: root password: root"
echo "Drupal 7 admin user: root admin password: root database: drupal7 url: drupal7.dev drush alias: drupal7"
echo "Drupal 8 admin user: root admin password: root database: drupal8 url: drupal8.dev drush alias: drupal8"
echo "============================================================="
