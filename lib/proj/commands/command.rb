require "proj/library"

require "yaml"

module Proj
  module Commands
    class Command
      def initialize(asker)
        @config = Proj::Configuration.load
        @library = Proj::Library.new(@config)
        @library.load(load_projects())
        @asker = asker
      end

      protected

      def projects_file
        File.expand_path(@config['projects_file'])
      end

      def load_projects()
        file = projects_file
        if File.exists?(file)
          YAML.load_file(file)
        else
          {'projects'=>{}}
        end
      end

      def save_projects!
        File.open(projects_file,'w') do |f|
          f.puts @library.to_h.to_yaml
        end
      end

      def get_config(key)
        val = @config[key]
        raise "Config key #{key} must be set in the .projrc.yml file" unless val
        val
      end

      def asker
        #@asker ||= lambda {|quest,secret| ask("#{quest}: ") { |q| q.echo = !secret }}
        @asker
      end


      def ask_questions(questions,answers = {})
        questions.each do |attr,question|
          next if answers[attr]
          ans = ask("#{question}: ")
          answers[attr] = ans.empty? ? nil : ans.strip
        end
        answers
      end

    end
  end
end
