# Basic Puppet Apache manifest

class apache2 {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  Package { ensure => "installed" }

  package { "apache2": }
  package { "apache2.2-common": } 
  package { "mysql-server": }
  package { "php5-mysql": } 
  package { "php5-xdebug": }
  package { "php5-intl": }
  package { "varnish": }

  service { "apache2":
    ensure => running,
    enable => true,
    require => Package["apache2"],
  }

  service { "mysql":
    ensure => "running",
    enable => "true",
    require => Package["mysql-server"],
  }

}

