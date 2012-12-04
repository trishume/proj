require 'proj/attributes/folder'
require 'proj/attributes/github'
require 'proj/attributes/description'

module Proj
  module Attributes
    @@attributes = {
      "folder" => Folder,
      "description" => Description,
      "github" => Github
    }
    def self.register_attribute(klass)
      @@attributes[klass.name] = klass
    end
    def self.attribute_handler(name)
      @@attributes[name]
    end
    def self.registered
      @@attributes
    end
  end
end
