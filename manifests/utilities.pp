class neutron_hyper_v::utilities {
  include neutron_hyper_v::params

  if $::osfamily == 'windows' {
    # class {'windows_git': }
  }
}
