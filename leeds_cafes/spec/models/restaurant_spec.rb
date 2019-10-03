require 'rails_helper'
describe Restaurant, type: :model do
  before :each do
    Restaurant.destroy_all
    @pur_pour = Restaurant.create(cafe_name: 'pur_pour', post_code: 'LS1 E23', number_of_chairs: 5, category: nil)
    @da_pour = Restaurant.create(cafe_name: 'da_pour', post_code: 'LS1 E21', number_of_chairs: 11, category: nil)
    @lil_pour = Restaurant.create(cafe_name: 'lil_pour', post_code: 'LS1 E22', number_of_chairs: 110, category: nil)
    @tea_time = Restaurant.create(cafe_name: 'tea_time', post_code: 'LS2 D2', number_of_chairs: 10, category: nil)
    @york_tea = Restaurant.create(cafe_name: 'york_tea', post_code: 'LS13 C3', number_of_chairs: 20, category: nil)
    @york_and_humber = Restaurant.create(cafe_name: 'york_and_humber', post_code: 'LS2 R3', number_of_chairs: 105, category: nil)
    @prim_and_proper = Restaurant.create(cafe_name: 'prim_and_proper', post_code: 'LS2 R4', number_of_chairs: 240, category: nil)
    @fountains_of_tea = Restaurant.create(cafe_name: 'fountains_of_tea', post_code: 'LS2 R5', number_of_chairs: 30, category: nil)
    Restaurant.update_category
  end
  describe 'validations' do
    it { should validate_presence_of :post_code }
  end

    describe 'class methods' do
      describe '.total_chairs' do
        it 'calculates total number of seats' do
          expect(Restaurant.total_chairs('LS2')).to eq(385)
          expect(Restaurant.total_chairs('LS1')).to eq(126)
          expect(Restaurant.total_chairs('LS13')).to eq(20)
        end
      end
      describe '.total_places' do
        it 'calculates total number of places' do
          expect(Restaurant.total_places('LS2')).to eq(4)
          expect(Restaurant.total_places('LS1')).to eq(3)
          expect(Restaurant.total_places('LS13')).to eq(1)
        end
      end
      describe '.chairs_pct' do
        it 'calculates total percentage of chairs by post code' do
          expect(Restaurant.chairs_pct('LS1')).to eq(23.73)
          expect(Restaurant.chairs_pct('LS2')).to eq(72.5)
          expect(Restaurant.chairs_pct('LS13')).to eq(3.77)
        end
      end
      describe '.max_chairs' do
        it 'finds the place with the most chairs' do
          cafe13 = Restaurant.max_chairs('LS13').map { |cafe| cafe.most_chairs }
          cafe1 = Restaurant.max_chairs('LS1').map { |cafe| cafe.most_chairs }
          cafe2 = Restaurant.max_chairs('LS2').map { |cafe| cafe.most_chairs }
          expect(cafe13.first).to eq(20)
          expect(cafe2.first).to eq(240)
          expect(cafe1.first).to eq(110)
        end
      end
      describe '.update_category' do
        it 'can update the categories base on size and post code' do
          Restaurant.update_category
          @pur_pour.reload
          expect(@pur_pour.category).to eq('ls1 small')
          @da_pour.reload
          expect(@da_pour.category).to eq('ls1 medium')
          @lil_pour.reload
          expect(@lil_pour.category).to eq('ls1 large')
          @tea_time.reload
          expect(@tea_time.category).to eq('ls2 small')
          @york_tea.reload
          expect(@york_tea.category).to eq('other')
          @york_and_humber.reload
          expect(@york_and_humber.category).to eq('ls2 small')
          @prim_and_proper.reload
          expect(@prim_and_proper.category).to eq('ls2 large')
          @fountains_of_tea.reload
          expect(@fountains_of_tea.category).to eq('ls2 small')
        end
      end
    end
end
