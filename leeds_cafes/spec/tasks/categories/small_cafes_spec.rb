require 'rails_helper'

describe 'category:remove_small_cafes', type: :rake do
  let(:file) { './lib/assets/small_cafes.csv' }

  before :each do
    include 'category'
    include 'import'
    Restaurant.destroy_all
    Rake::Task['import:cafe_data'].invoke
    Restaurant.update_category
  end

  it "is can remove small cafes" do
    expect(subject).to be_a(Rake::Task)
    expect(subject.name).to eq("category:remove_small_cafes")
    expect(subject).to eq(task)
    subject.execute
    @all_cafes = Restaurant.all
    @small_cafes = Restaurant.where("category like '%small'")

    expect(@small_cafes.count).to eq(0)
    expect(File).to exist(file)
  end


end
