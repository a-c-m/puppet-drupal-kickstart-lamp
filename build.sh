#!/bin/bash

IP=$1

ssh root@$IP 'apt-get -y install git puppet'
ssh root@$IP 'mkdir /var/build'
ssh root@$IP 'cd /tmp/; git clone https://github.com/a-c-m/puppet-drupal-lamp.git /var/build'
ssh root@$IP 'cd /var/build; ./run-me-first.sh;'
ssh root@$IP 'puppet apply /var/build/manifests/2gb-lamp.pp --modulepath=/var/build/modules'

ssh root@$IP 'wget -O - http://download.newrelic.com/548C16BF.gpg | apt-key add -'
ssh root@$IP 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list'

ssh root@$IP 'apt-get update -y'
ssh root@$IP 'apt-get install newrelic-php5 newrelic-sysmond -y'
ssh root@$IP 'cp /etc/newrelic/newrelic.cfg.template /etc/newrelic/newrelic.cfg'

ssh root@$IP 'rm -rf /var/www/'
ssh root@$IP 'cd /tmp; wget http://ftp.drupal.org/files/projects/commerce_kickstart-7.x-2.4-core.tar.gz; tar -xvf commerce_kickstart-7.x-2.4-core.tar.gz; mv commerce_kickstart-7.x-2.4 /var/www;'
ssh root@$IP 'cd /var/www; drush site-install commerce_kickstart --db-url=mysql://drupal:ChangeMelikeRIGHTNOW@localhost/drupal --site-name=DrupalCampLondon2013 -y'
ssh root@$IP 'cd /var/www; drush dl blazemeter -y; drush en blazemeter -y;'
ssh root@$IP 'chmod 777 /var/www/sites/default/files -R'
