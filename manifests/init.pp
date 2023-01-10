# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include netplan
class netplan (
  Boolean $package_manage = true,
  Boolean $purge_config = false,
  Boolean $disable_cloud_init = false,
  Boolean $netplan_apply = true,
  Hash    $netplan_configs = {},
){
    # Ensure class declares subordinate classes
  contain netplan::install
  contain netplan::config
  contain netplan::service

  # Order operations
  if $package_manage {
    anchor { '::netplan::begin': }
    -> Class['::netplan::install']
    -> Class['::netplan::config']
    -> Class['::netplan::service']
    -> anchor { '::netplan::end': }
  }
}
