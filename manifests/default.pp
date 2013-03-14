exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }
package { "sqlite": }
package { 'memcached': }
package { 'nginx': }

file { "/home/local.example.com":
    ensure => "directory",
}

file { "/etc/nginx/sites-available/local.example.com":
  content => template("nginx/local.example.com"),
}

file { "/etc/nginx/sites-enabled/local.example.com":
  ensure => link,
  target => "/etc/nginx/sites-available/local.example.com",
}

file { "/etc/nginx/sites-enabled/default": 
  ensure => absent 
}

include mysql
include php