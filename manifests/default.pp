exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }
package { "sqlite": }
package { 'memcached': }
package { 'curl': }
package { 'mc': }
package { 'htop': }
package { 'screen': }

file { "/home/capifony":
    ensure => "directory",
    owner  => "vagrant",
    group  => "vagrant",
}

file {  "/etc/nginx/sites-enabled/default":
  ensure => absent,
  notify  => Exec['reload_nginx'],
}

nginx::vhost { 'wpb2d':
    framework => 'symfony2-dev',
}

include mysql
include php
include locale
include nginx

exec {
  'reload_nginx':
  command     => '/usr/sbin/service nginx reload',
  refreshonly => true,
  require => Service['nginx']
}

Exec["apt-get update"] -> Package <| |>

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }
file { '/etc/motd':
   content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet.\n"
}

