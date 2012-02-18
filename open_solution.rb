projects = {
  "egis_pivot" => 'C:\SVN\ARRA\PivotServer\pivot\PivotJitServer.sln',
  "terrain_pivot" => 'C:\SVN\NRLTerrainRoot\pivot\PivotJitServer.sln',
  "egis" => 'C:\SVN\ARRA\_Codebase\ArraMVC\ArraMVC.sln',
  "terrain" => 'C:\SVN\NRLTerrainRoot\NRLTerrain\TerraSite.sln',
}

key = ARGV[0]
if key != nil && projects[key] != nil
command = "start devenv.exe #{projects[key]}"
  puts command
  system command
else
  puts " project >#{key}< not found."
end
