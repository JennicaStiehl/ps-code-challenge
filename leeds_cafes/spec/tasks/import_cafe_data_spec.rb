require 'spec_helper'
require 'rake'
describe 'import cafe data' do
  before :all do
    Rake.application.rake_require "tasks/import"
    Rake::Task.define_task(:environment)
  end

  describe 'output while import is happening' do
    before do
      ImportOutput.stub(:banner)
      ImportOutput.stub(:puts)
    end

    let :run_rake_task do
      Rake::Task["import:cafe_data"].reenable
      Rake.application.invoke_task "import:cafe_data"
    end
  end
end
