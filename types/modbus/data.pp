# @summary represents a modbus data entry
type Collectd::Modbus::Data = Struct[{
    Optional['instance']      => String,
    NotUndef['type']          => String[1],
    NotUndef['register_base'] => Integer[0],
    NotUndef['register_type'] => Enum['Int16', 'Int32', 'Uint16', 'Uint32', 'Float'],
    Optional['register_cmd']  => Enum['ReadHolding', 'ReadInput'],
}]
