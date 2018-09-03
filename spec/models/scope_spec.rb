require 'rails_helper'

RSpec.describe Scope, type: :model do
  it 'is fine if it has a user and a date' do
    expect(FactoryBot.build(:scope, place: '').valid?).to be true
  end

  it 'requires a date' do
    expect(FactoryBot.build(:scope, date: '').valid?).to be false
  end

  it 'belongs to a user' do
    expect(FactoryBot.build(:scope, user_id: '').valid?).to be false
  end
end
