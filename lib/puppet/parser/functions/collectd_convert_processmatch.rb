Puppet::Parser::Functions.newfunction(:collectd_convert_processmatch, :type => :rvalue, :arity => 1, :doc => <<-ENDDOC
    Converts the array from the old style to define process matches in the
    processes plugin into a create_resources compatible hash which
    can be used with the new style define.

    Example:
      [ { 'name' => 'foo', 'regex' => '.*' } , { 'name' => 'bar', 'regex' => '[0-9]+' } ]
    will be converted to
      { 'foo' => { 'regex' => '.*' } , 'bar' => { 'regex' => '[0-9]+' } }
    ENDDOC
                                     ) do |args|
  if args.size != 1
    fail(Puppet::ParseError, 'convert_process_match_array(): Needs exactly one argument')
  end

  parray = args[0]
  unless parray.is_a?(Array)
    fail(Puppet::ParseError, 'convert_process_match_array(): Needs an array as argument')
  end

  phash = {}

  parray.each do |p|
    phash[p['name']] = { 'regex' => p['regex'] }
  end

  return phash
end
