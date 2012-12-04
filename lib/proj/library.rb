require "proj/project"
require "fuzzy_match"

module Proj
  class Library
    attr_accessor :config,:projects
    def initialize(config,projects = [])
      @config = config
      @projects = projects
    end
    def add_project(proj)
      @projects << proj
    end
    def remove_project(name)
      @projects.delete_if {|p| p.name == name}
    end
    def get(name)
      @projects.find {|p| p.name == name}
    end
    def load(projects_file)
      projects_file['projects'].each do |name,attrs|
        @projects << Project.new(name,attrs)
      end
    end
    def to_h()
      hash = {}
      @projects.each do |p|
        hash[p.name] = p.attributes
      end
      {'projects' => hash}
    end
    def find_by_folder(relative_path)
      path = File.expand_path(relative_path)
      @projects.find {|p| p.folder == path }
    end
    def fuzzy_search(query)
      return find_by_folder(Dir.pwd) if query.nil? || query.empty?
      matcher = FuzzyMatch.new(@projects, :read => :name)
      matcher.find(query)
    end
  end
end
