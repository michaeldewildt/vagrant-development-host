# Basic Puppet Apache manifest


exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

Package { ensure => "installed" }

package { "varnish": }
package { "git": }

include apache2
include mysql
include php
