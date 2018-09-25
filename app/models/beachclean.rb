class Beachclean < ApplicationRecord
  belongs_to :user

  has_many :items, :dependent => :destroy

  validates :date, presence: true
  validates :uuid, presence: true

  def place
    Place.find(place_id)
  end

  def estimated_weight
    Item.where(beachclean_id: id)
        .reduce(0) { |sum, item| sum + item.weight }
  end
end
