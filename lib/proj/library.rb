require "proj/project"

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
    def to_h()
      hash = {}
      @projects.each do |p|
        hash[p.name] = p.attributes
      end
      hash
    end
  end
end
