# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include netplan::config
class netplan::config {

  # Setup the notify if netplan is setup to be applied
  $notify = $::netplan::netplan_apply ? {
    true    => Exec['netplan_try'],
    default => undef,
  }

  # Create netplan configuration files
  $::netplan::netplan_configs.each | $filename, $config | {
    file { "create netplan config ${filename}":
      ensure  => file,
      path    => "/etc/netplan/${filename}",
      content => to_yaml($config),
      notify  => $notify,
    }
  }

}
