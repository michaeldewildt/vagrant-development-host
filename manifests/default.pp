exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }
package { "sqlite": }
package { 'memcached': }

  
file {  "/etc/nginx/sites-available/default":
  ensure => absent,
  notify  => Service['nginx'],
} 

file { "/home/local.example2.com":
   ensure => directory,
   before => File ['/etc/nginx/sites-available/local.example2.com'],
   require => Package["nginx"],
}

file { "/home/local.example.com":
   ensure => directory,
   before => File ['/etc/nginx/sites-available/local.example.com'],
   require => Package["nginx"],
}

file { "/etc/nginx/sites-available/local.example.com":
  content => template("nginx/symfony2.erb"),
  notify  => Exec['restart_nginx'],
  before => File["/etc/nginx/sites-available/default"],
}

file { "/etc/nginx/sites-available/local.example2.com":
  content => template("nginx/lithium.erb"),
  notify  => Exec['restart_nginx'],
  before => File['/etc/nginx/sites-available/default'],
}

file { "/etc/nginx/sites-enabled/local.example.com":
  ensure => link,
  target => "/etc/nginx/sites-available/local.example.com",
}

include mysql
include php
include locale
include nginx

  exec {
    'restart_nginx':
      command     => '/usr/sbin/service nginx restart',
      refreshonly => true,
      require => Service['nginx']
  }

