require 'rails_helper'

describe LogsController do
  let(:log) { FactoryBot.create(:log) }

  describe 'DELETE log' do
    it 'destroys the log together with all items and observations belonging to that log' do
      FactoryBot.create(:item, log_id: log.id, quantity: 10)
      FactoryBot.create(:observation, log_id: log.id)

      delete :destroy, params: { id: log.id }

      expect(log.where(id: log.id).length).to be(0)
      expect(Item.where(log_id: log.id).length).to be(0)
      expect(Observation.where(log_id: log.id).length).to be(0)
    end
  end
end
