require "proj/commands/command"
require "proj/configurator"

module Proj
  module Commands
    class Create < Command
      def run(name,defaults = false)
        configurator = Proj::Configurator.new(get_config('new_projects'))
        answers = ask_questions(configurator.questions)
        attributes = configurator.create(answers,asker)
        project = Proj::Project.new(name,attributes)
        # Run the actual side effecting operations like
        # creating folders and repositories.
        creator = Proj::Creator.new(@config)
        creator.create(project,asker)
        # Add the new project to the library
        @library.add_project(project)
        # Write out the updated project filetype
        save_projects!
      end
    end
  end
end
