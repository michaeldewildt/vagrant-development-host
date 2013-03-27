# ACL for linux file system with setings for deployment directories

class acl {

  Package { ensure => "installed" }

  package { "acl": }

  exec { 'mount_o_and_remount_root':
    command  => 'mount -o remount /',
    path => "/bin/",
  }

  file { "/etc/fstab":
    source => 'puppet:///modules/acl/fstab',
  }
  
  exec {
    'setfacl_r':
    command  => "setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX /home/capifony",
    path => '/bin/',
  }

  exec {
    'setfacl_rd':
    command  => "setfacl -dR -m u:www-data:rwx -m u:`whoami`:rwx /home/capifony",
    path => '/bin/',
  }
  
  Package['acl'] -> File['/etc/fstab'] -> Exec['mount_o_and_remount_root'] -> Exec['setfacl_r'] -> Exec['setfacl_rd']

  #sudo mount -o remount /home
  #mount | grep acl

}
