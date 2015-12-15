include collectd

collectd::plugin::mysql::database { 'puppetdb':
  host     => 'localhost',
  username => 'stahmna',
  password => 'yermom',
  port     => '3306',
}
