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

GITHUB_Q = "Create a Github repo [Y/N blank for true]"
FOLDER_Q = "Project folder path [blank for /tmp]"

describe Proj::Creator do
  before do
    conf = YAML::load(YAML_CONF)
    @creator = Proj::Creator.new(conf)
  end
  it 'should ask questions in the right format' do
    qs = @creator.questions
    qs.length.should == 2
    qs.should include(GITHUB_Q)
    qs.should include(FOLDER_Q)
  end
  it 'shouldn\'t ask the question if ask is false' do
    @creator.config['github']['ask'] = false
    qs = @creator.questions
    qs.should_not include(GITHUB_Q)
  end
end
