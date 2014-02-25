#!/usr/bin/env ruby
#
require 'FileUtils'
require 'yaml'

class NextProject

  #BASEDIR = "~/Dropbox/go"
  BASEDIR = "/tmp/go"

	# Load project config file
	def initialize()
		@config_file="projects.yml"
		@config = YAML.load_file(@config_file)
	end

	# find available project
	def next_project()
		config = @config
		ret = "none"
		config.each do |key, array|
			ret=key
			break if (config[key] == false)
		end
		return ret
	end

	# set configuration option
	def set_value(key, val)
		@config[key] = val
	end

	def update_file()
		File.open(@config_file, 'w') {|f| f.write @config.to_yaml }
	end

  # Create the project definition TODO: Use ERB
  def build_project(go)
    content = {
      "active" => true,
      "path" => BASEDIR + "/#{go}"
    }
    return content
  end

  def create_hierarchy(go)
    go_path= BASEDIR + "/" + go
    path_list = Array[ "#{go_path}",
      "#{go_path}/documents",
      "#{go_path}/invoices",
      "#{go_path}/source",
      "#{go_path}/meta"
    ]
    path_list.each do |p|
      puts "> Creating: #{p}"
      FileUtils.mkdir_p(p) unless File.exists?(p)
    end
  end

  def create_control_info(go)
    path= BASEDIR + "/" + go + "/meta/client.yml"
    puts "> Creating: #{path}"
    records = {
      "name" => "Acme",
      "project" => "TBD",
      "rate" => "TBD",
      "codename" => "TBD",
      "realname" => "TBD",
      "status" => "NEW",
    }
    File.open(path, 'w') {|f| f.write records.to_yaml }

    path= BASEDIR + "/" + go + "/meta/control.yml"
    puts "> Creating: #{path}"
    records = {
      "status" => "NEW",
      "type" => "TBD",
      "penflip" => "TBD",
      "github" => [ false ],
    }
    File.open(path, 'w') {|f| f.write records.to_yaml }

    path= BASEDIR + "/" + go + "/meta/links.yml"
    puts "> Creating: #{path}"
    records = {
      "category1" => { 
        "link1" => "http://localhost/1",
        "link2" => "http://localhost/2",
       },
      "category2" => { 
        "link3" => "http://localhost/3",
        "link4" => "http://localhost/4",
       },
    }
    File.open(path, 'w') {|f| f.write records.to_yaml }

  end

end
