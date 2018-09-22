class Item < ApplicationRecord
  belongs_to :beachclean

  restrict_type_of :category, to: ItemCategory

  def weight
    category.weight
  end
end
