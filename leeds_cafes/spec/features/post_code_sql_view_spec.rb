require 'rails_helper'
RSpec.describe 'when vsiting the post_code index page', type: :feature do
  before :each do
    Restaurant.destroy_all
    @all_bar_one_1 = Restaurant.create( id: 1, cafe_name: "All Bar One", street_address: "27 East Parade", post_code: "LS1 5BN", number_of_chairs: 20, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @all_bar_one_2 = Restaurant.create( id: 2, cafe_name: "All Bar One", street_address: "Unit D Electric Press, 4 Millenium Square", post_code: "LS2 3AD", number_of_chairs: 140, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @bagel_nash_1 = Restaurant.create( id: 3, cafe_name: "Bagel Nash", street_address: "34 St. Pauls Street", post_code: "LS1 2AT", number_of_chairs: 14, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @bagel_nash_2 = Restaurant.create( id: 4, cafe_name: "Bagel Nash", street_address: "18 Swan Street", post_code: "LS1 6AZ", number_of_chairs: 18, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @barburrito = Restaurant.create( id: 5, cafe_name: "Barburrito", street_address: "62 The Headrow", post_code: "LS1 8EQ", number_of_chairs: 8, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @bella_italia = Restaurant.create( id: 6, cafe_name: "Bella Italia", street_address: "145 Briggate", post_code: "LS1 6BR", number_of_chairs: 32, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @becketts_bank = Restaurant.create( id: 7, cafe_name: "Becketts Bank (Wetherspoons)", street_address: "28 - 30 Park Row", post_code: "LS1 5HU", number_of_chairs: 6, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @bean_run = Restaurant.create( id: 8, cafe_name: "Bean on the Run", street_address: "Fish Street", post_code: "LS1 6DB", number_of_chairs: 20, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @bhs = Restaurant.create( id: 9, cafe_name: "BHS", street_address: "49 Boar Lane", post_code: "LS1 5EL", number_of_chairs: 6, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    @black_house = Restaurant.create( id: 10, cafe_name: "Black House Grill", street_address: "31 - 33 East Parade", post_code: "LS1 5PS", number_of_chairs: 60, category: nil, created_at: "2019-10-02 19:41:19", updated_at: "2019-10-02 19:41:19")
    Restaurant.update_category
  end
  it 'displays only cafes in the specified postal code' do
    visit '/restaurants/post_code/LS1'

    expect(page).to have_content(@all_bar_one_1.cafe_name)
    expect(page).to have_content(@bagel_nash_1.cafe_name)
    expect(page).to have_content(@barburrito.cafe_name)
    expect(page).to have_content(@bella_italia.cafe_name)
    expect(page).to_not have_content(@all_bar_one_2.street_address)
  end
  it 'displays correct statistics for the post code named' do
    visit '/restaurants/post_code/LS1'

    expect(PostCode.find_by_filter('LS1', 'post_code').count).to eq(9)
    expect(PostCode.total_chairs('LS1', 'post_code')).to eq(184)
    expect(PostCode.total_places('LS1', 'post_code')).to eq(9)
    expect(PostCode.chairs_pct('LS1', 'post_code')).to eq(56.79)
    expect(page).to have_content("Black House Grill - 60")
  end
end
