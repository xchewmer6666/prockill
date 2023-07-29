#!/usr/bin/ruby

require 'optparse'

puts '''
                            __   _ ____
     ____  _________  _____/ /__(_) / /
    / __ \/ ___/ __ \/ ___/ //_/ / / / 
   / /_/ / /  / /_/ / /__/ ,< / / / /  
  / .___/_/   \____/\___/_/|_/_/_/_/   
 /_/       
                 written by xchewmer
'''

puts

options = {}
OptionParser.new do |opt|
  opt.on('--name NAME') { |o| options[:name] = o }
end.parse!

if !options[:name]
  puts "[!] please enter a valid value or regex"
  exit
end

out = `ps aux | grep #{options[:name]} > test.txt`

File.open("./test.txt", "r") do |f|
  f.each_line do |line|
    pid = line.split(' ')[1]
    begin
      if !(line.include? "ruby" or line.include? "grep")
        puts "[+] killing pid #{pid}"
        out = `sudo kill -9 #{line.split(' ')[1]} > kill.txt`
      end
    rescue
      puts "[!] error on killing #{pid}"
    end
    puts
  end
end
