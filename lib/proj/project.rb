
module Proj
  class Project
    attr_accessor :name,:attributes
    def initialize(name,attrs={})
      @name = name
      @attributes = attrs
    end
    def [](attr)
      @attributes[attr]
    end
    def folder
      File.expand_path(@attributes['folder'] + '/' + @name)      
    end
  end
end
