module Proj
  module Attributes
    class Attribute
      # The key to use in the YAML files
      def self.name
        raise "Name not set"
      end
      # The question to ask when set interactively
      def self.question
        "Value for #{yaml_name}" 
      end
      # The type of the attribute.
      # :string, :bool, :hash or :array
      def self.type
        :string
      end
    end
  end
end
