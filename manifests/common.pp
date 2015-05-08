class neutron_hyper_v::common (
  $ensure_package = 'present',
) {
  case $::osfamily {
    'windows': {

      /*
      file { 'C:/OpenStack':
        ensure => directory,
      }

      file { 'C:/OpenStack/scripts':
        ensure => directory,
        require => File['C:/OpenStack'],
      }

      file { 'C:/OpenStack/lib':
        ensure => directory,
        require => File['C:/OpenStack'],
      }

      file { 'C:/OpenStack/Services':
        ensure => directory,
        require => File['C:/OpenStack'],
      }

      file { 'C:/OpenStack/etc':
        ensure => directory,
        require => File['C:/OpenStack'],
      }

      file { 'C:/OpenStack/Log':
         ensure => directory,
         require => File['C:/OpenStack'],
      }
      */

      file { 'C:/OpenStack/etc/neutron':
        ensure => directory,
        require => File['C:/OpenStack/etc'],
      }

    }
    default: {
/*
      package { 'neutron-common':
        ensure  => $ensure_package,
        name    => $::neutron::params::common_package_name,
      }
*/
    }
  }
}
