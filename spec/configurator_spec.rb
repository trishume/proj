require 'spec_helper'
require 'yaml'

YAML_CONF = <<CONF
---
  folder:
    default: /tmp
    aliases:
      webdev: ~/Development/Webdev
      work: ~/WorkDev
    # don't ask where to put it
    ask: true
  github:
    default: true
CONF

GITHUB_Q = "Create a Github repo [y/n blank for true]"
FOLDER_Q = "Project folder path [blank for /tmp]"

describe Proj::Configurator do
  before do
    conf = YAML::load(YAML_CONF)
    @creator = Proj::Configurator.new(conf)
    @asker = lambda {|q,a| ""}
  end
  it 'should ask questions in the right format' do
    qs = @creator.questions
    qs.size.should == 2
    qs['github'].should == GITHUB_Q
    qs['folder'].should == FOLDER_Q
  end
  it 'shouldn\'t ask the question if ask is false' do
    @creator.config['github']['ask'] = false
    qs = @creator.questions
    qs['github'].should == nil
    qs['folder'].should == FOLDER_Q
  end
  it 'should properly parse question answers' do 
    answers = {
      'github' => 'n',
      'folder' => '~/Desktop/'
    }
    proj = @creator.create(answers,@asker)
    proj['github'].should == false
    proj['folder'].should == '~/Desktop/'
  end
  it 'should handle aliases in answers' do
    answers = {
      'github' => 'y',
      'folder' => 'webdev'
    }
    proj = @creator.create(answers,@asker)
    proj['folder'].should == '~/Development/Webdev'
  end
  it 'should handle nil for default' do
    answers = {
      'github' => nil,
      'folder' => nil
    }
    proj = @creator.create(answers,@asker)
    proj['folder'].should == '/tmp'
  end
end
