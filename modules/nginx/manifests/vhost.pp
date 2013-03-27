define nginx::vhost(
  $framework = $nginx::framework,
  $is_local_deploy = $nginx::is_local_deploy,
){

  include nginx
  
  if $is_local_deploy == 'false' {
    file { "/home/${name}":
       ensure => directory,
       before => File ["/etc/nginx/sites-available/${name}"],
       require => Package["nginx"],
    }
  } else {

    file { "/home/capifony/${name}":
       ensure => directory,
       before => File ["/etc/nginx/sites-available/${name}"],       
       require => Package["nginx"],
       owner  => "www-data",
       group  => "www-data",
    }

    file { "/home/${name}":
       ensure => link,
       before => File ["/etc/nginx/sites-available/${name}"],       
       require => Package["nginx"],
       target => "/home/capifony/${name}/current",
       owner  => "www-data",
       group  => "www-data",
    }
    #TODO: set permission on acl for  vagrant.vegrant
    #setfacl -m g:vagrant:rwx - adds new group 'vagrant' to root directory it enables deployment
#    exec {
#      'setfacl_r':
#      command  => "setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX /home/capifony/${name}",
#      path => '/bin/',
#      before => Exec['setfacl_rd']
#    }

#    exec {
#      'setfacl_rd':
#      command  => "setfacl -dR -m u:www-data:rwx -m u:`whoami`:rwx /home/capifony/${name}",
#      path => '/bin/',
#      before => File ["/etc/nginx/sites-available/${name}"]
#    }

    #File["/home/capifony/${name}"] -> 
    #Exec['mount_o_and_remount_root'] -> Exec['setfacl_r'] -> Exec['setfacl_rd']
  }
   
  file { "/etc/nginx/sites-available/${name}":
    content => template("nginx/${framework}.erb"),
    before => File["/etc/nginx/sites-enabled/default"],
  }
  
  file { "/etc/nginx/sites-enabled/${name}":
    ensure => link,
    target => "/etc/nginx/sites-available/${name}",
    before => File['/etc/nginx/sites-enabled/default'],
  }  
}
