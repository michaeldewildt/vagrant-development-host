# Basic Puppet Apache manifest


exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }

file { "/home/example.com":
    ensure => "directory",
}

class { 'apache': }
apache::vhost { 'local.example.com':
    priority        => '10',
    vhost_name      => '192.0.2.1',
    port            => '80',
    docroot         => '/home/example.com/docroot/',
    logroot         => '/home/example.com/logroot/',
    serveradmin     => 'webmaster@example.com',
    serveraliases   => ['example.com',],
}

include mysql
include php
