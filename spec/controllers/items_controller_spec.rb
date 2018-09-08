require 'rails_helper'

describe ItemsController do
  let(:scope) { FactoryBot.create(:scope) }

  describe 'PATCH items' do
    it 'persists exactly those items that have a count > 0' do
      items = {
        'toothbrush' => '10',
        'fishing_gear' => '6',
      }

      patch :update, params: { id: scope.id, items: items }

      expect(Item.where(scope_id: scope.id).length).to be(2)
      expect(Item.find_by(scope_id: scope.id, category: 'toothbrush').quantity).to be(10)
      expect(Item.find_by(scope_id: scope.id, category: 'fishing_gear').quantity).to be(6)
    end
  end

  describe 'DELETE items' do
    it 'destroys all items belonging to the scope as well as the scope itself' do
      FactoryBot.create(:item, scope_id: scope.id, quantity: 10)

      delete :destroy, params: { id: scope.id }

      expect(Scope.where(id: scope.id).length).to be(0)
      expect(Item.where(scope_id: scope.id).length).to be(0)
    end
  end
end
