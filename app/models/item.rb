class Item < ApplicationRecord
  belongs_to :cleanup

  restrict_type_of :category, to: ItemCategory

  def category_name
    ItemCategory.coerce(self.category).fullName
  end
end
