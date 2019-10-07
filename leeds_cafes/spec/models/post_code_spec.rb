require 'rails_helper'
describe PostCode, type: :model do
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
    it { should validate_presence_of :pc_id }
  end

    describe 'class methods' do
      describe '.total_chairs' do
        xit 'calculates total number of seats' do
          expect(PostCode.total_chairs('LS2', 'post_code')).to eq(385)
          expect(PostCode.total_chairs('LS1', 'post_code')).to eq(126)
          expect(PostCode.total_chairs('LS13', 'post_code')).to eq(20)
        end
      end
      describe '.total_places' do
        xit 'calculates total number of places' do
          expect(PostCode.total_places('LS2', 'post_code')).to eq(4)
          expect(PostCode.total_places('LS1', 'post_code')).to eq(3)
          expect(PostCode.total_places('LS13', 'post_code')).to eq(1)
        end
      end
      describe '.chairs_pct' do
        it 'calculates total percentage of chairs by post code' do
          expect(PostCode.chairs_pct('LS1', 'post_code')).to eq(23.73)
          expect(PostCode.chairs_pct('LS2', 'post_code')).to eq(72.5)
          expect(PostCode.chairs_pct('LS13', 'post_code')).to eq(3.77)
        end
      end
    end
end
