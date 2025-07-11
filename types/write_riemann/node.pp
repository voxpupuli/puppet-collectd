type Collectd::Write_riemann::Node = Struct[{
    name                 => String[1],
    host                 => Optional[String[1]],
    port                 => Optional[Integer],
    protocol             => Optional[Enum['TCP', 'TLS', 'UDP']],
    tls_cert_file        => Optional[String[1]],
    tls_ca_file          => Optional[String[1]],
    tls_key_file         => Optional[String[1]],
    batch                => Optional[Boolean],
    batch_max_size       => Optional[Integer],
    batch_flush_timeout  => Optional[Integer],
    store_rates          => Optional[Boolean],
    always_append_ds     => Optional[Boolean],
    ttl_factor           => Optional[Float],
    notifications        => Optional[Boolean],
    check_thresholds     => Optional[Boolean],
    event_service_prefix => Optional[String[1]],
}]
