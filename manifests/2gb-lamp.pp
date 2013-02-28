# Basic LAMP stack box, expecting 2GB ram and not HUGE db requirements

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

include git
include drush

######################################
## WEBSERVER
######################################
class {'apache': }
class {'apache::mod::php': }
a2mod { "Enable rewrite mod":
  name    => "rewrite",
  ensure  => "present"
}
package {
  'php5-gd':
    ensure => 'present';
  'php-apc':
    ensure => 'present';
  'php5-mysql':
    ensure => 'present';
  'php5-curl':
    ensure => 'present';
}

## Standard /var/www default site
apache::vhost { $ipaddress:
  priority        => '1',
  port            => 80,
  docroot         => '/var/www',
  serveraliases   => ['127.0.0.1'],
  options         => 'FollowSymLinks',
  override        => ['all']
}

######################################
## DB
######################################
include mysql::server
class { 'mysql': }

## Basic database for Drupal to use
mysql::db { 'drupal':
  user     => 'drupal',
  password => 'ChangeMelikeRIGHTNOW',
  host     => 'localhost',
  grant    => ['all'],
}

