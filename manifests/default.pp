# Basic Puppet Apache manifest

class lamp {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  Package { ensure => "installed" }

  package { "apache2": }
  package { "apache2.2-common": } 
  package { "mysql-server": }
  package { "php5-mysql": } 

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

  file { '/var/www':
    ensure => link,
    target => "/vagrant",
    notify => Service['apache2'],
    force  => true
  }
}

class php54 {
    package { 
	"php5": ensure => pesent,
    }
}

class git {
    package {
        "git": ensure => present,
    }
}

include lamp
include php54
include git
