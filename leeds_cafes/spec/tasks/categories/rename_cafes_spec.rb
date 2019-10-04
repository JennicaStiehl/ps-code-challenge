require 'rails_helper'

describe 'category:rename_cafes', type: :rake do

  before :each do
    include 'category'
    include 'import'
    Restaurant.destroy_all
    Rake::Task['import:cafe_data'].invoke
    Restaurant.update_category
  end

  it "is a rake task and is assigned to task" do
    expect(subject).to be_a(Rake::Task)
    expect(subject.name).to eq("category:rename_cafes")
    expect(subject).to eq(task)
    subject.execute
    @cafes = Restaurant.where("category like '%medium'")

    expect(@cafes[0].cafe_name.include?('-')).to eq(true)
    expect(@cafes[1].cafe_name.include?('-')).to eq(true)
    expect(@cafes[2].cafe_name.include?('-')).to eq(true)
  end

end
