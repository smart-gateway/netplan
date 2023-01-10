# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include netplan::install
class netplan::install {

  # Ensure the /etc/netplan directory exists
  file { '/etc/netplan':
    ensure => directory,
  }

  # Disable cloud-init network configuration if disable flag is set
  if $::netplan::disable_cloud_init {
    file { 'netplan ensure /etc/cloud/cloud.cfg.d exists':
      ensure => directory,
      path   => '/etc/cloud/cloud.cfg.d/',
    }
    file { 'netplan ensure 99-disable-network-config.cfg exists':
      ensure  => file,
      path    => '/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg',
      content => 'network: {config: disabled}',
    }
  }

  # Purge any existing netplan config files is flag is set
  if $::netplan::purge_config {
    File['/etc/netplan'] {
      purge   => true,
      recurse => true,
      force   => true,
    }
  }
}
