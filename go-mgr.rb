#!/usr/bin/env ruby
#
$LOAD_PATH << './lib'
require 'NextProject.rb'

proj = NextProject.new()

next_name = proj.next_project()

puts "*** Project #{next_name}" 

proj.set_value(next_name, proj.build_project(next_name));

proj.update_file()

proj.create_hierarchy(next_name)

proj.create_control_info(next_name)
