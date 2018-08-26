class Cleanup < ApplicationRecord
  belongs_to :user
  has_many :items

  after_create :initialize_items

  private

  def initialize_items
    self.items = []

    ItemCategory.each do |category|
      item = Item.new({
        cleanup_id: self.id,
        category: category.code,
        quantity: 0
      })

      self.items << item if item.save
    end
  end
end
