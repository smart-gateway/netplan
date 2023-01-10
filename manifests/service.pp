# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include netplan::service
class netplan::service {

  # TODO: Add code to check configuration and make sure it is good.
  # TODO: Add code to output the problems somewhere the admin/user can debug it if there are problems

  # Apply configurations
  exec { 'netplan_try':
    command     => '/usr/sbin/netplan try --timeout 1',
    logoutput   => 'on_failure',
    refreshonly => true,
  }
}
