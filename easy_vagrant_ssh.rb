# The script will run vagrant up and create a file that will execute
# the right

require 'open3'

def get_input()
  command = "vagrant ssh"
  stdin, stdout, stderr = Open3.popen3 command
  result = stderr.readlines
end
  
def gather_values(input)
  result = {}
  input.each do |line|

     words = line.split ": "

     if words.first =~ /^Host/
       result[:host] = words[1].chomp
     end
     
     if words.first =~ /^Port/
       result[:port] = words[1].chomp
     end
     
     if words.first =~ /^Username/
       result[:username] = words[1].chomp
     end
     
     if words.first =~ /^Private key/
       result[:private_key] = words[1].chomp
     end
  end
  result
end

def create_command(values)
  result = "ssh #{values[:username]}@#{values[:host]} -p #{values[:port]} -i #{values[:private_key]}"
end

def create_file(command)
  file = File.open "vagrant_ssh1", "w"
  file << command
end

def run_script()
  input = get_input
  values = gather_values input
  create_file create_command(values)
end

run_script
