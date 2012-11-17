require "proj/attributes/registry"

module Proj
  # The configurator manages asking questions
  # about how to configure a project. The result
  # is the hash that goes in the projects.yml file.
  class Configurator
    attr_accessor :config
    # config is a Hash of attribute names to
    # configurations. Found under the new_projects
    # key in projrc.yml. See the README section 
    # on creating a new project.
    def initialize(config)
      @config = config
    end
    def questions
      questions = {}
      @config.each do |attr,conf|
        next if conf["ask"] == false
        handler = Proj::Attributes::attribute_handler(attr)
        next if handler.nil?
        opts = question_options(handler.type,
                                conf['default'])
        questions[attr] = "#{handler.question} #{opts}"
      end
      questions
    end

    # creates a new project given the answers
    # to the questions. The answers are a hash of
    # attribute to an answer string or nil for default.
    def create(answers)
      project = {}
      answers.each do |attr,answer|
        handler = Proj::Attributes::attribute_handler(attr)
        val = answer_value(answer,handler)
        project[attr] = val
      end
      project
    end

    protected
    def answer_value(answer,handler)
      return @config[handler.name]['default'] if answer.nil?
      # check aliases
      val = alias_expand(answer,handler.name)
      return val if val
      # parse
      parse_answer(answer,handler.type)
    end
    def alias_expand(answer,attr)
      aliases = @config[attr]['aliases']
      aliases and aliases[answer]
    end
    def parse_answer(answer,type)
      case type
      when :bool
        answer == "N" ? false : true
      when :string
        answer
      when :array
        answer.split(/, ?/)
      when :integer
        answer.to_i
      when :hash
        raise "Attributes of this type must be answered with an alias"
      end
    end
    def question_options(type,default)
      opts = type == :bool ? "Y/N " : ''
      defs = default.to_s.length < 30 ? default.to_s : "default"
      "[#{opts}blank for #{defs}]"
    end
  end
end
