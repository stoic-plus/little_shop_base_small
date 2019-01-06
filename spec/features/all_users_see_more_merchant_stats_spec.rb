require "rails_helper"

describe "More Merchant Stats - Items and Orders" do
  before :each do
    travel_to Time.zone.local(2019, 01, 13, 4, 2, 1)

    @user_1 = create(:user, city: 'Springfield', state: 'MO')
    @user_2 = create(:user, city: 'Springfield', state: 'CO')
    @user_3 = create(:user, city: 'Las Vegas', state: 'NV')
    @user_4 = create(:user, city: 'Denver', state: 'CO')

    @admin = create(:admin)

    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @m4 = create(:merchant)
    @m5 = create(:merchant)
    @m6 = create(:merchant)
    @m7 = create(:merchant)
    @m8 = create(:merchant)
    @m9 = create(:merchant)
    @m10 = create(:merchant)
    @m11 = create(:merchant)

    @item_1 = create(:item, user: @m1)
    @item_2 = create(:item, user: @m2)
    @item_3 = create(:item, user: @m3)
    @item_4 = create(:item, user: @m4)
    @item_5 = create(:item, user: @m5)
    @item_6 = create(:item, user: @m6)
    @item_7 = create(:item, user: @m7)
    @item_8 = create(:item, user: @m8)
    @item_9 = create(:item, user: @m9)
    @item_10 = create(:item, user: @m10)
    @item_11 = create(:item, user: @m11)

    @order_1 = create(:completed_order, user: @user_1)
    @oi_1 = create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 10, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_1 = create(:completed_order, user: @user_1)
    @oi_1_1 = create(:fulfilled_order_item, order: @order_1_1, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_2 = create(:completed_order, user: @user_1)
    @oi_1_2 = create(:fulfilled_order_item, order: @order_1_2, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_3 = create(:completed_order, user: @user_1)
    @oi_1_3 = create(:fulfilled_order_item, order: @order_1_3, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_4 = create(:completed_order, user: @user_1)
    @oi_1_4 = create(:fulfilled_order_item, order: @order_1_4, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_5 = create(:completed_order, user: @user_1)
    @oi_1_5 = create(:fulfilled_order_item, order: @order_1_5, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_6 = create(:completed_order, user: @user_1)
    @oi_1_6 = create(:fulfilled_order_item, order: @order_1_6, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_7 = create(:completed_order, user: @user_1)
    @oi_1_7 = create(:fulfilled_order_item, order: @order_1_7, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_8 = create(:completed_order, user: @user_1)
    @oi_1_8 = create(:fulfilled_order_item, order: @order_1_8, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_1_9 = create(:completed_order, user: @user_1)
    @oi_1_9 = create(:fulfilled_order_item, order: @order_1_9, item: @item_1, quantity: 1, created_at: 12.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    
    @order_2 = create(:completed_order, user: @user_1)
    @oi_2 = create(:fulfilled_order_item, order: @order_2, item: @item_2, quantity: 9, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_1 = create(:completed_order, user: @user_1)
    @oi_2_1 = create(:fulfilled_order_item, order: @order_2_1, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_2 = create(:completed_order, user: @user_1)
    @oi_2_2 = create(:fulfilled_order_item, order: @order_2_2, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_3 = create(:completed_order, user: @user_1)
    @oi_2_3 = create(:fulfilled_order_item, order: @order_2_3, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_4 = create(:completed_order, user: @user_1)
    @oi_2_4 = create(:fulfilled_order_item, order: @order_2_4, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_5 = create(:completed_order, user: @user_1)
    @oi_2_5 = create(:fulfilled_order_item, order: @order_2_5, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_6 = create(:completed_order, user: @user_1)
    @oi_2_6 = create(:fulfilled_order_item, order: @order_2_6, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_7 = create(:completed_order, user: @user_1)
    @oi_2_7 = create(:fulfilled_order_item, order: @order_2_7, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)
    @order_2_8 = create(:completed_order, user: @user_1)
    @oi_2_8 = create(:fulfilled_order_item, order: @order_2_8, item: @item_2, quantity: 1, created_at: 11.days.ago - 1.hour - 12.minutes - 30.seconds, updated_at: 1.days.ago - 9.minutes - 20.seconds)

    @order_3 = create(:completed_order, user: @user_2)
    @oi_3 = create(:fulfilled_order_item, order: @order_3, item: @item_3, quantity: 8, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_1 = create(:completed_order, user: @user_2)
    @oi_3_1 = create(:fulfilled_order_item, order: @order_3_1, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_2 = create(:completed_order, user: @user_2)
    @oi_3_2 = create(:fulfilled_order_item, order: @order_3_2, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_3 = create(:completed_order, user: @user_2)
    @oi_3_3 = create(:fulfilled_order_item, order: @order_3_3, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_4 = create(:completed_order, user: @user_2)
    @oi_3_4 = create(:fulfilled_order_item, order: @order_3_4, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_5 = create(:completed_order, user: @user_2)
    @oi_3_5 = create(:fulfilled_order_item, order: @order_3_5, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_6 = create(:completed_order, user: @user_2)
    @oi_3_6 = create(:fulfilled_order_item, order: @order_3_6, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3_7 = create(:completed_order, user: @user_2)
    @oi_3_7 = create(:fulfilled_order_item, order: @order_3_7, item: @item_3, quantity: 1, created_at: 10.days.ago, updated_at: 1.days.ago)

    @order_4 = create(:completed_order, user: @user_3)
    @oi_4 = create(:fulfilled_order_item, order: @order_4, item: @item_4, quantity: 7, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_4_1 = create(:completed_order, user: @user_3)
    @oi_4_1 = create(:fulfilled_order_item, order: @order_4_1, item: @item_4, quantity: 1, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_4_2 = create(:completed_order, user: @user_3)
    @oi_4_2 = create(:fulfilled_order_item, order: @order_4_2, item: @item_4, quantity: 1, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_4_3 = create(:completed_order, user: @user_3)
    @oi_4_3 = create(:fulfilled_order_item, order: @order_4_3, item: @item_4, quantity: 1, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_4_4 = create(:completed_order, user: @user_3)
    @oi_4_4 = create(:fulfilled_order_item, order: @order_4_4, item: @item_4, quantity: 1, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_4_5 = create(:completed_order, user: @user_3)
    @oi_4_5 = create(:fulfilled_order_item, order: @order_4_5, item: @item_4, quantity: 1, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_4_6 = create(:completed_order, user: @user_3)
    @oi_4_6 = create(:fulfilled_order_item, order: @order_4_6, item: @item_4, quantity: 1, created_at: 9.days.ago, updated_at: 1.days.ago)

    @order_5 = create(:completed_order, user: @user_4)
    @oi_5 = create(:fulfilled_order_item, order: @order_5, item: @item_5, quantity: 6, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_5_1 = create(:completed_order, user: @user_4)
    @oi_5_1 = create(:fulfilled_order_item, order: @order_5_1, item: @item_5, quantity: 1, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_5_2 = create(:completed_order, user: @user_4)
    @oi_5_2 = create(:fulfilled_order_item, order: @order_5_2, item: @item_5, quantity: 1, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_5_3 = create(:completed_order, user: @user_4)
    @oi_5_3 = create(:fulfilled_order_item, order: @order_5_3, item: @item_5, quantity: 1, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_5_4 = create(:completed_order, user: @user_4)
    @oi_5_4 = create(:fulfilled_order_item, order: @order_5_4, item: @item_5, quantity: 1, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_5_5 = create(:completed_order, user: @user_4)
    @oi_5_5 = create(:fulfilled_order_item, order: @order_5_5, item: @item_5, quantity: 1, created_at: 8.days.ago, updated_at: 1.days.ago)

    @order_6 = create(:completed_order, user: @user_4)
    @oi_6 = create(:fulfilled_order_item, order: @order_6, item: @item_6, quantity: 5, created_at: 7.days.ago, updated_at: 1.days.ago)
    @order_6_1 = create(:completed_order, user: @user_4)
    @oi_6_1 = create(:fulfilled_order_item, order: @order_6_1, item: @item_6, quantity: 1, created_at: 7.days.ago, updated_at: 1.days.ago)
    @order_6_2 = create(:completed_order, user: @user_4)
    @oi_6_2 = create(:fulfilled_order_item, order: @order_6_2, item: @item_6, quantity: 1, created_at: 7.days.ago, updated_at: 1.days.ago)
    @order_6_3 = create(:completed_order, user: @user_4)
    @oi_6_3 = create(:fulfilled_order_item, order: @order_6_3, item: @item_6, quantity: 1, created_at: 7.days.ago, updated_at: 1.days.ago)
    @order_6_4 = create(:completed_order, user: @user_4)
    @oi_6_4 = create(:fulfilled_order_item, order: @order_6_4, item: @item_6, quantity: 1, created_at: 7.days.ago, updated_at: 1.days.ago)

    @order_7 = create(:completed_order, user: @user_1)
    @oi_7 = create(:fulfilled_order_item, order: @order_7, item: @item_7, quantity: 4, created_at: 6.days.ago, updated_at: 1.days.ago)
    @order_7_1 = create(:completed_order, user: @user_1)
    @oi_7_1 = create(:fulfilled_order_item, order: @order_7_1, item: @item_7, quantity: 1, created_at: 6.days.ago, updated_at: 1.days.ago)
    @order_7_2 = create(:completed_order, user: @user_1)
    @oi_7_2 = create(:fulfilled_order_item, order: @order_7_2, item: @item_7, quantity: 1, created_at: 6.days.ago, updated_at: 1.days.ago)
    @order_7_3 = create(:completed_order, user: @user_1)
    @oi_7_3 = create(:fulfilled_order_item, order: @order_7_3, item: @item_7, quantity: 1, created_at: 6.days.ago, updated_at: 1.days.ago)

    @order_8 = create(:completed_order, user: @user_2)
    @oi_8 = create(:fulfilled_order_item, order: @order_8, item: @item_8, quantity: 3, created_at: 5.days.ago, updated_at: 1.days.ago)
    @order_8_1 = create(:completed_order, user: @user_2)
    @oi_8_1 = create(:fulfilled_order_item, order: @order_8_1, item: @item_8, quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    @order_8_2 = create(:completed_order, user: @user_2)
    @oi_8_2 = create(:fulfilled_order_item, order: @order_8_2, item: @item_8, quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)

    @order_9 = create(:completed_order, user: @user_2)
    @oi_9 = create(:fulfilled_order_item, order: @order_9, item: @item_9, quantity: 2, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_9_1 = create(:completed_order, user: @user_2)
    @oi_9_1 = create(:fulfilled_order_item, order: @order_9_1, item: @item_9, quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)

    @order_10 = create(:completed_order, user: @user_4)
    @oi_10 = create(:fulfilled_order_item, order: @order_10, item: @item_10, quantity: 2, created_at: 3.days.ago, updated_at: 1.days.ago)

    @order_11 = create(:completed_order, user: @user_4)
    @oi_11 = create(:fulfilled_order_item, order: @order_11, item: @item_11, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)


    @order_a = create(:completed_order, user: @user_1)
    @oi_a = create(:fulfilled_order_item, order: @order_a, item: @item_1, quantity: 10, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_1 = create(:completed_order, user: @user_1)
    @oi_a_1 = create(:fulfilled_order_item, order: @order_a_1, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_2 = create(:completed_order, user: @user_1)
    @oi_a_2 = create(:fulfilled_order_item, order: @order_a_2, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_3 = create(:completed_order, user: @user_1)
    @oi_a_3 = create(:fulfilled_order_item, order: @order_a_3, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_4 = create(:completed_order, user: @user_1)
    @oi_a_4 = create(:fulfilled_order_item, order: @order_a_4, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_5 = create(:completed_order, user: @user_1)
    @oi_a_5 = create(:fulfilled_order_item, order: @order_a_5, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_6 = create(:completed_order, user: @user_1)
    @oi_a_6 = create(:fulfilled_order_item, order: @order_a_6, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_7 = create(:completed_order, user: @user_1)
    @oi_a_7 = create(:fulfilled_order_item, order: @order_a_7, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_8 = create(:completed_order, user: @user_1)
    @oi_a_8 = create(:fulfilled_order_item, order: @order_a_8, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)
    @order_a_9 = create(:completed_order, user: @user_1)
    @oi_a_9 = create(:fulfilled_order_item, order: @order_a_9, item: @item_1, quantity: 1, created_at: 42.days.ago, updated_at: 31.days.ago)

    @order_b = create(:completed_order, user: @user_1)
    @oi_b = create(:fulfilled_order_item, order: @order_b, item: @item_2, quantity: 9, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_1 = create(:completed_order, user: @user_1)
    @oi_b_1 = create(:fulfilled_order_item, order: @order_b_1, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_2 = create(:completed_order, user: @user_1)
    @oi_b_2 = create(:fulfilled_order_item, order: @order_b_2, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_3 = create(:completed_order, user: @user_1)
    @oi_b_3 = create(:fulfilled_order_item, order: @order_b_3, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_4 = create(:completed_order, user: @user_1)
    @oi_b_4 = create(:fulfilled_order_item, order: @order_b_4, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_5 = create(:completed_order, user: @user_1)
    @oi_b_5 = create(:fulfilled_order_item, order: @order_b_5, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_6 = create(:completed_order, user: @user_1)
    @oi_b_6 = create(:fulfilled_order_item, order: @order_b_6, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_7 = create(:completed_order, user: @user_1)
    @oi_b_7 = create(:fulfilled_order_item, order: @order_b_7, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)
    @order_b_8 = create(:completed_order, user: @user_1)
    @oi_b_8 = create(:fulfilled_order_item, order: @order_b_8, item: @item_2, quantity: 1, created_at: 41.days.ago, updated_at: 31.days.ago)

    @order_c = create(:completed_order, user: @user_2)
    @oi_c = create(:fulfilled_order_item, order: @order_c, item: @item_3, quantity: 8, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_1 = create(:completed_order, user: @user_2)
    @oi_c_1 = create(:fulfilled_order_item, order: @order_c_1, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_2 = create(:completed_order, user: @user_2)
    @oi_c_2 = create(:fulfilled_order_item, order: @order_c_2, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_3 = create(:completed_order, user: @user_2)
    @oi_c_3 = create(:fulfilled_order_item, order: @order_c_3, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_4 = create(:completed_order, user: @user_2)
    @oi_c_4 = create(:fulfilled_order_item, order: @order_c_4, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_5 = create(:completed_order, user: @user_2)
    @oi_c_5 = create(:fulfilled_order_item, order: @order_c_5, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_6 = create(:completed_order, user: @user_2)
    @oi_c_6 = create(:fulfilled_order_item, order: @order_c_6, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)
    @order_c_7 = create(:completed_order, user: @user_2)
    @oi_c_7 = create(:fulfilled_order_item, order: @order_c_7, item: @item_3, quantity: 1, created_at: 40.days.ago, updated_at: 31.days.ago)

    @order_d = create(:completed_order, user: @user_3)
    @oi_d = create(:fulfilled_order_item, order: @order_d, item: @item_4, quantity: 7, created_at: 39.days.ago, updated_at: 31.days.ago)
    @order_d_1 = create(:completed_order, user: @user_3)
    @oi_d_1 = create(:fulfilled_order_item, order: @order_d_1, item: @item_4, quantity: 1, created_at: 39.days.ago, updated_at: 31.days.ago)
    @order_d_2 = create(:completed_order, user: @user_3)
    @oi_d_2 = create(:fulfilled_order_item, order: @order_d_2, item: @item_4, quantity: 1, created_at: 39.days.ago, updated_at: 31.days.ago)
    @order_d_3 = create(:completed_order, user: @user_3)
    @oi_d_3 = create(:fulfilled_order_item, order: @order_d_3, item: @item_4, quantity: 1, created_at: 39.days.ago, updated_at: 31.days.ago)
    @order_d_4 = create(:completed_order, user: @user_3)
    @oi_d_4 = create(:fulfilled_order_item, order: @order_d_4, item: @item_4, quantity: 1, created_at: 39.days.ago, updated_at: 31.days.ago)
    @order_d_5 = create(:completed_order, user: @user_3)
    @oi_d_5 = create(:fulfilled_order_item, order: @order_d_5, item: @item_4, quantity: 1, created_at: 39.days.ago, updated_at: 31.days.ago)
    @order_d_6 = create(:completed_order, user: @user_3)
    @oi_d_6 = create(:fulfilled_order_item, order: @order_d_6, item: @item_4, quantity: 1, created_at: 39.days.ago, updated_at: 31.days.ago)

    @order_e = create(:completed_order, user: @user_4)
    @oi_e = create(:fulfilled_order_item, order: @order_e, item: @item_5, quantity: 6, created_at: 38.days.ago, updated_at: 31.days.ago)
    @order_e_1 = create(:completed_order, user: @user_4)
    @oi_e_1 = create(:fulfilled_order_item, order: @order_e_1, item: @item_5, quantity: 1, created_at: 38.days.ago, updated_at: 31.days.ago)
    @order_e_2 = create(:completed_order, user: @user_4)
    @oi_e_2 = create(:fulfilled_order_item, order: @order_e_2, item: @item_5, quantity: 1, created_at: 38.days.ago, updated_at: 31.days.ago)
    @order_e_3 = create(:completed_order, user: @user_4)
    @oi_e_3 = create(:fulfilled_order_item, order: @order_e_3, item: @item_5, quantity: 1, created_at: 38.days.ago, updated_at: 31.days.ago)
    @order_e_4 = create(:completed_order, user: @user_4)
    @oi_e_4 = create(:fulfilled_order_item, order: @order_e_4, item: @item_5, quantity: 1, created_at: 38.days.ago, updated_at: 31.days.ago)
    @order_e_5 = create(:completed_order, user: @user_4)
    @oi_e_5 = create(:fulfilled_order_item, order: @order_e_5, item: @item_5, quantity: 1, created_at: 38.days.ago, updated_at: 31.days.ago)

    @order_f = create(:completed_order, user: @user_4)
    @oi_f = create(:fulfilled_order_item, order: @order_f, item: @item_6, quantity: 5, created_at: 37.days.ago, updated_at: 31.days.ago)
    @order_f_1 = create(:completed_order, user: @user_4)
    @oi_f_1 = create(:fulfilled_order_item, order: @order_f_1, item: @item_6, quantity: 1, created_at: 37.days.ago, updated_at: 31.days.ago)
    @order_f_2 = create(:completed_order, user: @user_4)
    @oi_f_2 = create(:fulfilled_order_item, order: @order_f_2, item: @item_6, quantity: 1, created_at: 37.days.ago, updated_at: 31.days.ago)
    @order_f_3 = create(:completed_order, user: @user_4)
    @oi_f_3 = create(:fulfilled_order_item, order: @order_f_3, item: @item_6, quantity: 1, created_at: 37.days.ago, updated_at: 31.days.ago)
    @order_f_4 = create(:completed_order, user: @user_4)
    @oi_f_4 = create(:fulfilled_order_item, order: @order_f_4, item: @item_6, quantity: 1, created_at: 37.days.ago, updated_at: 31.days.ago)

    @order_g = create(:completed_order, user: @user_1)
    @oi_g = create(:fulfilled_order_item, order: @order_g, item: @item_7, quantity: 4, created_at: 36.days.ago, updated_at: 31.days.ago)
    @order_g_1 = create(:completed_order, user: @user_1)
    @oi_g_1 = create(:fulfilled_order_item, order: @order_g_1, item: @item_7, quantity: 1, created_at: 36.days.ago, updated_at: 31.days.ago)
    @order_g_2 = create(:completed_order, user: @user_1)
    @oi_g_2 = create(:fulfilled_order_item, order: @order_g_2, item: @item_7, quantity: 1, created_at: 36.days.ago, updated_at: 31.days.ago)
    @order_g_3 = create(:completed_order, user: @user_1)
    @oi_g_3 = create(:fulfilled_order_item, order: @order_g_3, item: @item_7, quantity: 1, created_at: 36.days.ago, updated_at: 31.days.ago)

    @order_h = create(:completed_order, user: @user_2)
    @oi_h = create(:fulfilled_order_item, order: @order_h, item: @item_8, quantity: 3, created_at: 35.days.ago, updated_at: 31.days.ago)
    @order_h_1 = create(:completed_order, user: @user_2)
    @oi_h_1 = create(:fulfilled_order_item, order: @order_h_1, item: @item_8, quantity: 1, created_at: 35.days.ago, updated_at: 31.days.ago)
    @order_h_2 = create(:completed_order, user: @user_2)
    @oi_h_2 = create(:fulfilled_order_item, order: @order_h_2, item: @item_8, quantity: 1, created_at: 35.days.ago, updated_at: 31.days.ago)

    @order_i = create(:completed_order, user: @user_2)
    @oi_i = create(:fulfilled_order_item, order: @order_i, item: @item_9, quantity: 2, created_at: 34.days.ago, updated_at: 31.days.ago)
    @order_i_1 = create(:completed_order, user: @user_2)
    @oi_i_1 = create(:fulfilled_order_item, order: @order_i_1, item: @item_9, quantity: 1, created_at: 34.days.ago, updated_at: 31.days.ago)

    @order_j = create(:completed_order, user: @user_4)
    @oi_j = create(:fulfilled_order_item, order: @order_j, item: @item_10, quantity: 2, created_at: 33.days.ago, updated_at: 31.days.ago)

    @order_k = create(:completed_order, user: @user_4)
    @oi_k = create(:fulfilled_order_item, order: @order_k, item: @item_11, quantity: 1, created_at: 32.days.ago, updated_at: 31.days.ago)

    @current_top = User.top_10_merchants_items_sold(:current)
    @past_top = User.top_10_merchants_items_sold(:past)

    @current_top_fulfill = User.top_10_merchants_orders_fulfilled(:current)
    @past_top_fulfill = User.top_10_merchants_orders_fulfilled(:past)
  end
  context 'when visiting /merchants' do
    it 'shows a merchant leaderboard - as admin' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit merchants_path

      within '.top-sellers' do
        within '.current-stats' do
          expect(all('.top-seller')[0]).to have_content("Merchant: #{@current_top[0].name}, Items Sold: #{@current_top[0].quantity_sold}")
          expect(all('.top-seller')[1]).to have_content("Merchant: #{@current_top[1].name}, Items Sold: #{@current_top[1].quantity_sold}")
          expect(all('.top-seller')[2]).to have_content("Merchant: #{@current_top[2].name}, Items Sold: #{@current_top[2].quantity_sold}")
          expect(all('.top-seller')[3]).to have_content("Merchant: #{@current_top[3].name}, Items Sold: #{@current_top[3].quantity_sold}")
          expect(all('.top-seller')[4]).to have_content("Merchant: #{@current_top[4].name}, Items Sold: #{@current_top[4].quantity_sold}")
          expect(all('.top-seller')[5]).to have_content("Merchant: #{@current_top[5].name}, Items Sold: #{@current_top[5].quantity_sold}")
          expect(all('.top-seller')[6]).to have_content("Merchant: #{@current_top[6].name}, Items Sold: #{@current_top[6].quantity_sold}")
          expect(all('.top-seller')[7]).to have_content("Merchant: #{@current_top[7].name}, Items Sold: #{@current_top[7].quantity_sold}")
          expect(all('.top-seller')[8]).to have_content("Merchant: #{@current_top[8].name}, Items Sold: #{@current_top[8].quantity_sold}")
          expect(all('.top-seller')[9]).to have_content("Merchant: #{@current_top[9].name}, Items Sold: #{@current_top[9].quantity_sold}")
        end

        within '.past-stats' do
          expect(all('.top-seller-past')[0]).to have_content("Merchant: #{@past_top[0].name}, Items Sold: #{@past_top[0].quantity_sold}")
          expect(all('.top-seller-past')[1]).to have_content("Merchant: #{@past_top[1].name}, Items Sold: #{@past_top[1].quantity_sold}")
          expect(all('.top-seller-past')[2]).to have_content("Merchant: #{@past_top[2].name}, Items Sold: #{@past_top[2].quantity_sold}")
          expect(all('.top-seller-past')[3]).to have_content("Merchant: #{@past_top[3].name}, Items Sold: #{@past_top[3].quantity_sold}")
          expect(all('.top-seller-past')[4]).to have_content("Merchant: #{@past_top[4].name}, Items Sold: #{@past_top[4].quantity_sold}")
          expect(all('.top-seller-past')[5]).to have_content("Merchant: #{@past_top[5].name}, Items Sold: #{@past_top[5].quantity_sold}")
          expect(all('.top-seller-past')[6]).to have_content("Merchant: #{@past_top[6].name}, Items Sold: #{@past_top[6].quantity_sold}")
          expect(all('.top-seller-past')[7]).to have_content("Merchant: #{@past_top[7].name}, Items Sold: #{@past_top[7].quantity_sold}")
          expect(all('.top-seller-past')[8]).to have_content("Merchant: #{@past_top[8].name}, Items Sold: #{@past_top[8].quantity_sold}")
          expect(all('.top-seller-past')[9]).to have_content("Merchant: #{@past_top[9].name}, Items Sold: #{@past_top[9].quantity_sold}")
        end
      end

      within '.top-fulfillers' do
        within '.current-stats' do
          expect(all('.top-fulfiller')[0]).to have_content("Merchant: #{@current_top_fulfill[0].name}, Orders Fulfilled: #{@current_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller')[1]).to have_content("Merchant: #{@current_top_fulfill[1].name}, Orders Fulfilled: #{@current_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller')[2]).to have_content("Merchant: #{@current_top_fulfill[2].name}, Orders Fulfilled: #{@current_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller')[3]).to have_content("Merchant: #{@current_top_fulfill[3].name}, Orders Fulfilled: #{@current_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller')[4]).to have_content("Merchant: #{@current_top_fulfill[4].name}, Orders Fulfilled: #{@current_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller')[5]).to have_content("Merchant: #{@current_top_fulfill[5].name}, Orders Fulfilled: #{@current_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller')[6]).to have_content("Merchant: #{@current_top_fulfill[6].name}, Orders Fulfilled: #{@current_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller')[7]).to have_content("Merchant: #{@current_top_fulfill[7].name}, Orders Fulfilled: #{@current_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller')[8]).to have_content("Merchant: #{@current_top_fulfill[8].name}, Orders Fulfilled: #{@current_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller')[9]).to have_content("Merchant: #{@current_top_fulfill[9].name}, Orders Fulfilled: #{@current_top_fulfill[9].orders_fulfilled}")
        end

        within '.past-stats' do
          expect(all('.top-fulfiller-past')[0]).to have_content("Merchant: #{@past_top_fulfill[0].name}, Orders Fulfilled: #{@past_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[1]).to have_content("Merchant: #{@past_top_fulfill[1].name}, Orders Fulfilled: #{@past_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[2]).to have_content("Merchant: #{@past_top_fulfill[2].name}, Orders Fulfilled: #{@past_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[3]).to have_content("Merchant: #{@past_top_fulfill[3].name}, Orders Fulfilled: #{@past_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[4]).to have_content("Merchant: #{@past_top_fulfill[4].name}, Orders Fulfilled: #{@past_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[5]).to have_content("Merchant: #{@past_top_fulfill[5].name}, Orders Fulfilled: #{@past_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[6]).to have_content("Merchant: #{@past_top_fulfill[6].name}, Orders Fulfilled: #{@past_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[7]).to have_content("Merchant: #{@past_top_fulfill[7].name}, Orders Fulfilled: #{@past_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[8]).to have_content("Merchant: #{@past_top_fulfill[8].name}, Orders Fulfilled: #{@past_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[9]).to have_content("Merchant: #{@past_top_fulfill[9].name}, Orders Fulfilled: #{@past_top_fulfill[9].orders_fulfilled}")
        end
      end
    end

    it 'shows a merchant leaderboard - as a default user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit merchants_path

      within '.top-sellers' do
        within '.current-stats' do
          expect(all('.top-seller')[0]).to have_content("Merchant: #{@current_top[0].name}, Items Sold: #{@current_top[0].quantity_sold}")
          expect(all('.top-seller')[1]).to have_content("Merchant: #{@current_top[1].name}, Items Sold: #{@current_top[1].quantity_sold}")
          expect(all('.top-seller')[2]).to have_content("Merchant: #{@current_top[2].name}, Items Sold: #{@current_top[2].quantity_sold}")
          expect(all('.top-seller')[3]).to have_content("Merchant: #{@current_top[3].name}, Items Sold: #{@current_top[3].quantity_sold}")
          expect(all('.top-seller')[4]).to have_content("Merchant: #{@current_top[4].name}, Items Sold: #{@current_top[4].quantity_sold}")
          expect(all('.top-seller')[5]).to have_content("Merchant: #{@current_top[5].name}, Items Sold: #{@current_top[5].quantity_sold}")
          expect(all('.top-seller')[6]).to have_content("Merchant: #{@current_top[6].name}, Items Sold: #{@current_top[6].quantity_sold}")
          expect(all('.top-seller')[7]).to have_content("Merchant: #{@current_top[7].name}, Items Sold: #{@current_top[7].quantity_sold}")
          expect(all('.top-seller')[8]).to have_content("Merchant: #{@current_top[8].name}, Items Sold: #{@current_top[8].quantity_sold}")
          expect(all('.top-seller')[9]).to have_content("Merchant: #{@current_top[9].name}, Items Sold: #{@current_top[9].quantity_sold}")
        end

        within '.past-stats' do
          expect(all('.top-seller-past')[0]).to have_content("Merchant: #{@past_top[0].name}, Items Sold: #{@past_top[0].quantity_sold}")
          expect(all('.top-seller-past')[1]).to have_content("Merchant: #{@past_top[1].name}, Items Sold: #{@past_top[1].quantity_sold}")
          expect(all('.top-seller-past')[2]).to have_content("Merchant: #{@past_top[2].name}, Items Sold: #{@past_top[2].quantity_sold}")
          expect(all('.top-seller-past')[3]).to have_content("Merchant: #{@past_top[3].name}, Items Sold: #{@past_top[3].quantity_sold}")
          expect(all('.top-seller-past')[4]).to have_content("Merchant: #{@past_top[4].name}, Items Sold: #{@past_top[4].quantity_sold}")
          expect(all('.top-seller-past')[5]).to have_content("Merchant: #{@past_top[5].name}, Items Sold: #{@past_top[5].quantity_sold}")
          expect(all('.top-seller-past')[6]).to have_content("Merchant: #{@past_top[6].name}, Items Sold: #{@past_top[6].quantity_sold}")
          expect(all('.top-seller-past')[7]).to have_content("Merchant: #{@past_top[7].name}, Items Sold: #{@past_top[7].quantity_sold}")
          expect(all('.top-seller-past')[8]).to have_content("Merchant: #{@past_top[8].name}, Items Sold: #{@past_top[8].quantity_sold}")
          expect(all('.top-seller-past')[9]).to have_content("Merchant: #{@past_top[9].name}, Items Sold: #{@past_top[9].quantity_sold}")
        end
      end

      within '.top-fulfillers' do
        within '.current-stats' do
          expect(all('.top-fulfiller')[0]).to have_content("Merchant: #{@current_top_fulfill[0].name}, Orders Fulfilled: #{@current_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller')[1]).to have_content("Merchant: #{@current_top_fulfill[1].name}, Orders Fulfilled: #{@current_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller')[2]).to have_content("Merchant: #{@current_top_fulfill[2].name}, Orders Fulfilled: #{@current_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller')[3]).to have_content("Merchant: #{@current_top_fulfill[3].name}, Orders Fulfilled: #{@current_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller')[4]).to have_content("Merchant: #{@current_top_fulfill[4].name}, Orders Fulfilled: #{@current_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller')[5]).to have_content("Merchant: #{@current_top_fulfill[5].name}, Orders Fulfilled: #{@current_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller')[6]).to have_content("Merchant: #{@current_top_fulfill[6].name}, Orders Fulfilled: #{@current_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller')[7]).to have_content("Merchant: #{@current_top_fulfill[7].name}, Orders Fulfilled: #{@current_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller')[8]).to have_content("Merchant: #{@current_top_fulfill[8].name}, Orders Fulfilled: #{@current_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller')[9]).to have_content("Merchant: #{@current_top_fulfill[9].name}, Orders Fulfilled: #{@current_top_fulfill[9].orders_fulfilled}")
        end

        within '.past-stats' do
          expect(all('.top-fulfiller-past')[0]).to have_content("Merchant: #{@past_top_fulfill[0].name}, Orders Fulfilled: #{@past_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[1]).to have_content("Merchant: #{@past_top_fulfill[1].name}, Orders Fulfilled: #{@past_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[2]).to have_content("Merchant: #{@past_top_fulfill[2].name}, Orders Fulfilled: #{@past_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[3]).to have_content("Merchant: #{@past_top_fulfill[3].name}, Orders Fulfilled: #{@past_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[4]).to have_content("Merchant: #{@past_top_fulfill[4].name}, Orders Fulfilled: #{@past_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[5]).to have_content("Merchant: #{@past_top_fulfill[5].name}, Orders Fulfilled: #{@past_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[6]).to have_content("Merchant: #{@past_top_fulfill[6].name}, Orders Fulfilled: #{@past_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[7]).to have_content("Merchant: #{@past_top_fulfill[7].name}, Orders Fulfilled: #{@past_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[8]).to have_content("Merchant: #{@past_top_fulfill[8].name}, Orders Fulfilled: #{@past_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[9]).to have_content("Merchant: #{@past_top_fulfill[9].name}, Orders Fulfilled: #{@past_top_fulfill[9].orders_fulfilled}")
        end
      end
    end

    it 'shows a merchant leaderboard - as a visitor' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      visit merchants_path

      within '.top-sellers' do
        within '.current-stats' do
          expect(all('.top-seller')[0]).to have_content("Merchant: #{@current_top[0].name}, Items Sold: #{@current_top[0].quantity_sold}")
          expect(all('.top-seller')[1]).to have_content("Merchant: #{@current_top[1].name}, Items Sold: #{@current_top[1].quantity_sold}")
          expect(all('.top-seller')[2]).to have_content("Merchant: #{@current_top[2].name}, Items Sold: #{@current_top[2].quantity_sold}")
          expect(all('.top-seller')[3]).to have_content("Merchant: #{@current_top[3].name}, Items Sold: #{@current_top[3].quantity_sold}")
          expect(all('.top-seller')[4]).to have_content("Merchant: #{@current_top[4].name}, Items Sold: #{@current_top[4].quantity_sold}")
          expect(all('.top-seller')[5]).to have_content("Merchant: #{@current_top[5].name}, Items Sold: #{@current_top[5].quantity_sold}")
          expect(all('.top-seller')[6]).to have_content("Merchant: #{@current_top[6].name}, Items Sold: #{@current_top[6].quantity_sold}")
          expect(all('.top-seller')[7]).to have_content("Merchant: #{@current_top[7].name}, Items Sold: #{@current_top[7].quantity_sold}")
          expect(all('.top-seller')[8]).to have_content("Merchant: #{@current_top[8].name}, Items Sold: #{@current_top[8].quantity_sold}")
          expect(all('.top-seller')[9]).to have_content("Merchant: #{@current_top[9].name}, Items Sold: #{@current_top[9].quantity_sold}")
        end

        within '.past-stats' do
          expect(all('.top-seller-past')[0]).to have_content("Merchant: #{@past_top[0].name}, Items Sold: #{@past_top[0].quantity_sold}")
          expect(all('.top-seller-past')[1]).to have_content("Merchant: #{@past_top[1].name}, Items Sold: #{@past_top[1].quantity_sold}")
          expect(all('.top-seller-past')[2]).to have_content("Merchant: #{@past_top[2].name}, Items Sold: #{@past_top[2].quantity_sold}")
          expect(all('.top-seller-past')[3]).to have_content("Merchant: #{@past_top[3].name}, Items Sold: #{@past_top[3].quantity_sold}")
          expect(all('.top-seller-past')[4]).to have_content("Merchant: #{@past_top[4].name}, Items Sold: #{@past_top[4].quantity_sold}")
          expect(all('.top-seller-past')[5]).to have_content("Merchant: #{@past_top[5].name}, Items Sold: #{@past_top[5].quantity_sold}")
          expect(all('.top-seller-past')[6]).to have_content("Merchant: #{@past_top[6].name}, Items Sold: #{@past_top[6].quantity_sold}")
          expect(all('.top-seller-past')[7]).to have_content("Merchant: #{@past_top[7].name}, Items Sold: #{@past_top[7].quantity_sold}")
          expect(all('.top-seller-past')[8]).to have_content("Merchant: #{@past_top[8].name}, Items Sold: #{@past_top[8].quantity_sold}")
          expect(all('.top-seller-past')[9]).to have_content("Merchant: #{@past_top[9].name}, Items Sold: #{@past_top[9].quantity_sold}")
        end
      end

      within '.top-fulfillers' do
        within '.current-stats' do
          expect(all('.top-fulfiller')[0]).to have_content("Merchant: #{@current_top_fulfill[0].name}, Orders Fulfilled: #{@current_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller')[1]).to have_content("Merchant: #{@current_top_fulfill[1].name}, Orders Fulfilled: #{@current_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller')[2]).to have_content("Merchant: #{@current_top_fulfill[2].name}, Orders Fulfilled: #{@current_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller')[3]).to have_content("Merchant: #{@current_top_fulfill[3].name}, Orders Fulfilled: #{@current_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller')[4]).to have_content("Merchant: #{@current_top_fulfill[4].name}, Orders Fulfilled: #{@current_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller')[5]).to have_content("Merchant: #{@current_top_fulfill[5].name}, Orders Fulfilled: #{@current_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller')[6]).to have_content("Merchant: #{@current_top_fulfill[6].name}, Orders Fulfilled: #{@current_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller')[7]).to have_content("Merchant: #{@current_top_fulfill[7].name}, Orders Fulfilled: #{@current_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller')[8]).to have_content("Merchant: #{@current_top_fulfill[8].name}, Orders Fulfilled: #{@current_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller')[9]).to have_content("Merchant: #{@current_top_fulfill[9].name}, Orders Fulfilled: #{@current_top_fulfill[9].orders_fulfilled}")
        end

        within '.past-stats' do
          expect(all('.top-fulfiller-past')[0]).to have_content("Merchant: #{@past_top_fulfill[0].name}, Orders Fulfilled: #{@past_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[1]).to have_content("Merchant: #{@past_top_fulfill[1].name}, Orders Fulfilled: #{@past_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[2]).to have_content("Merchant: #{@past_top_fulfill[2].name}, Orders Fulfilled: #{@past_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[3]).to have_content("Merchant: #{@past_top_fulfill[3].name}, Orders Fulfilled: #{@past_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[4]).to have_content("Merchant: #{@past_top_fulfill[4].name}, Orders Fulfilled: #{@past_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[5]).to have_content("Merchant: #{@past_top_fulfill[5].name}, Orders Fulfilled: #{@past_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[6]).to have_content("Merchant: #{@past_top_fulfill[6].name}, Orders Fulfilled: #{@past_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[7]).to have_content("Merchant: #{@past_top_fulfill[7].name}, Orders Fulfilled: #{@past_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[8]).to have_content("Merchant: #{@past_top_fulfill[8].name}, Orders Fulfilled: #{@past_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[9]).to have_content("Merchant: #{@past_top_fulfill[9].name}, Orders Fulfilled: #{@past_top_fulfill[9].orders_fulfilled}")
        end
      end
    end

    it 'shows a merchant leaderboard - as a merchant' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m1)
      visit merchants_path

      within '.top-sellers' do
        within '.current-stats' do
          expect(all('.top-seller')[0]).to have_content("Merchant: #{@current_top[0].name}, Items Sold: #{@current_top[0].quantity_sold}")
          expect(all('.top-seller')[1]).to have_content("Merchant: #{@current_top[1].name}, Items Sold: #{@current_top[1].quantity_sold}")
          expect(all('.top-seller')[2]).to have_content("Merchant: #{@current_top[2].name}, Items Sold: #{@current_top[2].quantity_sold}")
          expect(all('.top-seller')[3]).to have_content("Merchant: #{@current_top[3].name}, Items Sold: #{@current_top[3].quantity_sold}")
          expect(all('.top-seller')[4]).to have_content("Merchant: #{@current_top[4].name}, Items Sold: #{@current_top[4].quantity_sold}")
          expect(all('.top-seller')[5]).to have_content("Merchant: #{@current_top[5].name}, Items Sold: #{@current_top[5].quantity_sold}")
          expect(all('.top-seller')[6]).to have_content("Merchant: #{@current_top[6].name}, Items Sold: #{@current_top[6].quantity_sold}")
          expect(all('.top-seller')[7]).to have_content("Merchant: #{@current_top[7].name}, Items Sold: #{@current_top[7].quantity_sold}")
          expect(all('.top-seller')[8]).to have_content("Merchant: #{@current_top[8].name}, Items Sold: #{@current_top[8].quantity_sold}")
          expect(all('.top-seller')[9]).to have_content("Merchant: #{@current_top[9].name}, Items Sold: #{@current_top[9].quantity_sold}")
        end

        within '.past-stats' do
          expect(all('.top-seller-past')[0]).to have_content("Merchant: #{@past_top[0].name}, Items Sold: #{@past_top[0].quantity_sold}")
          expect(all('.top-seller-past')[1]).to have_content("Merchant: #{@past_top[1].name}, Items Sold: #{@past_top[1].quantity_sold}")
          expect(all('.top-seller-past')[2]).to have_content("Merchant: #{@past_top[2].name}, Items Sold: #{@past_top[2].quantity_sold}")
          expect(all('.top-seller-past')[3]).to have_content("Merchant: #{@past_top[3].name}, Items Sold: #{@past_top[3].quantity_sold}")
          expect(all('.top-seller-past')[4]).to have_content("Merchant: #{@past_top[4].name}, Items Sold: #{@past_top[4].quantity_sold}")
          expect(all('.top-seller-past')[5]).to have_content("Merchant: #{@past_top[5].name}, Items Sold: #{@past_top[5].quantity_sold}")
          expect(all('.top-seller-past')[6]).to have_content("Merchant: #{@past_top[6].name}, Items Sold: #{@past_top[6].quantity_sold}")
          expect(all('.top-seller-past')[7]).to have_content("Merchant: #{@past_top[7].name}, Items Sold: #{@past_top[7].quantity_sold}")
          expect(all('.top-seller-past')[8]).to have_content("Merchant: #{@past_top[8].name}, Items Sold: #{@past_top[8].quantity_sold}")
          expect(all('.top-seller-past')[9]).to have_content("Merchant: #{@past_top[9].name}, Items Sold: #{@past_top[9].quantity_sold}")
        end
      end

      within '.top-fulfillers' do
        within '.current-stats' do
          expect(all('.top-fulfiller')[0]).to have_content("Merchant: #{@current_top_fulfill[0].name}, Orders Fulfilled: #{@current_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller')[1]).to have_content("Merchant: #{@current_top_fulfill[1].name}, Orders Fulfilled: #{@current_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller')[2]).to have_content("Merchant: #{@current_top_fulfill[2].name}, Orders Fulfilled: #{@current_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller')[3]).to have_content("Merchant: #{@current_top_fulfill[3].name}, Orders Fulfilled: #{@current_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller')[4]).to have_content("Merchant: #{@current_top_fulfill[4].name}, Orders Fulfilled: #{@current_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller')[5]).to have_content("Merchant: #{@current_top_fulfill[5].name}, Orders Fulfilled: #{@current_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller')[6]).to have_content("Merchant: #{@current_top_fulfill[6].name}, Orders Fulfilled: #{@current_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller')[7]).to have_content("Merchant: #{@current_top_fulfill[7].name}, Orders Fulfilled: #{@current_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller')[8]).to have_content("Merchant: #{@current_top_fulfill[8].name}, Orders Fulfilled: #{@current_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller')[9]).to have_content("Merchant: #{@current_top_fulfill[9].name}, Orders Fulfilled: #{@current_top_fulfill[9].orders_fulfilled}")
        end

        within '.past-stats' do
          expect(all('.top-fulfiller-past')[0]).to have_content("Merchant: #{@past_top_fulfill[0].name}, Orders Fulfilled: #{@past_top_fulfill[0].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[1]).to have_content("Merchant: #{@past_top_fulfill[1].name}, Orders Fulfilled: #{@past_top_fulfill[1].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[2]).to have_content("Merchant: #{@past_top_fulfill[2].name}, Orders Fulfilled: #{@past_top_fulfill[2].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[3]).to have_content("Merchant: #{@past_top_fulfill[3].name}, Orders Fulfilled: #{@past_top_fulfill[3].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[4]).to have_content("Merchant: #{@past_top_fulfill[4].name}, Orders Fulfilled: #{@past_top_fulfill[4].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[5]).to have_content("Merchant: #{@past_top_fulfill[5].name}, Orders Fulfilled: #{@past_top_fulfill[5].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[6]).to have_content("Merchant: #{@past_top_fulfill[6].name}, Orders Fulfilled: #{@past_top_fulfill[6].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[7]).to have_content("Merchant: #{@past_top_fulfill[7].name}, Orders Fulfilled: #{@past_top_fulfill[7].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[8]).to have_content("Merchant: #{@past_top_fulfill[8].name}, Orders Fulfilled: #{@past_top_fulfill[8].orders_fulfilled}")
          expect(all('.top-fulfiller-past')[9]).to have_content("Merchant: #{@past_top_fulfill[9].name}, Orders Fulfilled: #{@past_top_fulfill[9].orders_fulfilled}")
        end
      end
    end
  end
end
