require 'rails_helper'

describe ItemsController do
  let(:log) { FactoryBot.create(:log) }

  describe 'PATCH items' do
    it 'persists exactly those items that have a count > 0' do
      items = {
        'toothbrush' => '10',
        'fishing_gear' => '6',
      }

      patch :update, params: { id: log.id, items: items }

      expect(Item.where(scope_id: log.id).length).to be(2)
      expect(Item.find_by(scope_id: log.id, category: 'toothbrush').quantity).to be(10)
      expect(Item.find_by(scope_id: log.id, category: 'fishing_gear').quantity).to be(6)
    end
  end
end
