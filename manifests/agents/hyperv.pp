class neutron_hyper_v::agents::hyperv (
  $enabled                              = true,
  $ensure_package                       = 'present',
  $hyperv_service_user                  = 'LocalSystem',
  $hyperv_service_pass                  = '',

  $enable_metrics_collection            = false,
  $local_network_vswitch                = 'private',
  $metrics_max_retries                  = '100',
  $physical_network_vswitch_mappings    = undef,
  $polling_interval                     = '2',
  $force_hyperv_utils_v1                = false,
) {

  include neutron_hyper_v::params

  neutron_hyper_v::generic_service { 'hyperv-agent':
    enabled        => $enabled,
    package_name   => $::neutron_hyper_v::params::hyperv_agent_package_name,
    service_name   => $::neutron_hyper_v::params::hyperv_agent_service_name,
    ensure_package => $ensure_package,
    hyperv_service_user   => $hyperv_service_user,
    hyperv_service_pass   => $hyperv_service_pass,
  }

  hyperv_neutron_config {
    'AGENT/enable_metrics_collection':                  value => $enable_metrics_collection;
    'AGENT/local_network_vswitch':                      value => $local_network_vswitch;
    'AGENT/metrics_max_retries':                        value => $metrics_max_retries;
    'AGENT/physical_network_vswitch_mappings':          value => $physical_network_vswitch_mappings;
    'AGENT/polling_interval':                           value => $polling_interval;
    'hyperv/force_hyperv_utils_v1':                     value => $force_hyperv_utils_v1;
  }

}
