exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }
package { "sqlite": }
package { 'memcached': }

  
file {  "/etc/nginx/sites-enabled/default":
  ensure => absent,
  notify  => Exec['reload_nginx'],
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
  before => File["/etc/nginx/sites-enabled/default"],
}

file { "/etc/nginx/sites-available/local.example2.com":
  content => template("nginx/lithium.erb"),
  before => File['/etc/nginx/sites-enabled/default'],
}

file { "/etc/nginx/sites-enabled/local.example.com":
  ensure => link,
  target => "/etc/nginx/sites-available/local.example.com",
  before => File['/etc/nginx/sites-enabled/default'],
}

file { "/etc/nginx/sites-enabled/local.example2.com":
  ensure => link,
  target => "/etc/nginx/sites-available/local.example2.com",
  before => File['/etc/nginx/sites-enabled/default'],
}


include mysql
include php
include locale
include nginx
include mongodb

exec {
  'reload_nginx':
  command     => '/usr/sbin/service nginx reload',
  refreshonly => true,
  require => Service['nginx']
}

Exec["apt-get update"] -> Package <| |>