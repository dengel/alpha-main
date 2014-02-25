#!/usr/bin/env ruby
#

# System
require 'optparse'

# Local
$LOAD_PATH << './lib'
require 'NextProject.rb'

OptionParser.new do |o|
  o.on('-s') { |b| $setup = b }
  o.on('-g PROJECT') { |project| $git = project }
  o.on('-l LINKS') { |links| $links = links }
  o.on('-f FILENAME') { |filename| $filename = filename }
  o.on('-h') { puts o; exit }
  o.parse!
end

proj = NextProject.new()

if ( $setup )
	next_name = proj.next_project()
	puts "*** Project #{next_name}" 
	proj.set_value(next_name, proj.build_project(next_name));
	proj.update_file()
	proj.create_hierarchy(next_name)
	proj.create_control_info(next_name)
elsif ( $git )
	proj.create_scm($git)
elsif ( $links )
	proj.create_links($links)
end
