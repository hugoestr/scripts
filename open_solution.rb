#!/usr/bin/env ruby
require File.expand_path(File.dirname(__FILE__) + '/projects')

key = ARGV[0]
if key != nil && Projects[key] != nil
command = "start devenv.exe #{Projects[key]}"
  puts command
  system command
else
  puts " project >#{key}< not found."
end
