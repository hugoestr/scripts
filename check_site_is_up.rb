#!/usr/bin/ruby env

require 'rubygems'
require 'nokogiri'
require 'net/smtp'

# Site Checker
# Checks that the site is running. If not, it will send and email


def site_down?()
 result = false
 doc = Nokogiri::HTML("http://www.mysite.com")
 links = doc.css 'a'
 links.each  do |link|
   if link.content =~ "Link's content that exist on the site"
     result = true
   end
 end
 result
end

def send_mail()
  from =  ""

  to =  []

  Net::SMTP.start('localhost', 25) do |smtp|
    smtp.open_message_stream(from, to) do |f|
      f.puts "From: #{from}"
      f.puts "To: #{to.join ','}"
      f.puts "Subject: The site has been down since at least #{Time.now}"
      f.puts ""
      f.puts "A problem with the site"
    end
    smtp.finish
  end

end

def check_size(file)
  limit = 50000000
  size = File.size file

  if size > limit
    File.delete file
  end
end

def log(message)
  file_name = "checker_log.txt"
  check_size file_name
  file = File.new(file_name, "a")
  file.puts message
end

#main script
if site_down? then
  send_mail
  log "Site is down. Failure at #{Time.now}"
else
  log "Ran successfully on #{Time.now}"
end

