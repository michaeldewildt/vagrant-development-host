# Basic Puppet PHP manifest

class php {

  Package { ensure => "installed" }

  package { "php5-cli": }
  package { "php5-mysql": } 
  package { "php5-xdebug": }
  package { "php5-intl": }
  package { 'php5-sqlite': }
  package { 'php5-memcached': }
  package { 'php5-mcrypt': }
  package { 'php5-imagick': }
  package { 'php-apc': }
  package { 'php5-fpm': }

   #TODO: remove file!  
   #file { "/home/local.example.com/index.php":
   #  ensure => present,
   #  source => "puppet:///modules/php/index.php"
   #}
  

}

