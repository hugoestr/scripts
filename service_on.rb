#!/usr/bin/env ruby
services = {
  'apache' => 'Apache2.2',
  'mysql'  => 'MySQL',
  'postgres' => 'postgresql-8.4'
}

name = ARGV[0]

command = "net start #{services[name]}"
puts command
system command
