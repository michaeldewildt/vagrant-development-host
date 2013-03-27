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

  Package['acl'] -> File['/etc/fstab'] -> Exec['mount_o_and_remount_root']

}
