# Basic Puppet redis manifest

class redis-server {

  Package { ensure => "installed" }
  
  package { 'redis-server': }

  service { 'redis-server':
    ensure     => running,
    enable     => true,
    require => Package['redis-server'],
  }
}