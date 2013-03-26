# Basic Puppet MySQL manifest

class nginx {

  Package { ensure => "installed" }

  package { "nginx": }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    restart    => '/etc/init.d/nginx reload'
  }

  $is_local_deploy = 'false'

}

