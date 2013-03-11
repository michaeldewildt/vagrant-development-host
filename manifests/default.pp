# Basic Puppet Apache manifest


exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }
package { "sqlite": }
package { 'php5-sqlite': }
package { 'memcached': }
package { 'php5-memcached': }
package { 'php5-mcrypt': }
package { 'php5-imagick': }
package { 'php-apc': }

file { "/home/example.com":
    ensure => "directory",
}

class { 'apache': }
apache::vhost { 'local.example.com':
    priority        => '10',
    vhost_name      => '10.0.2.15',
    port            => '80',
    docroot         => '/home/example.com/docroot/',
    logroot         => '/home/example.com/logroot/',
    serveradmin     => 'webmaster@example.com',
    serveraliases   => ['example.com',],
}
class {'apache::mod::php': }

include mysql
include php
