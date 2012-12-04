require "proj/commands/command"
require "proj/configurator"

module Proj
  module Commands
    class Commit < Command
      def run(query)
        project = @library.fuzzy_search(query)
        repo = Grit::Repo.init(project.folder)
        # modified, added, un-tracked files
        repo.git.add(:A => true)
        repo.commit_index(asker.call("Commit message",false))

        # push to origin
        repo.git.push({},"origin","master")
      end
    end
  end
end
