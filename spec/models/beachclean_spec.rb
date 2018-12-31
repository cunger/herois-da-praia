require 'rails_helper'

RSpec.describe Beachclean, type: :model do
  it 'requires a date' do
    expect(FactoryBot.build(:beachclean, date: '').valid?).to be false
  end

  it 'belongs to a user' do
    expect(FactoryBot.build(:beachclean, user_id: '').valid?).to be false
  end

  it 'is fine without a place' do
    expect(FactoryBot.build(:beachclean, place_id: '').valid?).to be true
  end

  it 'is connected to items that are deleted when the beachclean is deleted' do
    beachclean = FactoryBot.create(:beachclean)
    FactoryBot.create(:item, beachclean_id: beachclean.id, quantity: 10)

    beachclean.destroy

    expect(Beachclean.where(id: beachclean.id).length).to be(0)
    expect(Item.where(beachclean_id: beachclean.id).length).to be(0)
  end

  it 'can estimate the total weight of all items belonging to it' do
    beachclean = FactoryBot.create(:beachclean)
    items = [
      FactoryBot.create(:item, beachclean_id: beachclean.id, category: ItemCategory::TOOTHBRUSH , quantity: 1),
      FactoryBot.create(:item, beachclean_id: beachclean.id, category: ItemCategory::PLASTIC_BOTTLE , quantity: 2),
      FactoryBot.create(:item, beachclean_id: beachclean.id, category: ItemCategory::FISHING_GEAR , quantity: 10),
      FactoryBot.create(:item, beachclean_id: beachclean.id, category: ItemCategory::SHOE , quantity: 1)
    ]

    expect(beachclean.weight_in_gram).to eq(170.45)
  end
end
