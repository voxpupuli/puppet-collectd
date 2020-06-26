# https://collectd.org/wiki/index.php/Chains
define collectd::plugin::filter::rule (
  String $chain,
) {
  include collectd
  include collectd::plugin::filter

  $fragment_order = "10_${title}"
  $conf_file = "${collectd::plugin_conf_dir}/filter-chain-${chain}.conf"

  concat::fragment { "${conf_file}_${fragment_order}_0":
    order   => "${fragment_order}_0",
    content => "  <Rule \"${title}\">",
    target  => $conf_file,
  }

  concat::fragment { "${conf_file}_${fragment_order}_99":
    order   => "${fragment_order}_99",
    content => '  </Rule>',
    target  => $conf_file,
  }
}
