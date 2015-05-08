#
class neutron_hyper_v::params {

  if ($::osfamily == 'windows') {

    $hyperv_agent_package_name = undef
    $hyperv_agent_service_name = 'neutron-hyperv-agent'

    $confdir                   = 'C:/OpenStack/etc/neutron/neutron.conf'

    $log_dir                    = 'C:/OpenStack/log'
    $state_path                = 'C:/OpenStack/lib'
    $lock_path                 = 'C:/OpenStack/lib/lock'

  } else {

    fail("Unsupported osfamily ${::osfamily}")

  }
}
