
module Proj
  class Project
    attr_accessor :name,:attributes
    def initialize(name,attrs={})
      @name = name
      @attributes = attrs
    end
  end
end
