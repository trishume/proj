require "grit"

module Proj
  class GitManager
    def initialize(config,library,asker)
      @config = config
      @library = library
      @asker = asker
    end
    #def commit_and_sync(project)
      #r = repository(project)
    #end
    def repository(project)
      Grit::Repo.new(project.folder)
    end
  end
end
