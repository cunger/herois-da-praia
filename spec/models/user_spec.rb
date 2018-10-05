require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is seeded correctly' do
    expect(User.all.length).to be(3)

    # Default visitor
    expect(User.where(id: 1).take.name).to eq('DEFAULT')
    expect(User.where(id: 1).take.group.code).to eq('visitor')

    # Developer
    expect(User.where(id: 2).take.name).to eq('Christina')
    expect(User.where(id: 2).take.group.code).to eq('dev')

    # LTO staff
    expect(User.where(id: 3).take.name).to eq('LTO')
    expect(User.where(id: 3).take.group.code).to eq('lto_staff')
  end
end
