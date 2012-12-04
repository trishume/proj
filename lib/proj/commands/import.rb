require "proj/commands/command"
require "proj/configurator"
require "pathname"

module Proj
  module Commands
    class Import < Command
      def run(relative_path,defaults = false)
        path = Pathname.new(relative_path)
        path = path.expand_path
        raise "#{path} is not a folder so it cannot be imported." unless path.directory?
        unless (path + ".git").exist?
          raise "#{path} is not a git repo so it cannot be imported." 
        end
        configurator = Proj::Configurator.new(get_config('new_projects'))
        # read the folder from the given path
        answers = {'folder' => path.parent.to_s}
        answers = ask_questions(configurator.questions(true),answers) unless defaults
        attributes = configurator.create(answers,asker)
        project = Proj::Project.new(path.basename.to_s,attributes)
        # Add the new project to the library
        @library.add_project(project)
        # Write out the updated project filetype
        save_projects!
      end
    end
  end
end
