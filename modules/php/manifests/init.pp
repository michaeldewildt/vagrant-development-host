# Basic Puppet PHP manifest

class php {

  Package { ensure => "installed" }

  package { 'php-apc': }
  package { "php5-cli": }
  package { 'php5-fpm': }
  package { 'php5-imagick': }
  package { "php5-intl": }
  package { 'php5-mcrypt': }
  package { 'php5-memcached': }
  package { 'php5-mongo': }
  package { "php5-mysql": } 
  package { 'php5-sqlite': }
  package { "php5-xdebug": }
  
  service { 'php5-fpm':
    ensure     => running,
    enable     => true,
  }  

  file { "/etc/php5/fpm/php.ini":
    source => 'puppet:///modules/php/php.ini',
  }

  exec { 'reload_php5-fpm':
    command     => '/usr/sbin/service php5-fpm reload',
    require => Service['php5-fpm']
  }
  
  Package <| |> -> File["/etc/php5/fpm/php.ini"] -> Exec['reload_php5-fpm']
}