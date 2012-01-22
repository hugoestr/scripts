services = ['Apache2.2', 'MySQL']

services.each do |service|
 command = "net start #{service}"
 system command
end
