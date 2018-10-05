require 'rails_helper'

RSpec.describe Place, type: :model do
  it 'is seeded correctly' do
    expect(Place.all.length).to be(2)
    expect(Place.where(id: 1).take.name).to eq('Guinjata')
    expect(Place.where(id: 2).take.name).to eq('Paindane')
  end
end
