class Item < ApplicationRecord
  belongs_to :beachclean

  restrict_type_of :category, to: ItemCategory

  def weight_in_gram
    category.weight_in_gram
  end
end
