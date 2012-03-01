projects = {
  "egis_pivot" => 'C:\SVN\pivot\PivotJitServer.sln',
  "terrain_pivot" => 'C:\pivot\PivotJitServer.sln',
  "egis" => 'C:\SVN\ArraMVC.sln',
  "terrain" => 'C:\SVN\TerraSite.sln',
}

key = ARGV[0]
if key != nil && projects[key] != nil
command = "start devenv.exe #{projects[key]}"
  puts command
  system command
else
  puts " project >#{key}< not found."
end
