require 'rails_helper'

describe 'More Merchant Stats - Fulfillment Speed by City/State' do
  before :each do
    @user_1 = create(:user, city: 'Springfield', state: 'CO')
    user_2 = create(:user, state: 'CO')

    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @m4 = create(:merchant)
    @m5 = create(:merchant)
    @m6 = create(:merchant)

    item_1 = create(:item, user: @m1)
    item_2 = create(:item, user: @m2)
    item_3 = create(:item, user: @m3)
    item_4 = create(:item, user: @m4)
    item_5 = create(:item, user: @m5)
    item_6 = create(:item, user: @m6)

    order_1_a = create(:completed_order, user: @user_1)
    oi_1_a = create(:fulfilled_order_item, order: order_1_a, item: item_1, quantity: 10, created_at: 12.days.ago, updated_at: 1.days.ago)

    order_2_a = create(:completed_order, user: @user_1)
    oi_2_a = create(:fulfilled_order_item, order: order_2_a, item: item_2, quantity: 10, created_at: 11.days.ago, updated_at: 1.days.ago)

    order_3_a = create(:completed_order, user: @user_1)
    oi_3_a = create(:fulfilled_order_item, order: order_3_a, item: item_3, quantity: 10, created_at: 10.days.ago, updated_at: 1.days.ago)

    order_4_a = create(:completed_order, user: @user_1)
    oi_4_a = create(:fulfilled_order_item, order: order_4_a, item: item_4, quantity: 10, created_at: 9.days.ago, updated_at: 1.days.ago)

    order_5_a = create(:completed_order, user: @user_1)
    oi_5_a = create(:fulfilled_order_item, order: order_5_a, item: item_5, quantity: 10, created_at: 8.days.ago, updated_at: 1.days.ago)

    order_6_a = create(:completed_order, user: @user_1)
    oi_6_a = create(:fulfilled_order_item, order: order_6_a, item: item_6, quantity: 10, created_at: 7.days.ago, updated_at: 1.days.ago)


    order_1_b = create(:completed_order, user: user_2)
    oi_1_b = create(:fulfilled_order_item, order: order_1_b, item: item_2, quantity: 10, created_at: 1.days.ago, updated_at: 4.hours.ago)

    order_2_b = create(:completed_order, user: user_2)
    oi_2_b = create(:fulfilled_order_item, order: order_2_b, item: item_2, quantity: 10, created_at: 1.days.ago, updated_at: 4.hours.ago)

    order_3_b = create(:completed_order, user: user_2)
    oi_3_b = create(:fulfilled_order_item, order: order_3_b, item: item_2, quantity: 10, created_at: 1.days.ago, updated_at: 4.hours.ago)

    order_4_b = create(:completed_order, user: user_2)
    oi_4_b = create(:fulfilled_order_item, order: order_4_b, item: item_3, quantity: 10, created_at: 1.days.ago, updated_at: 1.hours.ago)

    order_5_b = create(:completed_order, user: user_2)
    oi_5_b = create(:fulfilled_order_item, order: order_5_b, item: item_3, quantity: 10, created_at: 1.days.ago, updated_at: 1.hours.ago)

    order_6_b = create(:completed_order, user: user_2)
    oi_6_b = create(:fulfilled_order_item, order: order_6_b, item: item_3, quantity: 10, created_at: 1.days.ago, updated_at: 1.hours.ago)

    @top_5_city = @user_1.top_5_merchants_item_fulfillment_speed_city
    @top_5_state = @user_1.top_5_merchants_item_fulfillment_speed_state
  end
  context 'as a logged in user' do
    it 'shows top_5 merchants for state and city' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      top_5_merchant_ids = @top_5_state.map {|m| m.merchant_id}
      top_merch = User.get_merchant_info(top_5_merchant_ids)

      within ".top-5-stats" do
        within '.top-5-state' do
          expect(page).to have_content("In #{@user_1.state}: ")
          expect(all('.top-merchant-state')[0]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[0]}).first.last}, Fulfillment Time: #{@top_5_state[0].fulfill_speed}")
          expect(all('.top-merchant-state')[1]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[1]}).first.last}, Fulfillment Time: #{@top_5_state[1].fulfill_speed}")
          expect(all('.top-merchant-state')[2]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[2]}).first.last}, Fulfillment Time: #{@top_5_state[2].fulfill_speed}")
          expect(all('.top-merchant-state')[3]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[3]}).first.last}, Fulfillment Time: #{@top_5_state[3].fulfill_speed}")
          expect(all('.top-merchant-state')[4]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[4]}).first.last}, Fulfillment Time: #{@top_5_state[4].fulfill_speed}")
        end

        top_5_merchant_ids = @top_5_city.map {|m| m.merchant_id}
        top_merch = User.get_merchant_info(top_5_merchant_ids)

        within '.top-5-city' do
          expect(page).to have_content("In #{@user_1.city}, #{@user_1.state}: ")
          expect(all('.top-merchant-city')[0]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[0]}).first.last}, Fulfillment Time: #{@top_5_city[0].fulfill_speed}")
          expect(all('.top-merchant-city')[1]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[1]}).first.last}, Fulfillment Time: #{@top_5_city[1].fulfill_speed}")
          expect(all('.top-merchant-city')[2]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[2]}).first.last}, Fulfillment Time: #{@top_5_city[2].fulfill_speed}")
          expect(all('.top-merchant-city')[3]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[3]}).first.last}, Fulfillment Time: #{@top_5_city[3].fulfill_speed}")
          expect(all('.top-merchant-city')[4]).to have_content("Merchant: #{(top_merch.select{|m| m.first == top_5_merchant_ids[4]}).first.last}, Fulfillment Time: #{@top_5_city[4].fulfill_speed}")
        end
      end
    end
  end

  context 'as a visitor' do
    it 'does not show top_5 merchant info' do
      expect(page).to_not have_css("#top_5_stats")
      expect(page).to_not have_css("#top_5_state")
      expect(page).to_not have_css("#top_5_city")
      expect(page).to_not have_css("#top_merchant_state")
      expect(page).to_not have_css("#top_merchant_city")
    end
  end
end
