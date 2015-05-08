# == Define: neutron::generic_service
#
# This defined type implements basic neutron services.
# It is introduced to attempt to consolidate
# common code.
#
# It also allows users to specify ad-hoc services
# as needed
#
# This define creates a service resource with title neutron-${name} and
# conditionally creates a package resource with title neutron-${name}
#
define neutron_hyper_v::generic_service(
  $package_name,
  $service_name,
  $enabled        = false,
  $ensure_package = 'present',
  $hyperv_service_user           = 'LocalSystem',
  $hyperv_service_pass           = '',
) {

  include neutron_hyper_v::params

  if $enabled {
    $service_ensure = 'running'
  } else {
    $service_ensure = 'stopped'
  }

  $fname = regsubst($name, '-', '', 'G')

  $neutron_title = "neutron-${name}"

  # ensure that the service is only started after
  # all neutron config entries have been set
  Exec['post-neutron_config'] ~> Service<| title == $neutron_title |>

  # I need to mark that ths package should be
  # installed before neutron_config
  if ($package_name) {
    package { $neutron_title:
      ensure => $ensure_package,
      name   => $package_name,
      notify => Service[$neutron_title],
      before => Service[$neutron_title],
    }
  }

  if($::osfamily == 'windows'){
    Package['neutron'] -> Service[$neutron_title]

    file { "C:/OpenStack/Services/Neutron${fname}Service.py":
      ensure             => file,
      #source_permissions => ignore,
      source             => "puppet:///modules/neutron_hyper_v/Neutron${fname}Service.py",
      require            => Class['neutron_hyper_v::common']
    }

    windows_common::tools::python::windows_service { $neutron_title:
      description          => "${neutron_title} service for Hyper-V",
      arguments            => '--config-file=C:\OpenStack\etc\neutron\neutron.conf',
      script               => "C:\\OpenStack\\services\\Neutron${fname}Service.Neutron${fname}Service",
      user                 => $hyperv_service_user,
      password             => $hyperv_service_pass,
      password_from_secret => true,
      require              => File["C:/OpenStack/Services/Neutron${fname}Service.py"],
      before               => Service[$neutron_title],
    }
  }

  if ($::osfamily != 'windows'){
    Package['neutron-common'] -> Service[$neutron_title]
  } else {
    Class['neutron_hyper_v::common'] -> Service[$neutron_title]
  }

  if ($service_name) {
    service { $neutron_title:
      ensure    => $service_ensure,
      name      => $service_name,
      enable    => $enabled,
      hasstatus => true,
    }
  }

}
