#
type Collectd::Redis::Node = Struct[{Optional['host'] => String[1], Optional['port'] => Variant[Stdlib::Port, String[1]], Optional['password'] => String[1], Optional['timeout'] => Integer[0], Optional['queries'] => Hash[String[1], Hash[String[1], String[1]]]}]
