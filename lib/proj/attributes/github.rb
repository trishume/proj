require "proj/attributes/attribute"

module Proj
  module Attributes
    class Github < Attribute
      # The key to use in the YAML files
      def self.name
        "github"
      end
      # The question to ask when set interactively
      def self.question
        "Create a Github repo" 
      end
      # The type of the attribute.
      # :string, :bool, :hash or :array
      def self.type
        :bool
      end
    end
  end
end
