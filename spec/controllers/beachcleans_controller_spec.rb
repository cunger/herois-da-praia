require 'rails_helper'

describe BeachcleansController do
  let(:beachclean) { FactoryBot.create(:beachclean) }

  describe 'SHOW beachclean' do
    it 'hands all items belonging to that beachclean to the view, '\
       'together with items with quantity 0 for all remaining categories' do

      toothbrushes = FactoryBot.create(:item, beachclean_id: beachclean.id, category: ItemCategory[:toothbrush], quantity: 10)
      fishing_gear = FactoryBot.create(:item, beachclean_id: beachclean.id, category: ItemCategory[:fishing_gear], quantity: 6)

      get :show, params: { uuid: beachclean.uuid }
      items = assigns(:items)

      expect(items).not_to be_empty
      # @items includes the items belonging to the beachclean
      expect(items).to include(toothbrushes)
      expect(items).to include(fishing_gear)
      # @items contains an item for each remaining category, with quantity 0
      ItemCategory.each do |category|
        next if category == ItemCategory[:toothbrush] ||
                category == ItemCategory[:fishing_gear]
        new_item = items.select { |item| item.category == category }
        expect(new_item.length).to be(1)
        expect(new_item.first.quantity).to be(0)
      end
    end
  end

  describe 'SUBMIT beachclean' do
    it 'persists the items, the user, and the place' do
      user_uuid = 'f8670eb3-14eb-460a-8bf7-05e2660e8c85'

      post :submit, params: {
        beachclean_uuid: beachclean.uuid,
        beachclean: {
          _id: beachclean.uuid,
          model: 'beachclean',
          date: '2019-01-01',
          place_id: '',
          place_name: 'Darling Harbour',
          place_latitude: '-33.87',
          place_longitude: '151.2',
          user_uuid: user_uuid,
          submitted: false
        },
        items: {
          0 => {
            _id: 'ed9b4a7f-b1bc-4e23-a66e-4bc87ead9631',
            model: 'item',
            beachclean_uuid: beachclean.uuid,
            category: 'toothbrush',
            quantity: 10
          },
          1 => {
            _id: '376761bb-43bb-4ad3-b785-567e72940e07',
            model: 'item',
            beachclean_uuid: beachclean.uuid,
            category: 'fishing_gear',
            quantity: 6
          }
        }
      }

      expect(User.where(uuid: user_uuid).length).to be(1)
      expect(Place.where(name: 'Darling Harbour').length).to be(1)
      expect(Place.where(name: 'Darling Harbour').take.latitude).to eq(-33.87)
      expect(Place.where(name: 'Darling Harbour').take.longitude).to eq(151.2)
      expect(Item.where(beachclean_id: beachclean.id).length).to be(2)
      expect(Item.find_by(beachclean_id: beachclean.id, category: 'toothbrush').quantity).to be(10)
      expect(Item.find_by(beachclean_id: beachclean.id, category: 'fishing_gear').quantity).to be(6)
    end
  end

  describe 'SIGN beachclean' do
    it 'marks the beachclean as signed and updates the user information' do
      user = FactoryBot.create(:user, id: 47)
      beachclean = FactoryBot.create(:beachclean, uuid: 'eb82850d-d32a-4f6b-a6d9-524b151ad98c', user_id: user.id)

      expect(Beachclean.find(beachclean.id).signed).to be_falsey

      post :create_signature, params: {
        beachclean_uuid: beachclean.uuid,
        group: 'resident',
        name: 'Momo',
        email: 'momo@lto.co.uk'
      }

      expect(Beachclean.find(beachclean.id).signed).to be(true)

      expect(User.find(47).name).to eq('Momo')
      expect(User.find(47).email).to eq('momo@lto.co.uk')
      expect(User.find(47).group).to eq(UserGroup::RESIDENT)
    end
  end
end
