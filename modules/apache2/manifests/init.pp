# Basic Puppet Apache manifest

class apache2 {

  Package { ensure => "installed" }

  package { "apache2": }
  package { "apache2.2-common": } 

  service { "apache2":
    ensure => running,
    enable => true,
    require => Package["apache2"],
  }

}

