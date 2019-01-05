class User < ApplicationRecord
  has_secure_password

  has_many :items, foreign_key: 'merchant_id'
  has_many :orders
  has_many :order_items, through: :orders

  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true

  enum role: [:default, :merchant, :admin]

  def to_param
    slug
  end

  def self.top_3_revenue_merchants
    User.joins(items: :order_items)
      .select('users.*, sum(order_items.quantity * order_items.price) as revenue')
      .where('order_items.fulfilled=?', true)
      .order('revenue desc')
      .group(:id)
      .limit(3)
  end

  def self.merchant_fulfillment_times(order, count)
    User.joins(items: :order_items)
      .select('users.*, avg(order_items.updated_at - order_items.created_at) as avg_fulfillment_time')
      .where('order_items.fulfilled=?', true)
      .order("avg_fulfillment_time #{order}")
      .group(:id)
      .limit(count)
  end

  def self.top_3_fulfilling_merchants
    merchant_fulfillment_times(:asc, 3)
  end

  def self.bottom_3_fulfilling_merchants
    merchant_fulfillment_times(:desc, 3)
  end

  def self.top_10_merchants_items_sold(current_or_past_month)
    month = self.get_month(current_or_past_month)

    joins("INNER JOIN items on items.merchant_id = users.id
           INNER JOIN order_items ON order_items.item_id = items.id
           INNER JOIN orders ON order_items.order_id = orders.id")
      .select("users.*, SUM(order_items.quantity) as quantity_sold")
      .where("orders.status = 1
              AND order_items.fulfilled = true
              AND extract(month FROM order_items.updated_at) = ?", month)
      .group(:id)
      .order("quantity_sold DESC")
      .limit(10)
  end

  def self.top_10_merchants_orders_fulfilled(current_or_past_month)
    month = self.get_month(current_or_past_month)

    joins("INNER JOIN items on items.merchant_id = users.id
           INNER JOIN order_items ON order_items.item_id = items.id")
      .select("users.*, COUNT(order_items.order_id) as orders_fulfilled")
      .where("order_items.fulfilled = true
              AND extract(month FROM order_items.updated_at) = ?", month)
      .group(:id)
      .order("orders_fulfilled DESC")
      .limit(10)
  end

  def top_5_merchants_item_fulfillment_speed(state_or_city)
    User.joins("INNER JOIN orders on orders.user_id = users.id
                INNER JOIN order_items ON order_items.order_id = orders.id
                INNER JOIN items ON order_items.item_id = items.id")
      .select("users.city, users.state, items.merchant_id as merchant_id,
               AVG(order_items.updated_at - order_items.created_at) as fulfill_speed")
      .where("order_items.fulfilled = true
              AND users.city = '#{self.city}'
              AND users.state = '#{self.state}'")
      .group(:city, :state, "merchant_id")
      .order("fulfill_speed ASC")
      .limit(5)
  end

  def my_pending_orders
    Order.joins(order_items: :item)
      .where("items.merchant_id=? AND orders.status=? AND order_items.fulfilled=?", self.id, 0, false)
  end

  def inventory_check(item_id)
    return nil unless self.merchant?
    Item.where(id: item_id, merchant_id: self.id).pluck(:inventory).first
  end

  def top_items_by_quantity(count)
    self.items
      .joins(:order_items)
      .select('items.*, sum(order_items.quantity) as quantity_sold')
      .where("order_items.fulfilled = ?", true)
      .group(:id)
      .order('quantity_sold desc')
      .limit(count)
  end

  def quantity_sold_percentage
    sold = self.items.joins(:order_items).where('order_items.fulfilled=?', true).sum('order_items.quantity')
    total = self.items.sum(:inventory) + sold
    {
      sold: sold,
      total: total,
      percentage: ((sold.to_f/total)*100).round(2)
    }
  end

  def top_3_states
    Item.joins('inner join order_items oi on oi.item_id=items.id inner join orders o on o.id=oi.order_id inner join users u on o.user_id=u.id')
      .select('u.state, sum(oi.quantity) as quantity_shipped')
      .where("oi.fulfilled = ? AND items.merchant_id=?", true, self.id)
      .group(:state)
      .order('quantity_shipped desc')
      .limit(3)
  end

  def top_3_cities
    Item.joins('inner join order_items oi on oi.item_id=items.id inner join orders o on o.id=oi.order_id inner join users u on o.user_id=u.id')
      .select('u.city, u.state, sum(oi.quantity) as quantity_shipped')
      .where("oi.fulfilled = ? AND items.merchant_id=?", true, self.id)
      .group(:state, :city)
      .order('quantity_shipped desc')
      .limit(3)
  end

  def most_ordering_user
    User.joins('inner join orders o on o.user_id=users.id inner join order_items oi on oi.order_id=o.id inner join items i on i.id=oi.item_id')
      .select('users.*, count(o.id) as order_count')
      .where("oi.fulfilled = ? AND i.merchant_id=?", true, self.id)
      .group(:id)
      .order('order_count desc')
      .limit(1)
      .first
  end

  def most_items_user
    User.joins('inner join orders o on o.user_id=users.id inner join order_items oi on oi.order_id=o.id inner join items i on i.id=oi.item_id')
      .select('users.*, sum(oi.quantity) as item_count')
      .where("oi.fulfilled = ? AND i.merchant_id=?", true, self.id)
      .group(:id)
      .order('item_count desc')
      .limit(1)
      .first
  end

  def top_3_revenue_users
    User.joins('inner join orders o on o.user_id=users.id inner join order_items oi on oi.order_id=o.id inner join items i on i.id=oi.item_id')
      .select('users.*, sum(oi.quantity*oi.price) as revenue')
      .where("oi.fulfilled = ? AND i.merchant_id=?", true, self.id)
      .group(:id)
      .order('revenue desc')
      .limit(3)
  end

  private

  def self.get_month(current_or_past_month)
    month = Time.zone.now.month if current_or_past_month == :current
    month = (Time.zone.now.month - 1) if current_or_past_month == :past
    month = 12 if month == 0
    month
  end

  def self.get_merchant_names(merchant_ids)
    where(id: merchant_ids)
  end
end
