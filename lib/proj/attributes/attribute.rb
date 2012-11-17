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
      # :string, :bool, :hash, :array or :integer
      def self.type
        :string
      end

      # Transforms the entered value to its
      # final form. May ask additional questions
      # via the asker lambda with parameters
      # |question,passwordMode|
      #
      # config is the value for the plugin in The
      # projrc new_projects key.
      def self.transform_val(value,config,asker)
        value
      end
    end
  end
end
