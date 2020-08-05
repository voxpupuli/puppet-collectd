# https://collectd.org/wiki/index.php/Chains
define collectd::plugin::filter::match (
  String $chain,
  String $rule,
  Collectd::Filter::Match $plugin,
  Optional[Hash] $options = undef,
) {
  include collectd
  include collectd::plugin::filter

  ensure_resource('collectd::plugin', "match_${plugin}", { 'order' => '02' })

  $fragment_order = "10_${rule}_1_${title}"
  $conf_file = "${collectd::plugin_conf_dir}/filter-chain-${chain}.conf"

  concat::fragment { "${conf_file}_${fragment_order}":
    order   => $fragment_order,
    content => template('collectd/plugin/filter/match.erb'),
    target  => $conf_file,
  }
}
