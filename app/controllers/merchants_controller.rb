class MerchantsController < ApplicationController
  before_action :require_merchant, only: :show

  def index
    flags = {role: :merchant}
    unless current_admin?
      flags[:active] = true
    end
    @merchants = User.where(flags)

    @top_3_revenue_merchants = User.top_3_revenue_merchants
    @top_3_fulfilling_merchants = User.top_3_fulfilling_merchants
    @bottom_3_fulfilling_merchants = User.bottom_3_fulfilling_merchants
    @top_3_states = Order.top_3_states
    @top_3_cities = Order.top_3_cities
    @top_3_quantity_orders = Order.top_3_quantity_orders
    @top_10_merchants_items_sold_current = User.top_10_merchants_items_sold(:current)
    @top_10_merchants_items_sold_past = User.top_10_merchants_items_sold(:past)
    @top_10_merchants_orders_fulfilled_current = User.top_10_merchants_orders_fulfilled(:current)
    @top_10_merchants_orders_fulfilled_past = User.top_10_merchants_orders_fulfilled(:past)
    if current_user
      @city, @state = current_user.city, current_user.state
      @top_5_merch_city = current_user.top_5_merchants_item_fulfillment_speed_city
      @top_5_merch_city_info = User.get_merchant_info(@top_5_merch_city.map {|m| m.merchant_id})
      @top_5_merch_state = current_user.top_5_merchants_item_fulfillment_speed_state
      @top_5_merch_state_info = User.get_merchant_info(@top_5_merch_state.map {|m| m.merchant_id})
    end
  end

  def show
    @merchant = current_user
    @orders = @merchant.my_pending_orders
    @top_5_items = @merchant.top_items_by_quantity(5)
    @qsp = @merchant.quantity_sold_percentage
    @top_3_states = @merchant.top_3_states
    @top_3_cities = @merchant.top_3_cities
    @most_ordering_user = @merchant.most_ordering_user
    @most_items_user = @merchant.most_items_user
    @most_items_user = @merchant.most_items_user
    @top_3_revenue_users = @merchant.top_3_revenue_users
  end

  private

  def require_merchant
    render file: 'errors/not_found', status: 404 unless current_user && current_merchant?
  end
end
