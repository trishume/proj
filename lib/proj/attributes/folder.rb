require "proj/attributes/attribute"

module Proj
  module Attributes
    class Folder < Attribute
      # The key to use in the YAML files
      def self.name
        'folder'
      end
      # The question to ask when set interactively
      def self.question
        "Project folder path" 
      end
      # The type of the attribute.
      # :string, :bool, :hash or :array
      def self.type
        :string
      end
    end
  end
end
