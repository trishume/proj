require "proj/commands/command"
require "proj/configurator"

module Proj
  module Commands
    class Dir < Command
      def run(query)
        proj = @library.fuzzy_search(query)
        puts proj.folder
      end
    end
  end
end
