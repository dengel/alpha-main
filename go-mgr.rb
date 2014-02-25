#!/usr/bin/env ruby

# System
require 'optparse'

# Local
$LOAD_PATH << './lib'
require 'NextProject.rb'

# CLI Stuff
OptionParser.new do |o|
    o.on('-s', 'Setup next available project') { |b| $setup = b }
    o.on('-g PROJECT', 'Clone GIT projects') { |project| $git = project }
    o.on('-l LINKS', 'Generate project links') { |links| $links = links }
    o.on('-h', 'This help right here') { puts o; exit }
    o.parse!
end

# Instanciate the new project
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
else
    puts "Unknown command please see -h"
end
