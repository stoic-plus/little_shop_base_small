require 'rails_helper'

describe ApplicationRecord do
  describe 'instance methods' do
    it '#check_for_existing_slug - increments slug if existing slug' do
      i = create(:item, name: 'item NAME')
      expect(i.slug).to eq('item-name')

      i_2 = create(:item, name: 'item NAME')
      expect(i_2.slug).to eq('1-item-name')

      i_3 = create(:item, name: 'item NAME')
      expect(i_3.slug).to eq('2-item-name')
    end
  end
end
