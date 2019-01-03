require "rails_helper"

describe "Item Model" do
  before :each do
    @m = create(:merchant)
    @i = create(:item, user: @m)
  end

  it 'does stuff' do
    require "pry"; binding.pry
  end
end
