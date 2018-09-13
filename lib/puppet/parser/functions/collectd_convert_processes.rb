Puppet::Parser::Functions.newfunction(:collectd_convert_processes, type: :rvalue, arity: 1, doc: <<-ENDDOC
    Converts the array from the old style to define process or processmatch in the
    processes plugin into a create_resources compatible hash which
    can be used with the new style define.

    Example:
      [ { 'name' => 'foo', 'regex' => '.*' } , { 'name' => 'bar', 'regex' => '[0-9]+' },  "alone" ]
    will be converted to
      { 'foo' => { 'regex' => '.*' } , 'bar' => { 'regex' => '[0-9]+' }, 'alone' => {} }
    ENDDOC
                                     ) do |args|
  if args.size != 1
    raise(Puppet::ParseError, 'convert_process_array(): Needs exactly one argument')
  end

  if args[0].is_a?(Hash)
    return args[0] # Keep normal hiera hash as-is
  end

  parray = args[0]
  unless parray.is_a?(Array)
    raise(Puppet::ParseError, 'convert_process_array(): Needs an array as argument')
  end

  phash = {}

  parray.each do |p|
    if p.is_a?(String)
      phash[p] = {}
    elsif p.is_a?(Hash)
      name = p.delete('name')
      phash[name] = p
    else
      raise(Puppet::ParseError, 'convert_process_array(): array element must be string or hash')
    end
  end
  return phash
end
