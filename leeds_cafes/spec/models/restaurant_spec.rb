require 'rails_helper'
describe Restaurant, type: :model do
  before :each do
    # Restaurant.destroy_all
    @pur_pour = Restaurant.create(cafe_name: 'pur_pour', post_code: 'LS98', number_of_chairs: 5, category: 'ls98 small')
    @tea_time = Restaurant.create(cafe_name: 'tea_time', post_code: 'LS88', number_of_chairs: 10, category: 'ls99 medium')
    @york_tea = Restaurant.create(cafe_name: 'york_tea', post_code: 'LS13', number_of_chairs: 20, category: 'ls13 medium')
    @york_and_humber = Restaurant.create(cafe_name: 'york_and_humber', post_code: 'LS88', number_of_chairs: 105, category: 'ls2 large')
    @prim_and_proper = Restaurant.create(cafe_name: 'prim_and_proper', post_code: 'LS88', number_of_chairs: 100, category: 'LS88 large')
    @fountains_of_tea = Restaurant.create(cafe_name: 'fountains_of_tea', post_code: 'LS2', number_of_chairs: 30, category: 'ls2 medium')
  end
  describe 'validations' do
    it { should validate_presence_of :post_code }
  end

    describe 'class methods' do
      describe '.total_chairs' do
        it 'calculates total number of seats' do
          expect(Restaurant.total_chairs('LS88')).to eq(215)
        end
      end
      describe '.total_places' do
        it 'calculates total number of places' do
          expect(Restaurant.total_places('LS88')).to eq(3)
        end
      end
      describe '.chairs_pct' do
        it 'calculates total percentage of chairs by post code' do
          expect(Restaurant.chairs_pct('LS88')).to eq(71.67)
        end
      end
      describe '.max_chairs' do
        it 'finds the place with the most chairs' do
          expect(Restaurant.max_chairs('LS88')).to eq(105)
        end
      end
    end
end
