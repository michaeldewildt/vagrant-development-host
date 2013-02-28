# Basic Puppet MySQL manifest

class mysql {

  Package { ensure => "installed" }

  package { "mysql-server": }

  service { "mysql":
    ensure => "running",
    enable => "true",
    require => Package["mysql-server"],
  }

}

