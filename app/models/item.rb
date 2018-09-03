class Item < ApplicationRecord
  belongs_to :scope

  restrict_type_of :category, to: ItemCategory
end
