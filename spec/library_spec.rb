require 'spec_helper'

describe Proj::Library do
  before do
    @conf = {test:5}
    @lib = Proj::Library.new(@conf)
  end
  it 'should initialize with a config' do
    @lib.config.should == @conf
  end
  context 'after a project is added' do
    before do
      attrs = {folder:"/tmp"}
      @proj = Proj::Project.new("coolProj",attrs)
      @lib.add_project(@proj)
    end
    it 'should add a project to the projects array' do
      @lib.projects.should include(@proj)
    end
    it 'should be able to serialize to a hash' do 
      hash = @lib.to_h
      hash["coolProj"].should == @proj.attributes
    end
  end
end
