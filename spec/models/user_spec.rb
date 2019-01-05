require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :orders }
    it { should have_many(:order_items).through(:orders) }
  end

  describe 'class methods' do
    describe 'merchant stats' do
      before :each do
        @user_1 = create(:user, city: 'Denver', state: 'CO')
        @user_2 = create(:user, city: 'NYC', state: 'NY')
        @user_3 = create(:user, city: 'Seattle', state: 'WA')
        @user_4 = create(:user, city: 'Seattle', state: 'FL')

        @merchant_1, @merchant_2, @merchant_3 = create_list(:merchant, 3)
        @item_1 = create(:item, user: @merchant_1)
        @item_2 = create(:item, user: @merchant_2)
        @item_3 = create(:item, user: @merchant_3)

        @order_1 = create(:completed_order, user: @user_1)
        @oi_1 = create(:fulfilled_order_item, item: @item_1, order: @order_1, quantity: 100, price: 100, created_at: 10.minutes.ago, updated_at: 9.minute.ago)

        @order_2 = create(:completed_order, user: @user_2)
        @oi_2 = create(:fulfilled_order_item, item: @item_2, order: @order_2, quantity: 300, price: 300, created_at: 2.days.ago, updated_at: 1.minute.ago)

        @order_3 = create(:completed_order, user: @user_3)
        @oi_3 = create(:fulfilled_order_item, item: @item_3, order: @order_3, quantity: 200, price: 200, created_at: 10.minutes.ago, updated_at: 5.minute.ago)

        @order_4 = create(:completed_order, user: @user_4)
        @oi_4 = create(:fulfilled_order_item, item: @item_3, order: @order_4, quantity: 201, price: 200, created_at: 10.minutes.ago, updated_at: 5.minute.ago)
      end
      it '.top_3_revenue_merchants' do
        expect(User.top_3_revenue_merchants[0]).to eq(@merchant_2)
        expect(User.top_3_revenue_merchants[0].revenue.to_f).to eq(90000.00)
        expect(User.top_3_revenue_merchants[1]).to eq(@merchant_3)
        expect(User.top_3_revenue_merchants[1].revenue.to_f).to eq(80200.00)
        expect(User.top_3_revenue_merchants[2]).to eq(@merchant_1)
        expect(User.top_3_revenue_merchants[2].revenue.to_f).to eq(10000.00)
      end
      it '.merchant_fulfillment_times' do
        expect(User.merchant_fulfillment_times(:asc, 1)).to eq([@merchant_1])
        expect(User.merchant_fulfillment_times(:desc, 2)).to eq([@merchant_2, @merchant_3])
      end
      it '.top_3_fulfilling_merchants' do
        expect(User.top_3_fulfilling_merchants[0]).to eq(@merchant_1)
        aft = User.top_3_fulfilling_merchants[0].avg_fulfillment_time
        expect(aft[0..7]).to eq('00:01:00')
        expect(User.top_3_fulfilling_merchants[1]).to eq(@merchant_3)
        aft = User.top_3_fulfilling_merchants[1].avg_fulfillment_time
        expect(aft[0..7]).to eq('00:05:00')
        expect(User.top_3_fulfilling_merchants[2]).to eq(@merchant_2)
        aft = User.top_3_fulfilling_merchants[2].avg_fulfillment_time
        expect(aft[0..13]).to eq('1 day 23:59:00')
      end
      it '.bottom_3_fulfilling_merchants' do
        expect(User.bottom_3_fulfilling_merchants[0]).to eq(@merchant_2)
        aft = User.bottom_3_fulfilling_merchants[0].avg_fulfillment_time
        expect(aft[0..13]).to eq('1 day 23:59:00')
        expect(User.bottom_3_fulfilling_merchants[1]).to eq(@merchant_3)
        aft = User.bottom_3_fulfilling_merchants[1].avg_fulfillment_time
        expect(aft[0..7]).to eq('00:05:00')
        expect(User.bottom_3_fulfilling_merchants[2]).to eq(@merchant_1)
        aft = User.bottom_3_fulfilling_merchants[2].avg_fulfillment_time
        expect(aft[0..7]).to eq('00:01:00')
      end
    end
  end

  describe 'instance methods' do
    it '.my_pending_orders' do
      merchants = create_list(:merchant, 2)
      item_1 = create(:item, user: merchants[0])
      item_2 = create(:item, user: merchants[1])
      orders = create_list(:order, 3)
      create(:order_item, order: orders[0], item: item_1, price: 1, quantity: 1)
      create(:order_item, order: orders[1], item: item_2, price: 1, quantity: 1)
      create(:order_item, order: orders[2], item: item_1, price: 1, quantity: 1)

      expect(merchants[0].my_pending_orders).to eq([orders[0], orders[2]])
      expect(merchants[1].my_pending_orders).to eq([orders[1]])
    end

    it '.inventory_check' do
      admin = create(:admin)
      user = create(:user)
      merchant = create(:merchant)
      item = create(:item, user: merchant, inventory: 100)

      expect(admin.inventory_check(item.id)).to eq(nil)
      expect(user.inventory_check(item.id)).to eq(nil)
      expect(merchant.inventory_check(item.id)).to eq(item.inventory)
    end

    describe 'merchant stats methods' do
      before :each do
        @user_1 = create(:user, city: 'Springfield', state: 'MO')
        @user_2 = create(:user, city: 'Springfield', state: 'CO')
        @user_3 = create(:user, city: 'Las Vegas', state: 'NV')
        @user_4 = create(:user, city: 'Denver', state: 'CO')

        @merchant = create(:merchant)
        @item_1, @item_2, @item_3, @item_4 = create_list(:item, 4, user: @merchant, inventory: 20)

        @order_1 = create(:completed_order, user: @user_1)
        @oi_1a = create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 2, price: 100)

        @order_2 = create(:completed_order, user: @user_1)
        @oi_1b = create(:fulfilled_order_item, order: @order_2, item: @item_1, quantity: 1, price: 80)

        @order_3 = create(:completed_order, user: @user_2)
        @oi_2 = create(:fulfilled_order_item, order: @order_3, item: @item_2, quantity: 5, price: 60)

        @order_4 = create(:completed_order, user: @user_3)
        @oi_3 = create(:fulfilled_order_item, order: @order_4, item: @item_3, quantity: 3, price: 40)

        @order_5 = create(:completed_order, user: @user_4)
        @oi_4 = create(:fulfilled_order_item, order: @order_5, item: @item_4, quantity: 4, price: 20)
      end
      it '.top_items_by_quantity' do
        expect(@merchant.top_items_by_quantity(5)).to eq([@item_2, @item_4, @item_1, @item_3])
      end
      it '.quantity_sold_percentage' do
        expect(@merchant.quantity_sold_percentage[:sold]).to eq(15)
        expect(@merchant.quantity_sold_percentage[:total]).to eq(95)
        expect(@merchant.quantity_sold_percentage[:percentage]).to eq(15.79)
      end
      it '.top_3_states' do
        expect(@merchant.top_3_states.first.state).to eq('CO')
        expect(@merchant.top_3_states.first.quantity_shipped).to eq(9)
        expect(@merchant.top_3_states.second.state).to eq('MO')
        expect(@merchant.top_3_states.second.quantity_shipped).to eq(3)
        expect(@merchant.top_3_states.third.state).to eq('NV')
        expect(@merchant.top_3_states.third.quantity_shipped).to eq(3)
      end
      it '.top_3_cities' do
        expect(@merchant.top_3_cities.first.city).to eq('Springfield')
        expect(@merchant.top_3_cities.first.state).to eq('CO')
        expect(@merchant.top_3_cities.second.city).to eq('Denver')
        expect(@merchant.top_3_cities.second.state).to eq('CO')
        expect(@merchant.top_3_cities.third.city).to eq('Springfield')
        expect(@merchant.top_3_cities.third.state).to eq('MO')
      end
      it '.most_ordering_user' do
        expect(@merchant.most_ordering_user).to eq(@user_1)
        expect(@merchant.most_ordering_user.order_count).to eq(2)
      end
      it '.most_items_user' do
        expect(@merchant.most_items_user).to eq(@user_2)
        expect(@merchant.most_items_user.item_count).to eq(5)
      end
      it '.top_3_revenue_users' do
        expect(@merchant.top_3_revenue_users[0]).to eq(@user_2)
        expect(@merchant.top_3_revenue_users[0].revenue).to eq(300)
        expect(@merchant.top_3_revenue_users[1]).to eq(@user_1)
        expect(@merchant.top_3_revenue_users[1].revenue).to eq(280)
        expect(@merchant.top_3_revenue_users[2]).to eq(@user_3)
        expect(@merchant.top_3_revenue_users[2].revenue).to eq(120)
      end
    end

    describe "more merchant stats methods for extension - current month" do
      before :each do
        @user_1 = create(:user, city: 'Springfield', state: 'MO')
        @user_2 = create(:user, city: 'Springfield', state: 'CO')
        @user_3 = create(:user, city: 'Las Vegas', state: 'NV')
        @user_4 = create(:user, city: 'Denver', state: 'CO')

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
        @oi_1 = create(:fulfilled_order_item, order: @order_1, item: @item_1, quantity: 10, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_1 = create(:completed_order, user: @user_1)
        @oi_1_1 = create(:fulfilled_order_item, order: @order_1_1, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_2 = create(:completed_order, user: @user_1)
        @oi_1_2 = create(:fulfilled_order_item, order: @order_1_2, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_3 = create(:completed_order, user: @user_1)
        @oi_1_3 = create(:fulfilled_order_item, order: @order_1_3, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_4 = create(:completed_order, user: @user_1)
        @oi_1_4 = create(:fulfilled_order_item, order: @order_1_4, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_5 = create(:completed_order, user: @user_1)
        @oi_1_5 = create(:fulfilled_order_item, order: @order_1_5, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_6 = create(:completed_order, user: @user_1)
        @oi_1_6 = create(:fulfilled_order_item, order: @order_1_6, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_7 = create(:completed_order, user: @user_1)
        @oi_1_7 = create(:fulfilled_order_item, order: @order_1_7, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_8 = create(:completed_order, user: @user_1)
        @oi_1_8 = create(:fulfilled_order_item, order: @order_1_8, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)
        @order_1_9 = create(:completed_order, user: @user_1)
        @oi_1_9 = create(:fulfilled_order_item, order: @order_1_9, item: @item_1, quantity: 1, created_at: 12.days.ago, updated_at: 1.days.ago)

        @order_2 = create(:completed_order, user: @user_1)
        @oi_2 = create(:fulfilled_order_item, order: @order_2, item: @item_2, quantity: 9, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_1 = create(:completed_order, user: @user_1)
        @oi_2_1 = create(:fulfilled_order_item, order: @order_2_1, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_2 = create(:completed_order, user: @user_1)
        @oi_2_2 = create(:fulfilled_order_item, order: @order_2_2, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_3 = create(:completed_order, user: @user_1)
        @oi_2_3 = create(:fulfilled_order_item, order: @order_2_3, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_4 = create(:completed_order, user: @user_1)
        @oi_2_4 = create(:fulfilled_order_item, order: @order_2_4, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_5 = create(:completed_order, user: @user_1)
        @oi_2_5 = create(:fulfilled_order_item, order: @order_2_5, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_6 = create(:completed_order, user: @user_1)
        @oi_2_6 = create(:fulfilled_order_item, order: @order_2_6, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_7 = create(:completed_order, user: @user_1)
        @oi_2_7 = create(:fulfilled_order_item, order: @order_2_7, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)
        @order_2_8 = create(:completed_order, user: @user_1)
        @oi_2_8 = create(:fulfilled_order_item, order: @order_2_8, item: @item_2, quantity: 1, created_at: 11.days.ago, updated_at: 1.days.ago)

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

        @order_10 = create(:completed_order, user: @user_3)
        @oi_10 = create(:fulfilled_order_item, order: @order_10, item: @item_10, quantity: 2, created_at: 3.days.ago, updated_at: 1.days.ago)

        @order_11 = create(:completed_order, user: @user_3)
        @oi_11 = create(:fulfilled_order_item, order: @order_11, item: @item_11, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)


        @order_12 = create(:order, user: @user_4)
        @oi_12 = create(:order_item, order: @order_12, item: @item_8, quantity: 70, created_at: 4.days.ago, updated_at: 1.days.ago)

        @order_13 = create(:completed_order, user: @user_2)
        @oi_13 = create(:fulfilled_order_item, order: @order_13, item: @item_11, quantity: 45, created_at: 71.days.ago, updated_at: 70.days.ago)
      end
      it '.top_10_merchants_items_sold' do
        returned = User.top_10_merchants_items_sold(:current)
        expect(returned).to eq([@m1, @m2, @m3, @m4, @m5, @m6, @m7, @m8, @m9, @m10])
      end

      xit '.top_10_merchants_orders_fulfilled' do
        expect(User.top_10_merchants_orders_fulfilled(:current)).to eq([@m1, @m2, @m3, @m4, @m5, @m6, @m7, @m8, @m9, @m10])
      end

      xit '.top_5_merchants_item_fulfillment_speed' do
        expect(User.top_5_merchants_item_fulfillment_speed(:current)).to eq([@m11, @m10, @m9, @m8, @m7])
      end
    end
end
end
