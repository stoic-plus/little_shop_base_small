class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = User.find(params[:merchant_id])
    @items = @merchant.items
    render '/dashboard/items/index'
  end

  def new
    @merchant = User.find(params[:merchant_id])
    @item = Item.new
    @form_path = [:admin, @merchant, @item]
    render "/dashboard/items/new"
  end

  def edit
    binding.pry
    @merchant = User.find(params[:merchant_id])
    @item = Item.find(params[:slug])
    @form_path = [:admin, @merchant, @item]
    render "/dashboard/items/edit"
  end

end
