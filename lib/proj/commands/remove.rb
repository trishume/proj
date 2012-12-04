require "proj/commands/command"
require "proj/configurator"

module Proj
  module Commands
    class Remove < Command
      def run(name)
        raise "Project #{name} is not managed by proj" unless @library.get(name)
        puts <<-NOTICE
Note: this does not delete the project or its repositories, it simply stops proj from managing it.
        NOTICE
        confirm = ask("Are you sure you wan't to stop proj managing project #{name} [Y/n]? ")
        if confirm == "Y"
          puts "Removing #{name} from projects.yml"
          @library.remove_project(name)
          save_projects!
        end
      end
    end
  end
end
