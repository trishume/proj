require "proj/attributes/registry"
require "grit"
require "github_api"

module Proj
  class Creator
    def initialize(config)
      @config = config
    end
    def create(project,asker)
      path = File.expand_path(project['folder'] + '/' + project.name)
      # Create the project folder as a git repo
      repo = Grit::Repo.init(path)
      # Github repo creation
      if gh_config = project['github']
        pass = asker.call("Github password",true)
        github = Github.new login: gh_config['username'], 
          password:pass
        remote_repo = github.repos.create name: project.name
        # Add the git remote
        repo.remote_add("origin",remote_repo.ssh_url)
      end
    end
  end
end
