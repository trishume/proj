require "pathname"

module Proj
  module Configuration
    DEFAULT = <<END_CONFIG
---
projects_file: ~/Dropbox/projects.yml
new_projects:
    folder:
      default: ~/misc
      aliases:
        webdev: ~/Development/Webdev
        work: ~/WorkDev
      ask: true
    description:
      default: ""
    github:
      default: false
      username: trishume
      aliases:
        Y: true
        N: false
END_CONFIG
    def self.copy_default()
      conf = Pathname.new("~/.projrc.yml").expand_path
      raise "Config file already exists" if conf.exists?
      File.open(conf.to_s, "w") do |file|
        file.write(DEFAULT.to_s)
      end
    end

    def self.load()
      conf = Pathname.new("~/.projrc.yml").expand_path
      if conf.exist?
        YAML.load_file(conf.to_s)
      else
        YAML.load(DEFAULT)
      end
    end
  end
end
