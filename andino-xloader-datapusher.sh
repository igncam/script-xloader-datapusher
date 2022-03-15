#!/bin/sh
cd /etc/portal
#TODO - crear variables 
# dbuser = 
# dbpassowrd =

#Habilar xloader
docker-compose -f latest.yml exec portal /etc/ckan_init.d/datastore_loaders/enable_ckanext_xloader.sh probandodb test1234

#Subir todos los recursos xloader
docker-compose -f latest.yml exec portal /usr/lib/ckan/default/bin/paster --plugin=ckanext-xloader xloader submit all -c /etc/ckan/default/production.ini

#Restablecer datapusher
docker-compose -f latest.yml exec portal /etc/ckan_init.d/datastore_loaders/enable_datapusher.sh

#Subir todos los recursos datapusher
docker-compose -f latest.yml exec portal /usr/lib/ckan/default/bin/paster --plugin=ckan datapusher submit_all -y -c /etc/ckan/default/production.ini 
