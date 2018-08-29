require 'rails_helper'

RSpec.describe Scope, type: :model do
  it 'requires date' do
    scope = Scope.new({ user_id: 1, place: 'paindane' })
    expect(scope.valid?).to be_falsy
  end
end
