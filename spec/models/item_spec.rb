require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'has the specified average weight in gram' do
    expected_weights = {
      :plastic_fragment_s => 0.11,
      :plastic_fragment_m => 0.45,
      :plastic_fragment_l => 4.5,
      :foam => 6.25,
      :fabric => 22.5,
      :metal_bottle_cap => 2.4,
      :plastic_bottle_cap => 3.13,
      :food_wrapper => 5,
      :fishing_gear => 4.17,
      :plastic_bag => 28.75,
      :shoe => 65,
      :straw => 0.42,
      :toothbrush => 8.75,
      :cigarette_butt => 3.4,
      :aluminum_can => 13.6,
      :plastic_bottle => 27.5,
      :glas_bottle => 465,
      :other => 24.38
    }

    expected_weights.each do |category, weight|
      item = FactoryBot.create(:item, category: category)
      expect(item.weight_in_gram).to eq(weight)
    end
  end
end
