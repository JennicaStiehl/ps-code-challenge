require 'rails_helper'

describe 'import:cafe_data', type: :rake do
  before :each do
    Restaurant.destroy_all
  end

  it "is a rake task and is assigned to task" do
    expect(subject).to be_a(Rake::Task)
    expect(subject.name).to eq("import:cafe_data")
    expect(subject).to eq(task)
  end

  it "creates records in the Restaurant class" do
    expect(Restaurant.count).to eq(0)
    subject.execute
    expect(Restaurant.count).to eq(73)
  end
end
