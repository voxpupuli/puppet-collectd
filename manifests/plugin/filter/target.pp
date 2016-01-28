# https://collectd.org/wiki/index.php/Chains
define collectd::plugin::filter::target (
  $chain,
  $plugin,
  $options = undef,
  $rule    = undef,
) {
  include ::collectd::params
  include ::collectd::plugin::filter

  unless $plugin in ['return','stop','write', 'jump'] or $plugin in $collectd::plugin::filter::plugin_targets {
    fail("Unknown rule plugin '${plugin}' provided")
  }

  # Load plugins
  if $plugin in $collectd::plugin::filter::plugin_targets {
    $order = 30
    ensure_resource('collectd::plugin', "target_${plugin}", {'order' => '02'} )
  } else {
    # Built in plugins
    $order = 50
  }

  if $rule {
    # create target in rule
    $fragment_order = "10_${rule}_${order}_${title}"
  } else {
    # create target after rules in chain
    $fragment_order = "20_${order}_${title}"
  }

  $conf_file = "${collectd::params::plugin_conf_dir}/filter-chain-${chain}.conf"

  concat::fragment{ "${conf_file}_${fragment_order}":
    order   => $fragment_order,
    content => template('collectd/plugin/filter/target.erb'),
    target  => $conf_file,
  }

}
