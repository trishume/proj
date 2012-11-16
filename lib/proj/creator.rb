require "proj/attributes/registry"

module Proj
  # The creator is responsible for Creating
  # and setting up new projects. From the new_projects
  # attribute in the projrc file.
  class Creator
    attr_accessor :config
    # config is a Hash of attribute names to
    # configurations. Found under the new_projects
    # key in projrc.yml. See the README section 
    # on creating a new project.
    def initialize(config)
      @config = config
    end
    def questions
      questions = []
      @config.each do |attr,conf|
        next if conf["ask"] == false
        handler = Proj::Attributes::attribute_handler(attr)
        next if handler.nil?
        opts = question_options(handler.type,
                                conf['default'])
        questions << "#{handler.question} #{opts}"
      end
      questions
    end

    protected
    def question_options(type,default)
      opts = type == :bool ? "Y/N " : ''
      defs = default.to_s.length < 30 ? default.to_s : "default"
      "[#{opts}blank for #{defs}]"
    end
  end
end
