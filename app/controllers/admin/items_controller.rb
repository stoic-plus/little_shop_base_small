class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = User.find_by(slug: params[:merchant_slug])
    binding.pry
    @items = @merchant.items
    render '/dashboard/items/index'
  end

  def new
    @merchant = User.find_by(slug: params[:merchant_slug])
    @item = Item.new
    binding.pry
    @form_path = [:admin, @merchant, @item]
    render "/dashboard/items/new"
  end

  def edit
    @merchant = User.find_by(slug: params[:merchant_slug])
    binding.pry
    @item = Item.find_by(slug: params[:item_slug])
    @form_path = [:admin, @merchant, @item]
    render "/dashboard/items/edit"
  end

end
