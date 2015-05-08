class neutron_hyper_v::dependencies (
) inherits neutron_hyper_v::params {

  /*
  class { 'windows_common::tools::python':
    python_package     => $python_package,
    python_source      => $python_installer,
    python_installdir  => $python_installdir,
    pip_source         => $pip_script,
  }

  package { 'pywin32':
    provider => pip,
    require  => Class['windows_common::tools::python'],
    notify   => Exec['pywin32-postinstall-script'],
  }

  exec { 'pywin32-postinstall-script':
    command     => "python.exe ${python_installdir}/Scripts/pywin32_postinstall.py -install",
    path        => $python_installdir,
    refreshonly => true,
  }
  */
}
